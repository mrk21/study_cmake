#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

macro(eval expr)
  set(_fname ".cmake-tmp")
  file(WRITE ${_fname} "${expr}")
  include(${_fname})
  file(REMOVE ${_fname})
endmacro()

eval([[
  message("Hai")
]])
