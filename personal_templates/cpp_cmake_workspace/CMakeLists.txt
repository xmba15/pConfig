cmake_minimum_required(VERSION 3.8)

project(libtemporary_project_name)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(PROJECT_TARGET_LIB_NAME "temporary_project_name")

add_subdirectory(src)

include(temporary_project_name_build_options)
