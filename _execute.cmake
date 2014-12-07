function(execute)
  get_filename_component(basepath ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
  get_filename_component(name ${CMAKE_CURRENT_LIST_FILE} NAME_WE)
  set(working_dir ${basepath}/${name}/gen)
  
  if(NOT DEFINED IS_FIRST_EXECUTION)
    file(REMOVE_RECURSE ${working_dir})
    file(MAKE_DIRECTORY ${working_dir})
    set(IS_FIRST_EXECUTION true CACHE INTERNAL "")
  endif()
  
  string(REPLACE ";" " " commandline "${ARGV}")
  message("")
  message("## ${commandline}")
  
  execute_process(
    COMMAND ${ARGV}
    WORKING_DIRECTORY ${working_dir}
  )
endfunction()

function(execute_cmake)
  execute(${CMAKE_COMMAND} ..)
endfunction()
