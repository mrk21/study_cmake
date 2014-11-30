#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0)


if(true)
  message(1)
endif()

set(bool_value true)

if(bool_value)
  message(1)
endif()

if(${bool_value})
  message(1)
endif()
