#!/usr/bin/env cmake -P
# see: https://github.com/sakra/cotire
cmake_minimum_required(VERSION 3.0.2)

include(${CMAKE_CURRENT_LIST_DIR}/../_execute.cmake)
execute_cmake(-DCOTIRE_MINIMUM_NUMBER_OF_TARGET_SOURCES=1)
execute(make)
