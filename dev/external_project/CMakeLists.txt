cmake_minimum_required(VERSION 3.0.2)

include(ExternalProject)

ExternalProject_Add(mylib_project
  SOURCE_DIR ${PROJECT_SOURCE_DIR}/../interface_libraries
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DUSE_LIBRARY=ON
)
ExternalProject_Get_Property(mylib_project INSTALL_DIR)
include_directories(${INSTALL_DIR}/include)
link_directories(${INSTALL_DIR}/lib)

add_executable(bin src.cpp)
target_link_libraries(bin mylib)
add_dependencies(bin mylib_project)
