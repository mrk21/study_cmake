#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

# Policy "CMP0007" specifies to control an interpretation of an empty element in list.
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

# Policy stack structure
cmake_policy(SET CMP0007 NEW)
cmake_policy(GET CMP0007 current_behavior)
message("CMP0007: ${current_behavior}") # CMP0007: NEW

cmake_policy(PUSH) # Push the current policy settings
  cmake_policy(SET CMP0007 OLD)
  cmake_policy(GET CMP0007 current_behavior)
  message("CMP0007: ${current_behavior}") # CMP0007: OLD
cmake_policy(POP) # Pop the current policy settings

cmake_policy(GET CMP0007 current_behavior)
message("CMP0007: ${current_behavior}") # CMP0007: NEW
