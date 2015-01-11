cmake_minimum_required(VERSION 3.0.2)

include(ExternalProject)

ExternalProject_Add(mylib
  SOURCE_DIR ${PROJECT_SOURCE_DIR}/../../interface_libraries
  PREFIX mylib
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DUSE_LIBRARY=ON
)
