cmake_minimum_required(VERSION 3.0.2)

add_custom_target(my_target0)
add_custom_target(my_target1 echo @@ target1)
add_custom_target(my_target2 COMMAND echo @@ target2)
add_custom_target(my_target3 ALL COMMAND echo @@ target3)

add_custom_target(my_target4
  COMMAND echo @@ my_target4_1
  COMMAND echo @@ my_target4_2
  COMMAND echo @@ my_target4_3
)

add_custom_target(my_target5 ALL
  echo @@ my_target5_0
  COMMAND echo @@ my_target5_1
  COMMAND echo @@ my_target5_2
  COMMAND echo @@ my_target5_3
)

add_custom_target(my_target6
  echo @@ my_target6
  DEPENDS my_target5 my_target4
  DEPENDS my_target3 my_target2
)

add_custom_target(my_target7 pwd WORKING_DIRECTORY ~)

add_custom_target(my_target8
  echo @@ my_target8
  COMMENT [[!! my_target8 comment !!]]
)

add_custom_target(my_target9_1 echo @@ PATH: [[${PATH}]])
add_custom_target(my_target9_2 echo @@ PATH: [[${PATH}]] VERBATIM)

add_custom_target(my_target10
  SOURCES copied_src1.cpp
)
add_custom_command(OUTPUT copied_src1.cpp
  COMMAND cp ${PROJECT_SOURCE_DIR}/src1.cpp copied_src1.cpp
)

add_executable(src1 src1.cpp)
