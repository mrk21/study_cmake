#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0)

function(qsort list_variable)
  # initialize
  set(list_value ${${list_variable}})
  unset(left)
  unset(right)
  
  # termination condition
  list(LENGTH list_value target_length)
  if (${target_length} LESS 2)
    return()
  endif()
  
  # select a pivot
  list(GET list_value 0 pivot)
  list(REMOVE_AT list_value 0)
  
  # make a left partial list and a right partial list
  foreach (v IN LISTS list_value)
    if(${v} LESS ${pivot})
      list(APPEND left ${v})
    else()
      list(APPEND right ${v})
    endif()
  endforeach()
  
  # apply to the partial lists
  qsort(left)
  qsort(right)
  
  # return sorted list
  set(${list_variable} ${left} ${pivot} ${right} PARENT_SCOPE)
endfunction()

set(target 5 1 5 9 2 13 -4 3)
message("before: ${target}")
qsort(target)
message("after: ${target}")
