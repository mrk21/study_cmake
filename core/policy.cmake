#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0)

# Policy "CMP0007" specifies controling interpretation of an empty element in list.
function(verify_cmp0007 behavior)
  cmake_policy(SET CMP0007 ${behavior})
  cmake_policy(GET CMP0007 current_behavior)
  message("CMP0007: ${current_behavior}")
  
  set(list_value "a;b;;c")
  list(LENGTH list_value length)
  message("list: ${list_value}")
  message("length: ${length}")
  message("")
endfunction()

verify_cmp0007(OLD) #[[
  CMP0007: OLD
  list: a;b;;c
  length: 3
]]

verify_cmp0007(NEW) #[[
  CMP0007: NEW
  list: a;b;;c
  length: 4
]]
