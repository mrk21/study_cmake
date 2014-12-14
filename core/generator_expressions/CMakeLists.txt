cmake_minimum_required(VERSION 3.0.2)

function(display_directory_and_target_properties target_name prop_name)
  get_property(directory DIRECTORY PROPERTY ${prop_name})
  get_property(target TARGET ${target_name} PROPERTY ${prop_name})
  
  message("## directory ${prop_name}: ${directory}")
  message("## ${target_name} ${prop_name}: ${target}")
endfunction()

set_property(DIRECTORY PROPERTY COMPILE_OPTIONS
  $<$<NOT:$<BOOL:$<TARGET_PROPERTY:VALUE>>>:-DVALUE=100>
  $<$<BOOL:$<TARGET_PROPERTY:VALUE>>:-DVALUE=$<TARGET_PROPERTY:VALUE>>
)

set_property(DIRECTORY PROPERTY INCLUDE_DIRECTORIES
  $<$<NOT:$<BOOL:$<TARGET_PROPERTY:VALUE>>>:/opt>
  $<$<BOOL:$<TARGET_PROPERTY:VALUE>>:/opt/local/$<TARGET_PROPERTY:VALUE>>
)

add_executable(src1_bin src1.cpp)
add_executable(src2_bin src2.cpp)

set_property(TARGET src2_bin PROPERTY VALUE 200)
display_directory_and_target_properties(src2_bin COMPILE_OPTIONS)
display_directory_and_target_properties(src2_bin INCLUDE_DIRECTORIES)
