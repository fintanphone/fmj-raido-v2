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

# Utility rule file for menuconfig.

# Include the progress variables for this target.
include CMakeFiles/menuconfig.dir/progress.make

CMakeFiles/menuconfig:
	python /home/geeko/esp/esp-idf/tools/kconfig_new/prepare_kconfig_files.py --env-file /home/geeko/esp/code/webserver/config.env
	python /home/geeko/esp/esp-idf/tools/kconfig_new/confgen.py --kconfig /home/geeko/esp/esp-idf/Kconfig --sdkconfig-rename /home/geeko/esp/esp-idf/sdkconfig.rename --config /home/geeko/esp/code/webserver/sdkconfig --env-file /home/geeko/esp/code/webserver/config.env --env IDF_TARGET=esp32 --env IDF_ENV_FPGA= --dont-write-deprecated --output config /home/geeko/esp/code/webserver/sdkconfig
	python /home/geeko/esp/esp-idf/tools/check_term.py
	/home/geeko/.espressif/tools/cmake/3.16.4/bin/cmake -E env COMPONENT_KCONFIGS_SOURCE_FILE=/home/geeko/esp/code/webserver/kconfigs.in COMPONENT_KCONFIGS_PROJBUILD_SOURCE_FILE=/home/geeko/esp/code/webserver/kconfigs_projbuild.in IDF_CMAKE=y KCONFIG_CONFIG=/home/geeko/esp/code/webserver/sdkconfig IDF_TARGET=esp32 IDF_ENV_FPGA= python -m menuconfig /home/geeko/esp/esp-idf/Kconfig
	python /home/geeko/esp/esp-idf/tools/kconfig_new/confgen.py --kconfig /home/geeko/esp/esp-idf/Kconfig --sdkconfig-rename /home/geeko/esp/esp-idf/sdkconfig.rename --config /home/geeko/esp/code/webserver/sdkconfig --env-file /home/geeko/esp/code/webserver/config.env --env IDF_TARGET=esp32 --env IDF_ENV_FPGA= --output config /home/geeko/esp/code/webserver/sdkconfig

menuconfig: CMakeFiles/menuconfig
menuconfig: CMakeFiles/menuconfig.dir/build.make

.PHONY : menuconfig

# Rule to build all files generated by this target.
CMakeFiles/menuconfig.dir/build: menuconfig

.PHONY : CMakeFiles/menuconfig.dir/build

CMakeFiles/menuconfig.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/menuconfig.dir/cmake_clean.cmake
.PHONY : CMakeFiles/menuconfig.dir/clean

CMakeFiles/menuconfig.dir/depend:
	cd /home/geeko/esp/code/webserver && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/geeko/esp/code/webserver /home/geeko/esp/code/webserver /home/geeko/esp/code/webserver /home/geeko/esp/code/webserver /home/geeko/esp/code/webserver/CMakeFiles/menuconfig.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/menuconfig.dir/depend

