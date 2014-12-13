#!/usr/bin/env cmake -P
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#modules
# see: http://www.cmake.org/cmake/help/v3.0/command/include.html
# see: http://www.cmake.org/cmake/help/v3.0/variable/CMAKE_MODULE_PATH.html
cmake_minimum_required(VERSION 3.0.2)

get_filename_component(_name ${CMAKE_CURRENT_LIST_FILE} NAME_WE)
set(basedir ${CMAKE_CURRENT_LIST_DIR}/${_name})
unset(_name)


message([[## Module Path]])
message([[### Specifying by an absolute path]])

unset(CMAKE_MODULE_PATH)
include(${basedir}/module.cmake)     # module
include(${basedir}/dir/module.cmake) # dir/module
message("")


message([[### Specifying by a module name]])

set(CMAKE_MODULE_PATH ${basedir})
message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
include(module)     # module
include(dir/module) # dir/module
message("")

set(CMAKE_MODULE_PATH ${basedir} ${basedir}/dir)
message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
include(module)     # module
include(dir/module) # dir/module
message("")

set(CMAKE_MODULE_PATH ${basedir}/dir ${basedir})
message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
include(module)     # dir/module
include(dir/module) # dir/module
message("")


message([[### Specifying by a same module name as CMake standard module]])

unset(CMAKE_MODULE_PATH)
message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
include(Documentation)
message("")

set(CMAKE_MODULE_PATH ${basedir})
message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
include(Documentation)
message("")


message([[## OPTIONAL and RESULT_VARIABLE options]])
message([[### Specifying a OPTIONAL option]])

#[[
  include(/not/existing/module.cmake) # Error
]]
include(/not/existing/module.cmake OPTIONAL)
message("")


message([[### Specifying a RESULT_VARIABLE option]])

set(CMAKE_MODULE_PATH ${basedir})
include(module RESULT_VARIABLE module_path) # module
message("module_path: ${module_path}") # ${basedir}/module.cmake
message("")


message([[### Specifying not existing path with OPTIONAL and RESULT_VARIABLE options]])

include(/not/existing/module.cmake OPTIONAL RESULT_VARIABLE module_path)
message("module_path: ${module_path}") # NOTFOUND
message("")


message([[## NO_POLICY_SCOPE option]])

cmake_policy(GET CMP0007 cmp0007_behavior)
message("cmp0007_behavior: ${cmp0007_behavior}") # cmp0007_behavior: NEW

set(CMAKE_MODULE_PATH ${basedir})
include(set_policy) #[[
  cmp0007_behavior: NEW
  cmp0007_behavior: OLD
]]

cmake_policy(GET CMP0007 cmp0007_behavior)
message("cmp0007_behavior: ${cmp0007_behavior}") # cmp0007_behavior: NEW
message("")


cmake_policy(GET CMP0007 cmp0007_behavior)
message("cmp0007_behavior: ${cmp0007_behavior}") # cmp0007_behavior: NEW

set(CMAKE_MODULE_PATH ${basedir})
include(set_policy NO_POLICY_SCOPE) #[[
  cmp0007_behavior: NEW
  cmp0007_behavior: OLD
]]

cmake_policy(GET CMP0007 cmp0007_behavior)
message("cmp0007_behavior: ${cmp0007_behavior}") # cmp0007_behavior: OLD
message("")
