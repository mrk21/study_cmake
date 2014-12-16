#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

include(${CMAKE_CURRENT_LIST_DIR}/../_execute.cmake)
cmake_host_system_information(RESULT core_size QUERY NUMBER_OF_LOGICAL_CORES)
execute_cmake()
execute(make -j${core_size})
execute(make test "ARGS=-V -C Debug -j ${core_size}")
