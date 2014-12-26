#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

message([[## eval()]])
function(eval expr)
  set(path ".cmake-tmp")
  file(WRITE ${path} "${expr}")
  include(${path})
  file(REMOVE ${path})
endfunction()

eval([[
  message("Hai")
]])

message([[## eval_lambda()]])
function(eval_lambda)
  list(GET ARGV -1 lambda)
  list(REMOVE_AT ARGV -1)
  unset(names)
  
  if(lambda MATCHES [[^\(([^)]*)\)(.*)$]])
    set(names ${CMAKE_MATCH_1})
    set(lambda ${CMAKE_MATCH_2})
  endif()
  
  eval("
    function(eval_lambda_impl ${names})
      ${lambda}
    endfunction()
  ")
  eval_lambda_impl(${ARGV})
endfunction()

eval_lambda(1 2 33 [[(a b c)
  message("${a} ${b} ${c}")
]])

function(in_working)
  list(GET ARGV -1 lambda)
  list(REMOVE_AT ARGV -1)
  
  get_filename_component(name ${CMAKE_CURRENT_LIST_FILE} NAME_WE)
  set(working_dir ${CMAKE_CURRENT_LIST_DIR}/.${name}-working)
  
  file(REMOVE_RECURSE ${working_dir})
  file(MAKE_DIRECTORY ${working_dir})
  
  eval_lambda(${working_dir} ${ARGV} ${lambda})
  
  file(REMOVE_RECURSE ${working_dir})
endfunction()

function(in_working block)
  get_filename_component(name ${CMAKE_CURRENT_LIST_FILE} NAME_WE)
  set(working_dir ${CMAKE_CURRENT_LIST_DIR}/.${name}-working)
  
  message("## create working")
  file(REMOVE_RECURSE ${working_dir})
  file(MAKE_DIRECTORY ${working_dir})
  
  eval_lambda(${working_dir} ${block})
  
  message("## delete working")
  file(REMOVE_RECURSE ${working_dir})
endfunction()

in_working([[(dir)
  set(path ${dir}/hoge.txt)
  file(WRITE ${path} a b c)
  
  file(READ ${path} content)
  message("content: ${content}")
  
  file(READ ${path} content HEX)
  message("content: ${content}")
  
  file(READ ${path} content LIMIT 2 OFFSET 1)
  message("content: ${content}")
]]) #[[
  ## create working
  abc
  616263
  bc
  ## delete working
]]
