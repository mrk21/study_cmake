cmake_minimum_required(VERSION 3.0)

# Build
file(GLOB main_files "*.cpp")
foreach(path IN LISTS main_files)
  get_filename_component(name ${path} NAME_WE)
  add_executable(${name}_bin ${path})
endforeach()

# Property
set_property(
  TARGET src2_bin
  PROPERTY COMPILE_DEFINITIONS
  VALUE="special_value"
)
get_property(
  current_directory_property
  DIRECTORY
  PROPERTY COMPILE_DEFINITIONS
)
get_property(
  src2_property
  TARGET src2_bin
  PROPERTY COMPILE_DEFINITIONS
)

message("current_directory_property: ${current_directory_property}")
message("src2_property: ${src2_property}")
