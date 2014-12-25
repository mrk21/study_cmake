#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

## ARGC, ARGV<i>, ARGV and ARGN ##
# ARGC: Arguments size
# ARG<i>: The i-th argument; The first argument number is 0
# ARGV: All arguments
# ARGN: Not named arguments
# see: http://www.cmake.org/cmake/help/v3.0/command/macro.html

message("## ARGC, ARGV<i>, ARGV and ARGN ##")

function(f1)
  message("# f1()")
  message("${ARGC}, ${ARGV0}, ${ARGV}, ${ARGN}")
endfunction()

function(f2 a)
  message("# f2()")
  message("${ARGC}, ${ARGV0}, ${ARGV}, ${ARGN}")
endfunction()

f1(a b c) # 3, a, a;b;c, a;b;c
f2(a b c) # 3, a, a;b;c, b;c

f1() # 


## The arguments of macro() are not variable ##
# It is just a string replacement, and it must use in the form of variable reference.
# Otherwise, it is not replaced, and it is evaluated on an invoker context.
# see: http://www.cmake.org/cmake/help/v3.0/command/macro.html#macro-argument-caveats

message(\n)
message("## The arguments of macro() are not variable ##")

macro(f3 value)
  set(value 2)
  message("f3 value: ${value}")
  foreach(v IN LISTS ARGV)
    message("f3 ARGV element: ${v}")
  endforeach()
endmacro()

function(f4)
  set(value 1)
  message("f4 ARGV: ${ARGV}")
  message("f4 value: ${value}")
  f3(x y z)
  message("f4 value: ${value}")
endfunction()

f4(a b c) #[[
  Expected:
    f4 ARGV: a;b;c
    f4 value: 1
    f3 value: 2
    f3 ARGV element: 2
    f3 ARGV element: y
    f3 ARGV element: z
    f4 value: 1
  
  Actual:
    f4 ARGV: a;b;c
    f4 value: 1
    f3 value: x
    f3 ARGV element: a
    f3 ARGV element: b
    f3 ARGV element: c
    f4 value: 2
]]

message("")
message("# function version")

function(f5 value)
  set(value 2)
  message("f5 value: ${value}")
  foreach(v IN LISTS ARGV)
    message("f5 ARGV element: ${v}")
  endforeach()
endfunction()

function(f6)
  set(value 1)
  message("f6 ARGV: ${ARGV}")
  message("f6 value: ${value}")
  f5(x y z)
  message("f6 value: ${value}")
endfunction()

f6(a b c) #[[
  f6 ARGV: a;b;c
  f6 value: 1
  f5 value: 2
  f5 ARGV element: 2
  f5 ARGV element: y
  f5 ARGV element: z
  f6 value: 1
]]

message("")
message("# ARGV<n> problem")

function(f7)
  message("f7 ARGC: ${ARGC}")
  message("f7 ARGV: ${ARGV}")
  message("f7 ARGN: ${ARGN}")
  message("f7 ARGV0: ${ARGV0}")
  message("f7 ARGV1: ${ARGV1}")
endfunction()

function(f8)
  f7()
endfunction()

f8() #[[
  f7 ARGC: 0
  f7 ARGV: 
  f7 ARGN: 
  f7 ARGV0: 
  f7 ARGV1: 
]]
message("")
f8(a b) #[[
  f7 ARGC: 0
  f7 ARGV: 
  f7 ARGN: 
  f7 ARGV0: a
  f7 ARGV1: b
]]
message("")

macro(f9)
  message("f9 ARGC: ${ARGC}")
  message("f9 ARGV: ${ARGV}")
  message("f9 ARGN: ${ARGN}")
  message("f9 ARGV0: ${ARGV0}")
  message("f9 ARGV1: ${ARGV1}")
endmacro()

macro(f10)
  f9()
endmacro()

f10() #[[
  f9 ARGC: 0
  f9 ARGV: 
  f9 ARGN: 
  f9 ARGV0: 
  f9 ARGV1: 
]]
message("")

f10(a b) #[[
  f9 ARGC: 0
  f9 ARGV: 
  f9 ARGN: 
  f9 ARGV0: 
  f9 ARGV1: 
]]
message("")

function(f11)
  set(args ${ARGV} "" "")
  list(GET args 0 arg0)
  list(GET args 1 arg1)
  unset(args)
  
  message("f11 arg0: ${arg0}")
  message("f11 arg1: ${arg1}")
endfunction()

function(f12)
  f11()
endfunction()

f11() #[[
  f11 arg0: 
  f11 arg1: 
]]
message("")

f11(a) #[[
  f11 arg0: a
  f11 arg1: 
]]
message("")

f11(a b) #[[
  f11 arg0: a
  f11 arg1: b
]]
message("")

f12(a b) #[[
  f11 arg0: 
  f11 arg1: 
]]
