#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0)

message("## Normal Variable")
set(normal_variable 1)
message("\${normal_variable}: ${normal_variable}")
unset(normal_variable)

message(\n)
message("## Cache Variable")
set(cache_variable 2 CACHE INTERNAL description)
message("\${cache_variable}: ${cache_variable}")
message("\$CACHE{cache_variable}: $CACHE{cache_variable}")
unset(cache_variable CACHE)
message("\${cache_variable}: ${cache_variable}")

message(\n)
message("## Environment Variable")
set(ENV{environment_variable} 3)
message("\$ENV{environment_variable}: $ENV{environment_variable}")
unset(ENV{environment_variable})
