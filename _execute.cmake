cmake_minimum_required(VERSION 3.0.2)

function(get_root_dir result)
  get_filename_component(name ${CMAKE_CURRENT_LIST_FILE} NAME_WE)
  set(${result} ${CMAKE_CURRENT_LIST_DIR}/${name} PARENT_SCOPE)
endfunction()

function(get_working_dir result)
  get_root_dir(root_dir)
  set(${result} ${root_dir}/gen PARENT_SCOPE)
endfunction()

function(init_working_dir)
  set(args ${ARGV} false)
  list(GET args 0 is_force)
  unset(args)
  
  if(is_force)
    expire_working_dir()
  endif()
  
  if(NOT DEFINED WORKING_DIR_INITIALIZED)
    get_working_dir(working_dir)
    file(REMOVE_RECURSE ${working_dir})
    file(MAKE_DIRECTORY ${working_dir})
    set(WORKING_DIR_INITIALIZED true CACHE INTERNAL "")
  endif()
endfunction()

function(expire_working_dir)
  unset(WORKING_DIR_INITIALIZED CACHE)
endfunction()

function(execute)
  get_working_dir(working_dir)
  init_working_dir()
  
  string(REPLACE ";" " " commandline "${ARGV}")
  message("")
  message("## ${commandline}")
  
  execute_process(
    COMMAND ${ARGV}
    WORKING_DIRECTORY ${working_dir}
  )
  
  string(REGEX MATCHALL [[(RESULT|OUTPUT|ERROR)_VARIABLE;([a-zA-Z0-9_\-]+)]] matches "${ARGV}")
  list(LENGTH matches length)
  if(length GREATER 1)
    math(EXPR end ${length}-1)
    foreach(i RANGE 1 ${end} 2)
      list(GET matches ${i} variable_name)
      set(${variable_name} ${${variable_name}} PARENT_SCOPE)
    endforeach()
  endif()
endfunction()

function(execute_cmake)
  execute(${CMAKE_COMMAND} ${ARGV} ..)
endfunction()

function(make_cmakelists current_dir code)
  get_root_dir(root_dir)
  get_working_dir(working_dir)
  
  if(current_dir STREQUAL .)
    set(current_dir ${root_dir})
  else()
    set(current_dir ${root_dir}/${current_dir})
  endif()
  
  string(CONFIGURE "${code}" code @ONLY)
  configure_file(${current_dir}/CMakeLists.txt.in ${current_dir}/CMakeLists.txt)
endfunction()

function(scope block)
  get_root_dir(root_dir)
  get_working_dir(working_dir)
  
  string(CONFIGURE "
    macro(scope_impl)
      ${block}
    endmacro()
  " block @ONLY)
  
  set(temp_path ${working_dir}/.temp.cmake)
  file(WRITE ${temp_path} "${block}")
  include(${temp_path})
  file(REMOVE ${temp_path})
  
  unset(root_dir)
  unset(working_dir)
  unset(block)
  unset(temp_path)
  
  init_working_dir()
  scope_impl()
  expire_working_dir()
endfunction()
