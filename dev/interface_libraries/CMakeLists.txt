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
  $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include>
)
target_compile_options(mylib ${type}
  -std=c++11
)
target_link_libraries(mylib ${type}
  ${Boost_LIBRARIES}
)

add_executable(bin src.cpp)
target_link_libraries(bin mylib)

install(TARGETS bin DESTINATION bin EXPORT bin)
install(TARGETS mylib DESTINATION lib EXPORT mylib)
install(EXPORT mylib DESTINATION lib)
install(DIRECTORY mylib DESTINATION include)
