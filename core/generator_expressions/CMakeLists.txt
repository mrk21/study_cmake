cmake_minimum_required(VERSION 3.0.2)

# compiler options
add_compile_options(
  $<$<NOT:$<BOOL:$<TARGET_PROPERTY:VALUE>>>:-DVALUE=100>               # common value
  $<$<BOOL:$<TARGET_PROPERTY:VALUE>>:-DVALUE=$<TARGET_PROPERTY:VALUE>> # specified value
)

# Build
add_executable(src1_bin src1.cpp)
add_executable(src2_bin src2.cpp)

# Properties
set_property(TARGET src2_bin PROPERTY VALUE 200)
