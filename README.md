# HTTPD Server - Select Radio Station from HTML Combo box.  

Radio station full list is maintained in JSON format

- Started with Persistent Sockets demo
- Created a new handler (stations_get) for url : /local ip/stations
        - This handler currently just prints out Hello Simple World

Next Steps:
- This handler will read from a fixed web server with station list.
  Any item selected from list will be handled by a new POST handler
  which will be used to select stations, change stations, stop and 
  start stream etc.

With this configuration the ESP32 could get list of radio stations
from any simple static webserver with an easy to manage JSON list of urls.
ESP32 will present this list on its own webserver for user selection

Note: This was originally HTTPD Server Persistent Sockets IDF Example
