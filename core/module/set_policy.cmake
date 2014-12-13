cmake_policy(GET CMP0007 cmp0007_behavior)
message("cmp0007_behavior: ${cmp0007_behavior}")

cmake_policy(SET CMP0007 OLD)

cmake_policy(GET CMP0007 cmp0007_behavior)
message("cmp0007_behavior: ${cmp0007_behavior}")
