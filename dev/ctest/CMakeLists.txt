cmake_minimum_required(VERSION 3.0.2)

# see: http://www.cmake.org/cmake/help/v3.0/command/add_test.html

# Build
find_package(Boost REQUIRED system filesystem)
add_compile_options(-std=gnu++1y)
add_executable(test_bin test.cpp)
target_link_libraries(test_bin ${Boost_LIBRARIES})

# Test
enable_testing()

add_test(
  NAME test1
  COMMAND $<TARGET_FILE:test_bin> arg1 arg2
)
set_tests_properties(test1 PROPERTIES
  LABELS "hoge;fuga"
  DEPENDS "test3;test2;test4"
  RUN_SERIAL "test3;test2"
  ENVIRONMENT "VALUE1=100;VALUE2=abc"
  SKIP_RETURN_CODE 0
)

add_test(
  NAME test2
  COMMAND $<TARGET_FILE:test_bin> arg3 arg4
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
set_tests_properties(test2 PROPERTIES
  LABELS "fuga;hogehoge"
  FAIL_REGULAR_EXPRESSION "arg4"
)

# Generator expressions cannot use:
add_test(test3 test_bin arg5 arg6) 
set_tests_properties(test3 PROPERTIES
  PASS_REGULAR_EXPRESSION "arg3"
)

add_test(
  NAME test4
  COMMAND $<TARGET_FILE:test_bin>
)
set_tests_properties(test4 PROPERTIES
  TIMEOUT 0.1
)

add_test(
  NAME test5
  COMMAND $<TARGET_FILE:test_bin>
  CONFIGURATIONS Release
)
