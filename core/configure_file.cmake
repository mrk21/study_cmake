#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

set(CONFIG_FILE_OPTIONS
  ""
  "COPYONLY"
  "ESCAPE_QUOTES"
  "@ONLY"
  "NEWLINE_STYLE\;WIN32"
)
set(ENV{CONFIG_FILE_OPTIONS} "${CONFIG_FILE_OPTIONS}")

include(${CMAKE_CURRENT_LIST_DIR}/../_execute.cmake)
execute_cmake()

set(i 0)
foreach(option IN LISTS CONFIG_FILE_OPTIONS)
  message(------------------------------------)
  message("options: ${option}")
  execute(cat test_${i}.hpp)
  math(EXPR i ${i}+1)
endforeach()
