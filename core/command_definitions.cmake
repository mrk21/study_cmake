#!/usr/bin/env cmake -P

## ARGC, ARGV<i>, ARGV and ARGN ##
# ARGC: Arguments size
# ARG<i>: The i-th arguments; The first arguments is 0
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
