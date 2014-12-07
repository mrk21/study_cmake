#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

message("## Normal Variable")
set(normal_variable 1)
message("\${normal_variable}: ${normal_variable}")
unset(normal_variable)

message("")
message([[## Cache Variable]])

set(cache_variable 2 CACHE INTERNAL description)
message("\${cache_variable}: ${cache_variable}")
message("\$CACHE{cache_variable}: $CACHE{cache_variable}")
unset(cache_variable CACHE)
message("\${cache_variable}: ${cache_variable}")
message("")

function(verify_cache_impl)
  get_property(value CACHE cache_value PROPERTY VALUE)
  get_property(type CACHE cache_value PROPERTY TYPE)
  get_property(desc CACHE cache_value PROPERTY HELPSTRING)
  message("cache_value: ${cache_value}")
  message("cache_value[value]: ${value}")
  message("cache_value[type]: ${type}")
  message("cache_value[desc]: ${desc}")
  message("")
endfunction()

function(verify_cache type)
  message("### verify_cache: ${type}")
  unset(cache_value CACHE)
  
  message("set(cache_value 1 CACHE ${type} description_1)")
  set(cache_value 1 CACHE ${type} description_1)
  verify_cache_impl()
  
  message("set(cache_value 2 CACHE ${type} description_2)")
  set(cache_value 2 CACHE ${type} description_2)
  verify_cache_impl()
  
  message("set(cache_value 3 CACHE ${type} description_3 FORCE)")
  set(cache_value 3 CACHE ${type} description_3 FORCE)
  verify_cache_impl()
  
  message("set_property(CACHE cache_value PROPERTY HELPSTRING description_4)")
  set_property(CACHE cache_value PROPERTY HELPSTRING description_4)
  verify_cache_impl()
  
  message("set_property(CACHE cache_value PROPERTY VALUE 4)")
  set_property(CACHE cache_value PROPERTY VALUE 4)
  verify_cache_impl()
  
  message("set_property(CACHE cache_value PROPERTY TYPE INTERNAL)")
  set_property(CACHE cache_value PROPERTY TYPE INTERNAL)
  verify_cache_impl()
  
  message("set(cache_value 5 CACHE ${type} description_2)")
  set(cache_value 5 CACHE ${type} description_2)
  verify_cache_impl()
endfunction()

verify_cache(STRING)
verify_cache(INTERNAL)


message(\n)
message("## Environment Variable")
set(ENV{environment_variable} 3)
message("\$ENV{environment_variable}: $ENV{environment_variable}")
unset(ENV{environment_variable})
