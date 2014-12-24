#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

if("123-dd" MATCHES [[([0-9]+)-dd]])
  message("$1: ${CMAKE_MATCH_1}") # $1: 123
endif()

string(REGEX REPLACE [[([0-9]+)-dd]] [[\1]] replaced "123-dd")
message("replaced: ${replaced}") # replaced: 123
