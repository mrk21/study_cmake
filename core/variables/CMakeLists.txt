# Variables: binding and scope
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#variables
cmake_minimum_required(VERSION 3.0)

macro(display indent)
  message("${indent}a: ${a}")
  message("${indent}b: ${b}")
endmacro()

macro(set_value name value indent)
  message("${indent}set(${name} ${value})")
  set(${name} ${value})
endmacro()

function(set_and_display_impl indent is_call)
  display("${indent}")
  if (${is_call})
    set_value(a 123 ${indent})
  else()
    set_value(b 43 ${indent})
  endif()
  display("${indent}")
  
  if (${is_call})
    message("${indent}function set_and_display() {")
      set_and_display_impl("${indent}\t" false)
    message("${indent}}")
    
    display("${indent}")
  endif()
endfunction()

function(set_and_display indent)
  set_and_display_impl(${indent} true)
endfunction()

macro(display_set indent)
  display("${indent}")
  message("${indent}function set_and_display() {")
    set_and_display("${indent}\t")
  message("${indent}}")
  display("${indent}")
endmacro()

message("directory root {")
  set_value(a 1 "\t")
  display_set("\t")
  add_subdirectory(subdir)
  display_set("\t")
message("}")
