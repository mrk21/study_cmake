cmake_minimum_required(VERSION 3.0.2)

set(value 1)
set(value2 2 CACHE STRING "")
set(ENV{value3} 3)
set(value4 '\")
set(value5 off)

set(CONFIG_FILE_OPTIONS "$ENV{CONFIG_FILE_OPTIONS}")

set(i 0)
foreach(option IN LISTS CONFIG_FILE_OPTIONS)
  configure_file(test.hpp.in test_${i}.hpp ${option})
  math(EXPR i ${i}+1)
endforeach()
