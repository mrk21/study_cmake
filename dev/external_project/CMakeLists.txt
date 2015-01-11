cmake_minimum_required(VERSION 3.0.2)

message("Preparing vendor...")
try_compile(vendor_status
  ${PROJECT_BINARY_DIR}/vendor
  ${PROJECT_SOURCE_DIR}/vendor
  vendor
  OUTPUT_VARIABLE vendor_result
)
if(NOT vendor_status)
  message("${vendor_result}")
endif()
include(${PROJECT_BINARY_DIR}/vendor/mylib/lib/mylib.cmake)

add_executable(bin src.cpp)
target_link_libraries(bin mylib)
