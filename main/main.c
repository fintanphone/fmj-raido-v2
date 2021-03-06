
/* Persistent Sockets Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/

//fb added
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "freertos/ringbuf.h"

#include <esp_wifi.h>
#include <esp_event.h>
#include <esp_log.h>
#include <esp_system.h>
#include <nvs_flash.h>
#include "esp_netif.h"
#include "esp_eth.h"

//fb added
#include "esp_log.h"
#include "esp_event.h"


#include "protocol_examples_common.h"

#include <esp_http_server.h>
//fb added 
#include <esp_http_client.h>
#include <esp_tls.h>


/* An example to demonstrate persistent sockets, with context maintained across
 * multiple requests on that socket.
 */

//fb added
RingbufHandle_t xRingbuffer;
static const char *TAG = "JSON";


// fb added http event handler
esp_err_t _http_event_handler(esp_http_client_event_t *evt)
{
	switch(evt->event_id) {
		case HTTP_EVENT_ERROR:
			ESP_LOGI(TAG, "HTTP_EVENT_ERROR");
			break;
		case HTTP_EVENT_ON_CONNECTED:
			ESP_LOGI(TAG, "HTTP_EVENT_ON_CONNECTED");
			break;
		case HTTP_EVENT_HEADER_SENT:
			ESP_LOGI(TAG, "HTTP_EVENT_HEADER_SENT");
			break;
		case HTTP_EVENT_ON_HEADER:
			ESP_LOGI(TAG, "HTTP_EVENT_ON_HEADER, key=%s, value=%s", evt->header_key, evt->header_value);
			break;
		case HTTP_EVENT_ON_DATA:
			ESP_LOGI(TAG, "HTTP_EVENT_ON_DATA, len=%d", evt->data_len);
			if (!esp_http_client_is_chunked_response(evt->client)) {
				//char buffer[512];
				char *buffer = malloc(evt->data_len + 1);
				esp_http_client_read(evt->client, buffer, evt->data_len);
				buffer[evt->data_len] = 0;
				//ESP_LOGI(TAG, "buffer=%s", buffer);
				UBaseType_t res = xRingbufferSend(xRingbuffer, buffer, evt->data_len, pdMS_TO_TICKS(1000));
				if (res != pdTRUE) {
					ESP_LOGW(TAG, "Failed to xRingbufferSend");
				}
				free(buffer);
			}
			break;
		case HTTP_EVENT_ON_FINISH:
			ESP_LOGI(TAG, "HTTP_EVENT_ON_FINISH");
			break;
		case HTTP_EVENT_DISCONNECTED:
			ESP_LOGI(TAG, "HTTP_EVENT_DISCONNECTED");
			break;
	}
	return ESP_OK;
}





// Removed by Fint
// static const char *TAG = "example";

/* Function to free context */
static void adder_free_func(void *ctx)
{
    ESP_LOGI(TAG, "/adder Free Context function called");
    free(ctx);
}

/* This handler keeps accumulating data that is posted to it into a per
 * socket/session context. And returns the result.
 */
static esp_err_t adder_post_handler(httpd_req_t *req)
{
    /* Log total visitors */
    unsigned *visitors = (unsigned *)req->user_ctx;
    ESP_LOGI(TAG, "/adder visitor count = %d", ++(*visitors));

    char buf[10];
    char outbuf[50];
    int  ret;

    /* Read data received in the request */
    ret = httpd_req_recv(req, buf, sizeof(buf));
    if (ret <= 0) {
        if (ret == HTTPD_SOCK_ERR_TIMEOUT) {
            httpd_resp_send_408(req);
        }
        return ESP_FAIL;
    }

    buf[ret] = '\0';
    int val = atoi(buf);
    ESP_LOGI(TAG, "/adder handler read %d", val);

    /* Create session's context if not already available */
    if (! req->sess_ctx) {
        ESP_LOGI(TAG, "/adder allocating new session");
        req->sess_ctx = malloc(sizeof(int));
        req->free_ctx = adder_free_func;
        *(int *)req->sess_ctx = 0;
    }

    /* Add the received data to the context */
    int *adder = (int *)req->sess_ctx;
    *adder += val;

    /* Respond with the accumulated value */
    snprintf(outbuf, sizeof(outbuf),"%d", *adder);
    httpd_resp_send(req, outbuf, HTTPD_RESP_USE_STRLEN);
    return ESP_OK;
}

/* This handler gets the present value of the accumulator */
static esp_err_t adder_get_handler(httpd_req_t *req)
{
    /* Log total visitors */
    unsigned *visitors = (unsigned *)req->user_ctx;
    ESP_LOGI(TAG, "/adder visitor count = %d", ++(*visitors));

    char outbuf[50];

    /* Create session's context if not already available */
    if (! req->sess_ctx) {
        ESP_LOGI(TAG, "/adder GET allocating new session");
        req->sess_ctx = malloc(sizeof(int));
        req->free_ctx = adder_free_func;
        *(int *)req->sess_ctx = 0;
    }
    ESP_LOGI(TAG, "/adder GET handler send %d", *(int *)req->sess_ctx);

    /* Respond with the accumulated value */
    snprintf(outbuf, sizeof(outbuf),"%d", *((int *)req->sess_ctx));
    httpd_resp_send(req, outbuf, HTTPD_RESP_USE_STRLEN);
    return ESP_OK;
}

/* This handler resets the value of the accumulator */
static esp_err_t adder_put_handler(httpd_req_t *req)
{
    /* Log total visitors */
    unsigned *visitors = (unsigned *)req->user_ctx;
    ESP_LOGI(TAG, "/adder visitor count = %d", ++(*visitors));

    char buf[10];
    char outbuf[50];
    int  ret;

    /* Read data received in the request */
    ret = httpd_req_recv(req, buf, sizeof(buf));
    if (ret <= 0) {
        if (ret == HTTPD_SOCK_ERR_TIMEOUT) {
            httpd_resp_send_408(req);
        }
        return ESP_FAIL;
    }

    buf[ret] = '\0';
    int val = atoi(buf);
    ESP_LOGI(TAG, "/adder PUT handler read %d", val);

    /* Create session's context if not already available */
    if (! req->sess_ctx) {
        ESP_LOGI(TAG, "/adder PUT allocating new session");
        req->sess_ctx = malloc(sizeof(int));
        req->free_ctx = adder_free_func;
    }
    *(int *)req->sess_ctx = val;

    /* Respond with the reset value */
    snprintf(outbuf, sizeof(outbuf),"%d", *((int *)req->sess_ctx));
    httpd_resp_send(req, outbuf, HTTPD_RESP_USE_STRLEN);
    return ESP_OK;
}

static esp_err_t stations_get_handler(httpd_req_t *req)
{

ESP_LOGI(TAG, "you entered your custom handler");

// Fint code here:

char *simple_response = NULL;
const char *weburl = "http://192.168.0.123/form.html";


esp_http_client_config_t config = {
		.url = weburl,
		.event_handler = _http_event_handler,
	};
	esp_http_client_handle_t client = esp_http_client_init(&config);


esp_err_t err = esp_http_client_perform(client);

// Continue here

if (err == ESP_OK) {
		     ESP_LOGI(TAG, "HTTP GET Status = %d, content_length = %d",
				esp_http_client_get_status_code(client),
				esp_http_client_get_content_length(client));
		  //Receive an item from no-split ring buffer
		     int bufferSize = esp_http_client_get_content_length(client);
		     char *buffer = malloc(bufferSize + 1); 
		     size_t item_size;
		     int	index = 0;
	             while (1) {
			char *item = (char *)xRingbufferReceive(xRingbuffer, &item_size, pdMS_TO_TICKS(1000));
			if (item != NULL) {
					for (int i = 0; i < item_size; i++) {
					//printf("%c", item[i]);
					buffer[index] = item[i];
					index++;
					buffer[index] = 0;
				          }
				//printf("\n");
				//Return Item
				       vRingbufferReturnItem(xRingbuffer, (void *)item);
		 			} 
			else    {
				//Failed to receive item
				ESP_LOGI(TAG, "End of receive item");
				break;
			              }
		             } // End of that While 1 loop
     
                ESP_LOGI(TAG, "buffer=\n%s", buffer);

		httpd_resp_send(req, buffer, strlen(buffer));

		ESP_LOGI(TAG, "Deserialize.....");
		//cJSON *root = cJSON_Parse(buffer);
		//JSON_Parse(root);
		//cJSON_Delete(root);
		free(buffer);

		}// end of the  ESP_OK  if statement 

	else {
		ESP_LOGE(TAG, "HTTP GET request failed: %s", esp_err_to_name(err));
	     }
	esp_http_client_cleanup(client);


httpd_resp_set_status(req, HTTPD_200);
// httpd_resp_set_type(req, "application/json");

// Put some simple text in the buffer which will be sent out as a httpd response

//This was a good pre check
// asprintf(&simple_response,"Hello Simple World");
// httpd_resp_send(req, simple_response, strlen(simple_response));




free(simple_response);

return ESP_OK;

}




/* Maintain a variable which stores the number of times
 * the "/adder" URI has been visited */
static unsigned visitors = 0;

static const httpd_uri_t adder_post = {
    .uri      = "/adder",
    .method   = HTTP_POST,
    .handler  = adder_post_handler,
    .user_ctx = &visitors
};

static const httpd_uri_t adder_get = {
    .uri      = "/adder",
    .method   = HTTP_GET,
    .handler  = adder_get_handler,
    .user_ctx = &visitors
};

static const httpd_uri_t adder_put = {
    .uri      = "/adder",
    .method   = HTTP_PUT,
    .handler  = adder_put_handler,
    .user_ctx = &visitors
};

static const httpd_uri_t stations_get = {
    .uri     = "/stations",
    .method  = HTTP_GET,
    .handler = stations_get_handler,
    .user_ctx = &visitors
};



static httpd_handle_t start_webserver(void)
{
    httpd_config_t config = HTTPD_DEFAULT_CONFIG();
    // Start the httpd server
    ESP_LOGI(TAG, "Starting server on port: '%d'", config.server_port);
    httpd_handle_t server;

    if (httpd_start(&server, &config) == ESP_OK) {
        // Set URI handlers
        ESP_LOGI(TAG, "Registering URI handlers");
        httpd_register_uri_handler(server, &adder_get);
        httpd_register_uri_handler(server, &adder_put);
        httpd_register_uri_handler(server, &adder_post);
        httpd_register_uri_handler(server, &stations_get);
        return server;
    }

    ESP_LOGI(TAG, "Error starting server!");
    return NULL;
}

static void stop_webserver(httpd_handle_t server)
{
    // Stop the httpd server
    httpd_stop(server);
}


static void disconnect_handler(void* arg, esp_event_base_t event_base,
                               int32_t event_id, void* event_data)
{
    httpd_handle_t* server = (httpd_handle_t*) arg;
    if (*server) {
        ESP_LOGI(TAG, "Stopping webserver");
        stop_webserver(*server);
        *server = NULL;
    }
}

static void connect_handler(void* arg, esp_event_base_t event_base,
                            int32_t event_id, void* event_data)
{
    httpd_handle_t* server = (httpd_handle_t*) arg;
    if (*server == NULL) {
        ESP_LOGI(TAG, "Starting webserver");
        *server = start_webserver();
    }
}


void app_main(void)
{
    static httpd_handle_t server = NULL;

    ESP_ERROR_CHECK(nvs_flash_init());
    ESP_ERROR_CHECK(esp_netif_init());
    ESP_ERROR_CHECK(esp_event_loop_create_default());

    /* This helper function configures Wi-Fi or Ethernet, as selected in menuconfig.
     * Read "Establishing Wi-Fi or Ethernet Connection" section in
     * examples/protocols/README.md for more information about this function.
     */
    ESP_ERROR_CHECK(example_connect());

    /* Register event handlers to stop the server when Wi-Fi or Ethernet is disconnected,
     * and re-start it upon connection.
     */
#ifdef CONFIG_EXAMPLE_CONNECT_WIFI
    ESP_ERROR_CHECK(esp_event_handler_register(IP_EVENT, IP_EVENT_STA_GOT_IP, &connect_handler, &server));
    ESP_ERROR_CHECK(esp_event_handler_register(WIFI_EVENT, WIFI_EVENT_STA_DISCONNECTED, &disconnect_handler, &server));
#endif // CONFIG_EXAMPLE_CONNECT_WIFI
#ifdef CONFIG_EXAMPLE_CONNECT_ETHERNET
    ESP_ERROR_CHECK(esp_event_handler_register(IP_EVENT, IP_EVENT_ETH_GOT_IP, &connect_handler, &server));
    ESP_ERROR_CHECK(esp_event_handler_register(ETH_EVENT, ETHERNET_EVENT_DISCONNECTED, &disconnect_handler, &server));
#endif // CONFIG_EXAMPLE_CONNECT_ETHERNET

	xRingbuffer = xRingbufferCreate(1024, RINGBUF_TYPE_NOSPLIT);
	
	//Check everything was created
	configASSERT( xRingbuffer );




    /* Start the server for the first time */
    server = start_webserver();
}
