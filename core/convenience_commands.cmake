#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

include(${CMAKE_CURRENT_LIST_DIR}/../_execute.cmake)

message([[## file()]])
message([[### WRITE]])
scope([=[
  file(WRITE @working_dir@/hoge.txt a b c) #[[
    $ cat hoge.txt
    abc
  ]]
  file(READ @working_dir@/hoge.txt content)
  message("content: ${content}")
  
  file(APPEND @working_dir@/hoge.txt a b c) #[[
    $ cat hoge.txt
    abcabc
  ]]
  file(READ @working_dir@/hoge.txt content)
  message("content: ${content}")
]=])
message("")

message([[### READ]])
scope([=[
  file(WRITE @working_dir@/hoge.txt a b c)
  
  file(READ @working_dir@/hoge.txt content)
  message("content: ${content}") # abc
  
  file(READ @working_dir@/hoge.txt content HEX)
  message("content: ${content}") # 616263
  
  file(READ @working_dir@/hoge.txt content LIMIT 2 OFFSET 1)
  message("content: ${content}") # bc
]=])
message("")

message([[### STRINGS]])
scope([[
  file(STRINGS @root_dir@/test1.txt var)
  message("var: ${var}")
]])
message("")

message([[### GENERATE]])
scope([[
  make_cmakelists(. [=[
    file(GENERATE
      OUTPUT @working_dir@/test1.txt
      CONTENT "ddd"
      CONDITION $<AND:1,1>
    )
  ]=])
  execute_cmake()
  execute(cat test1.txt)
  message("")
]])
message("")

message([[### GLOB・GLOB_RECURSE]])
scope([=[
  file(GLOB files @root_dir@/*.txt)
  message("files: ${files}")
  
  file(GLOB files @root_dir@/test1*.txt)
  message("files: ${files}")
  
  file(GLOB files @root_dir@/[t-z]*.txt)
  message("files: ${files}")
  
  file(GLOB files @root_dir@/*.gitignore)
  message("files: ${files}")
]=])
message("")

message([[### MD5]])
scope([[
  file(MD5 @root_dir@/test1.txt digest)
  message("digest: ${digest}")
]])
message("")

message([[### TIMESTAMP]])
scope([[
  file(TIMESTAMP @root_dir@/test1.txt timestamp)
  message("timestamp: ${timestamp}")
  
  file(TIMESTAMP @root_dir@/test1.txt formatted_timestamp "%Y/%m/%d %H:%M:%S")
  message("formatted_timestamp: ${formatted_timestamp}")
  
  file(TIMESTAMP @root_dir@/test1.txt utc_timestamp UTC)
  message("utc_timestamp: ${utc_timestamp}")
]])
message("")

message([[### RELATIVE_PATH]])
scope([[
  get_filename_component(path @root_dir@/../../vendor ABSOLUTE)
  message("path: ${path}")
  
  file(RELATIVE_PATH path ${path} @root_dir@/test1.txt)
  message("path: ${path}")
]])
message("")

message([[### DOWNLOAD]])
scope([[
  file(DOWNLOAD http://www.boost.org/ @working_dir@/boost-index.html)
  execute(ls)
  
  file(DOWNLOAD https://www.google.co.jp/ @working_dir@/google-index.html)
  execute(ls)
]])
message("")

message([[## string()]])
message([[### ASCII]])
scope([[
  string(ASCII 40 code)
  message("code: ${code}")
]])
message("")

message([[### FIND]])
scope([[
  string(FIND "aaa123a12" "a12" pos)
  message("pos: ${pos}")
  
  string(FIND "aaa123a12" "a12" pos REVERSE)
  message("pos: ${pos}")
]])
message("")

message([[### SUBSTRING]])
scope([[
  string(SUBSTRING "aaa123a12" 2 3 sub)
  message("sub: ${sub}")
]])
message("")

message([[### RANDOM]])
scope([[
  string(RANDOM result)
  message("result: ${result}")
]])
message("")

message([[## get_filename_component()]])
scope([[
  get_filename_component(result "/path/to/script.cmake" DIRECTORY)
  message("result: ${result}")
  
  get_filename_component(result "/path/to/script.cmake" NAME)
  message("result: ${result}")
  
  get_filename_component(result "/path/to/script.cmake" EXT)
  message("result: ${result}")
  
  get_filename_component(result "/path/to/script.cmake" NAME_WE)
  message("result: ${result}")
  
  get_filename_component(result "path/to/script.cmake" ABSOLUTE)
  message("result: ${result}")
  
  get_filename_component(result "/usr/local/include/boost" REALPATH)
  message("result: ${result}")
]])
message("")

message([[## math()]])
scope([[
  function(verify_math expr)
    math(EXPR result "${expr}")
    message("${expr} = ${result}")
  endfunction()
  
  verify_math("1 + 1")
  verify_math("1 - 5")
  verify_math("2 * 3")
  verify_math("2 * 3 + (2 + 4)")
  verify_math("1 << 3")
  verify_math("8 >> 2")
  verify_math("12 % 10")
  verify_math("8 | 15")
  verify_math("8 & 15")
]])
message("")

message([[## cmake_host_system_information()]])
scope([[
  cmake_host_system_information(RESULT cores QUERY NUMBER_OF_LOGICAL_CORES)
  message("cores: ${cores}")
  
  cmake_host_system_information(RESULT info QUERY HOSTNAME FQDN)
  message("info: ${info}")
]])
