cmake_minimum_required(VERSION 3.0.2)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../../vendor/cotire/CMake)
include(cotire)

find_package(Boost 1.56 REQUIRED regex system)
include_directories(${Boost_INCLUDE_DIRS})
set(CMAKE_CXX_FLAGS "-std=gnu++14 -stdlib=libc++ -Wall -Wextra -Wno-unused-comparison")

add_executable(bin main.cpp)
target_link_libraries(bin ${Boost_LIBRARIES})
cotire(bin)
