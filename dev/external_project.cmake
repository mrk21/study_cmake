#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

include(${CMAKE_CURRENT_LIST_DIR}/../_execute.cmake)
set(ENV{VERBOSE} 1)
execute_cmake()
execute(make)
