# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/geeko/.espressif/tools/cmake/3.16.4/bin/cmake

# The command to remove a file.
RM = /home/geeko/.espressif/tools/cmake/3.16.4/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/geeko/esp/code/webserver

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/geeko/esp/code/webserver

# Include any dependencies generated for this target.
include esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/depend.make

# Include the progress variables for this target.
include esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/progress.make

# Include the compile flags for this target's objects.
include esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/flags.make

x509_crt_bundle.S: /home/geeko/esp/esp-idf/tools/cmake/scripts/data_file_embed_asm.cmake
x509_crt_bundle.S: esp-idf/mbedtls/x509_crt_bundle
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/geeko/esp/code/webserver/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating ../../x509_crt_bundle.S"
	/home/geeko/.espressif/tools/cmake/3.16.4/bin/cmake -D DATA_FILE=/home/geeko/esp/code/webserver/esp-idf/mbedtls/x509_crt_bundle -D SOURCE_FILE=/home/geeko/esp/code/webserver/x509_crt_bundle.S -D FILE_TYPE=BINARY -P /home/geeko/esp/esp-idf/tools/cmake/scripts/data_file_embed_asm.cmake

esp-idf/mbedtls/x509_crt_bundle:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/geeko/esp/code/webserver/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating x509_crt_bundle"
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && python /home/geeko/esp/esp-idf/components/mbedtls/esp_crt_bundle/gen_crt_bundle.py --input /home/geeko/esp/esp-idf/components/mbedtls/esp_crt_bundle/cacrt_all.pem -q

esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.obj: esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/flags.make
esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.obj: /home/geeko/esp/esp-idf/components/mbedtls/esp_crt_bundle/esp_crt_bundle.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/geeko/esp/code/webserver/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.obj"
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && /home/geeko/.espressif/tools/xtensa-esp32-elf/esp-2020r3-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.obj   -c /home/geeko/esp/esp-idf/components/mbedtls/esp_crt_bundle/esp_crt_bundle.c

esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.i"
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && /home/geeko/.espressif/tools/xtensa-esp32-elf/esp-2020r3-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/geeko/esp/esp-idf/components/mbedtls/esp_crt_bundle/esp_crt_bundle.c > CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.i

esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.s"
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && /home/geeko/.espressif/tools/xtensa-esp32-elf/esp-2020r3-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/geeko/esp/esp-idf/components/mbedtls/esp_crt_bundle/esp_crt_bundle.c -o CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.s

esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/__/__/x509_crt_bundle.S.obj: esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/flags.make
esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/__/__/x509_crt_bundle.S.obj: x509_crt_bundle.S
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/geeko/esp/code/webserver/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building ASM object esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/__/__/x509_crt_bundle.S.obj"
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && /home/geeko/.espressif/tools/xtensa-esp32-elf/esp-2020r3-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/__idf_mbedtls.dir/__/__/x509_crt_bundle.S.obj -c /home/geeko/esp/code/webserver/x509_crt_bundle.S

# Object files for target __idf_mbedtls
__idf_mbedtls_OBJECTS = \
"CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.obj" \
"CMakeFiles/__idf_mbedtls.dir/__/__/x509_crt_bundle.S.obj"

# External object files for target __idf_mbedtls
__idf_mbedtls_EXTERNAL_OBJECTS =

esp-idf/mbedtls/libmbedtls.a: esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/esp_crt_bundle/esp_crt_bundle.c.obj
esp-idf/mbedtls/libmbedtls.a: esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/__/__/x509_crt_bundle.S.obj
esp-idf/mbedtls/libmbedtls.a: esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/build.make
esp-idf/mbedtls/libmbedtls.a: esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/geeko/esp/code/webserver/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C static library libmbedtls.a"
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && $(CMAKE_COMMAND) -P CMakeFiles/__idf_mbedtls.dir/cmake_clean_target.cmake
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/__idf_mbedtls.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/build: esp-idf/mbedtls/libmbedtls.a

.PHONY : esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/build

esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/clean:
	cd /home/geeko/esp/code/webserver/esp-idf/mbedtls && $(CMAKE_COMMAND) -P CMakeFiles/__idf_mbedtls.dir/cmake_clean.cmake
.PHONY : esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/clean

esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/depend: x509_crt_bundle.S
esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/depend: esp-idf/mbedtls/x509_crt_bundle
	cd /home/geeko/esp/code/webserver && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/geeko/esp/code/webserver /home/geeko/esp/esp-idf/components/mbedtls /home/geeko/esp/code/webserver /home/geeko/esp/code/webserver/esp-idf/mbedtls /home/geeko/esp/code/webserver/esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : esp-idf/mbedtls/CMakeFiles/__idf_mbedtls.dir/depend
