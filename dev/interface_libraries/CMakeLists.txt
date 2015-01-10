cmake_minimum_required(VERSION 3.0.2)

find_package(Boost REQUIRED system)
option(USE_LIBRARY "use library" OFF)

if(USE_LIBRARY)
  add_library(mylib mylib/lib.cpp)
  add_definitions(-DMYLIB_USE_LIBRARY)
  set(type PUBLIC)
else()
  add_library(mylib INTERFACE)
  set(type INTERFACE)
endif()

target_include_directories(mylib ${type}
  ${PROJECT_SOURCE_DIR}
)
target_compile_options(mylib ${type}
  -std=c++11
)
target_link_libraries(mylib ${type}
  ${Boost_LIBRARIES}
)

add_executable(bin src.cpp)
target_link_libraries(bin mylib)

install(TARGETS mylib DESTINATION lib EXPORT mylib)
install(DIRECTORY mylib DESTINATION include)
