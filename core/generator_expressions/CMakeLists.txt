cmake_minimum_required(VERSION 3.0)

# Build
add_executable(src1_bin src1.cpp)
add_executable(src2_bin src2.cpp)

# Properties
set_property(TARGET src1_bin PROPERTY VALUE 100)
set_property(TARGET src2_bin PROPERTY VALUE 200)
target_compile_definitions(src1_bin PRIVATE VALUE=$<TARGET_PROPERTY:VALUE>)
target_compile_definitions(src2_bin PRIVATE VALUE=$<TARGET_PROPERTY:VALUE>)
