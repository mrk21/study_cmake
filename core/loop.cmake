#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0)


message([=[
## foreach()
### IN LISTS

foreach(loop_var IN LISTS [list-variable1 [...]])
]=])

set(list1 a;b)
set(list2 c;d)

foreach(v IN LISTS list1 list2)
  message("v: ${v}")
endforeach()


message([=[

### IN ITEMS

foreach(loop_var IN ITEMS [value1 [...]])
]=])

foreach(v IN ITEMS a b c;d)
  message("v: ${v}")
endforeach()

message([=[

#### Short ver.

foreach(loop_var [value1 [...]])
]=])

foreach(v a b c;d)
  message("v: ${v}")
endforeach()


message([=[

### RANGE total

foreach(loop_var RANGE total)
]=])

foreach(v RANGE 3)
  message("v: ${v}")
endforeach()


message([=[

### RANGE start stop step

foreach(loop_var RANGE start stop [step])
]=])

foreach(v RANGE 1 4)
  message("v: ${v}")
endforeach()

foreach(v RANGE 10 5 -2)
  message("v: ${v}")
endforeach()


message([=[

## while()
]=])

set(filename "")

while(NOT filename MATCHES "[0-9][A-Z]")
  string(RANDOM filename)
  message("filename: ${filename}")
endwhile()


message([=[

## break()
]=])

foreach(v a;b;c;d)
  if(v STREQUAL c)
    break()
  endif()
  message("v: ${v}")
endforeach()


while(true)
  string(RANDOM filename)
  message("filename: ${filename}")
  if(filename  MATCHES "[0-9][A-Z]")
    break()
  endif()
endwhile()
