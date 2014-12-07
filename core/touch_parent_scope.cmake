#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

# The PARENT_SCOPE option of set() and unset() commands make it possible to edit variables of the parent context.
# see: http://www.cmake.org/cmake/help/v3.0/command/set.html

function(set_value output_variable value)
  set(${output_variable} ${value} PARENT_SCOPE)
endfunction()

function(unset_value output_variable)
  unset(${output_variable} PARENT_SCOPE)
endfunction()

set_value(value 1)
message("value: ${value}")

unset_value(value)
message("value: ${value}")
