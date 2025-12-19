cmake_minimum_required(VERSION 3.25)
project(
	mde
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/mdecmake/cmake)

include(CheckIncludeFiles)

check_include_files(paths.h HAS_PATHS_H)

include(GNUInstallDirs)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_FULL_LIBDIR}")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
configure_file(include/config.h.in config.h)
configure_file(wizard.sh.in wizard.sh)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_subdirectory(external/milsko)

include_directories(external)

add_subdirectory(mdeartworks)
add_subdirectory(mdelibs)
if(NOT CMAKE_SYSTEM_NAME STREQUAL "Windows")
add_subdirectory(mdebase)
endif()
add_subdirectory(mdeutils)
