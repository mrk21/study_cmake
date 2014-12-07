cmake_minimum_required(VERSION 3.0.2)

# see: http://www.cmake.org/cmake/help/v3.0/command/add_test.html

# Build
find_package(Boost REQUIRED system filesystem)
set(CMAKE_CXX_FLAGS "-std=gnu++1y")
add_executable(test_bin test.cpp)
target_link_libraries(test_bin ${Boost_LIBRARIES})

# Test
enable_testing()
add_test(NAME test1 COMMAND test_bin arg1 arg2)
add_test(NAME test2 COMMAND test_bin arg3 arg4 WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
add_test(test3 test_bin arg5 arg6)
