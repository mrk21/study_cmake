#!/usr/bin/env cmake -P

cmake_minimum_required(VERSION 3.0.2)
message([[## Policy "CMP0007" specifies to control an interpretation of an empty element in list.]])
cmake_policy(PUSH)
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
cmake_policy(POP)


cmake_minimum_required(VERSION 3.0.2)
message([[## Policy stack structure]])
cmake_policy(PUSH)
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
cmake_policy(POP)


cmake_minimum_required(VERSION 3.0.2)
message([[## Policy setting by CMake versions]])
cmake_policy(PUSH)
  set(policy_no CMP0050)
  cmake_policy(VERSION 2.6)
  cmake_policy(GET ${policy_no} current_behavior)
  message("CMake 2.6 ${policy_no}: ${current_behavior}")
  
  cmake_policy(VERSION 3.0)
  cmake_policy(GET ${policy_no} current_behavior)
  message("CMake 3.0 ${policy_no}: ${current_behavior}")
cmake_policy(POP)


cmake_minimum_required(VERSION 3.0.2)
message([[## CMake minimum required version]])
cmake_policy(PUSH)
  cmake_minimum_required(VERSION 2.6)
  message("CMake minimum required version: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
  
  cmake_minimum_required(VERSION 3.0.2)
  message("CMake minimum required version: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
  
  
  message([[## Checks whether the policy exists]])
  cmake_minimum_required(VERSION 3.0.2)
  
  #[[
    cmake_policy(SET CMP0900 NEW) # Error
    cmake_policy(GET CMP0900 behavior) # Error
  ]]
  
  if(POLICY CMP0900)
    cmake_policy(SET CMP0900 NEW)
  endif()
cmake_policy(POP)


cmake_minimum_required(VERSION 3.0.2)
message([[## Policy default setting]])
cmake_policy(PUSH)
  set(CMAKE_POLICY_DEFAULT_CMP0050 NEW CACHE STRING "" FORCE)
  message("CMAKE_POLICY_DEFAULT_CMP0050: ${CMAKE_POLICY_DEFAULT_CMP0050}")
  
  cmake_minimum_required(VERSION 2.8)
  cmake_policy(GET CMP0050 current_behavior)
  message("CMP0050: ${current_behavior}") # CMP0050: NEW
  
  
  unset(CMAKE_POLICY_DEFAULT_CMP0050 CACHE)
  
  cmake_minimum_required(VERSION 2.8)
  cmake_policy(GET CMP0050 current_behavior)
  message("CMP0050: ${current_behavior}") # CMP0050: 
cmake_policy(POP)
