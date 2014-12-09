#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

function(verify_math expr)
  math(EXPR result "${expr}")
  message("${expr} = ${result}")
endfunction()

verify_math("1 + 1")
verify_math("1 - 5")
verify_math("2 * 3")
verify_math("2 * 3 + (2 + 4)")
verify_math("1 << 3")
verify_math("8 >> 2")
verify_math("12 % 10")
verify_math("8 | 15")
verify_math("8 & 15")
