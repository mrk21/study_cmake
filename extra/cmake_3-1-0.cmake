#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.1.0)

include(${CMAKE_CURRENT_LIST_DIR}/../_execute.cmake)

message([[## Variable References and Escape Sequences]])
scope([[
  cmake_minimum_required(VERSION 3.1.0)
  set(a_b.c/d-e+f 11)
  message("${a_b.c/d-e+f}")
  
  set(a_b.c/d-e+f\[ 11)
  message("${a_b.c/d-e+f\[}")
]])

scope([=[
  cmake_minimum_required(VERSION 3.0.2)
  set(a_b.c/d-e+f 11)
  message("${a_b.c/d-e+f}")
  
  # error
  #[[
    set(a_b.c/d-e+f\[ 11)
    message("${a_b.c/d-e+f\[}")
  ]]
]=])


message([[### string()]])
scope([=[
  cmake_minimum_required(VERSION 3.1.0)
  string(GENEX_STRIP "a$<1:hoge>b" result)
  message("result: ${result}") # ab
  
  # version 3
  string(UUID result
    NAMESPACE 6ba7b810-9dad-11d1-80b4-00c04fd430c8
    NAME www.example.com
    TYPE MD5
  )
  message("result: ${result}") # result: 5df41881-3aed-3515-88a7-2f4a814cf09e
  
  # version 5
  string(UUID result
    NAMESPACE 6ba7b810-9dad-11d1-80b4-00c04fd430c8
    NAME www.example.com
    TYPE SHA1
  )
  message("result: ${result}") # result: 2ed6657d-e927-568b-95e1-2665a8aea6a2
]=])

message([[### target_compile_features()]])
scope([=[
  set(ENV{VERBOSE} 1)
  set(ENV{CXX} clang++-3.5)
  make_cmakelists(. [[
    add_executable(main main.cpp)
    # Error
    #[==[
      target_compile_features(main PUBLIC cxx_constexpr)
    ]==]
  ]])
  execute_cmake()
  execute(make)
]=])

message([[### target_sources()]])
scope([=[
  set(ENV{VERBOSE} 1)
  make_cmakelists(. [[
    add_executable(main main.cpp)
    target_sources(main PUBLIC hoge.cpp)
  ]])
  execute_cmake()
  execute(make)
]=])
