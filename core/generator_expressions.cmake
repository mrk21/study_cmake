#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

include(${CMAKE_CURRENT_LIST_DIR}/../_execute.cmake)
set(ENV{VERBOSE} 1)
execute_cmake(-DCMAKE_BUILD_TYPE=Debug)
execute(make
  OUTPUT_VARIABLE out
  ERROR_VARIABLE err
)
message("${err}")
string(REGEX MATCH "-I/@@@/(LogicalExpressions)/@@@.+-I/@@@/End/@@@" generator_expressions "${out}")
message("${generator_expressions}")

execute(./src1_bin)
execute(./src2_bin)
