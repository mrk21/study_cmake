#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0)

# The normal variables and the cache variables have a same variable reference form,
# and if they both existed, then the variable reference priorities are listed below:
# 1. Normal Variables
# 2. Cache Variables
# 
# However, CMake will do processing listed below when a cache variable was set:
# 1. Sets the cache variable
# 2. Removes the normal variable whose name is same, which in the current scope
# 
# Therefore, the variable reference immediately after the above processing always point to the cache variable.

message("## Set the normal variable after set the cache variable.")

set(v1 y CACHE INTERNAL v1)
message("== set(v1 y CACHE)")
message("\${v1}: ${v1}")           # y
message("\$CACHE{v1}: $CACHE{v1}") # y

set(v1 x)
message("== set(v1 x)")
message("\${v1}: ${v1}")           # x
message("\$CACHE{v1}: $CACHE{v1}") # y

unset(v1)
message("== unset(v1)")
message("\${v1}: ${v1}")           # y
message("\$CACHE{v1}: $CACHE{v1}") # y


message(\n)
message("## Set the cache variable after set the normal variable.")

set(v2 x)
message("== set(v2 x)")
message("\${v2}: ${v2}")           # x
message("\$CACHE{v2}: $CACHE{v2}") # <empty>

set(v2 y CACHE INTERNAL v2)
message("== set(v2 y CACHE)")
message("\${v2}: ${v2}")           # y
message("\$CACHE{v2}: $CACHE{v2}") # y

unset(v2 CACHE)
message("== unset(v2 CACHE)")
message("\${v2}: ${v2}")           # <empty>
message("\$CACHE{v2}: $CACHE{v2}") # <empty>
