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

option(USE_SYSTEM_MILSKO "Use system Milsko" OFF)
option(USE_SYSTEM_XEMIL "Use system Xemil" OFF)

macro(setup_sys_libs)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -I${CMAKE_INSTALL_FULL_INCLUDEDIR}")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L${CMAKE_INSTALL_FULL_LIBDIR} -Wl,-R${CMAKE_INSTALL_FULL_LIBDIR}")
	set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -L${CMAKE_INSTALL_FULL_LIBDIR} -Wl,-R${CMAKE_INSTALL_FULL_LIBDIR}")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -L${CMAKE_INSTALL_FULL_LIBDIR} -Wl,-R${CMAKE_INSTALL_FULL_LIBDIR}")
	set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} -L${CMAKE_INSTALL_FULL_LIBDIR} -Wl,-R${CMAKE_INSTALL_FULL_LIBDIR}")
endmacro()

if(USE_SYSTEM_MILSKO)
	setup_sys_libs()
else()
	add_subdirectory(external/milsko)
endif()

if(USE_SYSTEM_XEMIL)
	setup_sys_libs()
else()
	add_subdirectory(external/xemil)
endif()

include_directories(external)

add_subdirectory(mdeartworks)
add_subdirectory(mdelibs)
if(NOT CMAKE_SYSTEM_NAME STREQUAL "Windows")
add_subdirectory(mdebase)
endif()
add_subdirectory(mdeutils)
add_subdirectory(mdecmake)
