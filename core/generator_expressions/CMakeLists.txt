cmake_minimum_required(VERSION 3.0.2)

function(display_directory_and_target_properties target_name prop_name)
  get_property(directory DIRECTORY PROPERTY ${prop_name})
  get_property(target TARGET ${target_name} PROPERTY ${prop_name})
  
  message("## directory ${prop_name}: ${directory}")
  message("## ${target_name} ${prop_name}: ${target}")
endfunction()

cmake_policy(SET CMP0004 OLD)

set_property(DIRECTORY PROPERTY COMPILE_OPTIONS
  $<$<NOT:$<BOOL:$<TARGET_PROPERTY:VALUE>>>:-DVALUE=100>
  $<$<BOOL:$<TARGET_PROPERTY:VALUE>>:-DVALUE=$<TARGET_PROPERTY:VALUE>>
)

add_library(hoge hoge.cpp)
add_library(foo SHARED foo.cpp)

add_executable(src1_bin src1.cpp)
target_link_libraries(src1_bin hoge)

add_executable(src2_bin src2.cpp)
target_link_libraries(src2_bin foo)

set_property(TARGET src2_bin PROPERTY VALUE 200)
display_directory_and_target_properties(src2_bin COMPILE_OPTIONS)
display_directory_and_target_properties(src2_bin INCLUDE_DIRECTORIES)

set_property(TARGET src2_bin PROPERTY INCLUDE_DIRECTORIES
  /@@@/LogicalExpressions/@@@
  # Logical Expressions
  ## $<BOOL:...>
  ### truthy
  /BOOL/a$<BOOL:1>             # /BOOL/a1
  /BOOL/b$<BOOL:2>             # /BOOL/b1
  /BOOL/c$<BOOL:TRUE>          # /BOOL/c1
  /BOOL/d$<BOOL:Yes>           # /BOOL/d1
  /BOOL/e$<BOOL:on>            # /BOOL/e1
  
  ### falsy
  /BOOL/a$<BOOL:>              # /BOOL/a0
  /BOOL/b$<BOOL:0>             # /BOOL/b0
  /BOOL/c$<BOOL:FALSE>         # /BOOL/c0
  /BOOL/d$<BOOL:No>            # /BOOL/d0
  /BOOL/e$<BOOL:off>           # /BOOL/e0
  /BOOL/f$<BOOL:Hoge-NotFound> # /BOOL/f0
  
  ### error
  #[=[
    $<BOOL\ :> #[[
      Error evaluating generator expression:
      
        $<BOOL\ :>
    ]]
  ]=]
  
  ## $<AND:...>
  /AND/a$<AND:1>       # /AND/a1
  /AND/b$<AND:1,1>     # /AND/b1
  /AND/c$<AND:1,1,1>   # /AND/c1
  /AND/d$<AND:1,1,1,1> # /AND/d1
  
  /AND/a$<AND:0>       # /AND/a0
  /AND/b$<AND:1,0>     # /AND/b0
  /AND/c$<AND:1,0,1>   # /AND/c0
  /AND/d$<AND:1,1,0,1> # /AND/d0
  
  ## $<OR:...>
  /OR/a$<OR:1>       # /OR/a1
  /OR/b$<OR:1,1>     # /OR/b1
  /OR/c$<OR:0,1>     # /OR/c1
  /OR/d$<OR:0,1,0>   # /OR/d1
  /OR/e$<OR:0,0,1,0> # /OR/e1
  
  /OR/a$<OR:0>       # /OR/a0
  /OR/b$<OR:0,0>     # /OR/b0
  /OR/c$<OR:0,0,0>   # /OR/c0
  /OR/d$<OR:0,0,0,0> # /OR/d0
  
  ## $<NOT:...>
  /NOT/$<NOT:1> # /NOT/0
  /NOT/$<NOT:0> # /NOT/1
  
  ## $<STREQUAL:...>
  /STREQUAL/$<STREQUAL:a,a> # /STREQUAL/1
  /STREQUAL/$<STREQUAL:a,b> # /STREQUAL/0
  
  ## $<EQUAL:...>
  /EQUAL/$<EQUAL:1,1> # /EQUAL/1
  /EQUAL/$<EQUAL:1,0> # /EQUAL/0
  
  ## $<PLATFORM_ID:...>
  /PLATFORM_ID/$<PLATFORM_ID:Darwin> # /PLATFORM_ID/1
  /PLATFORM_ID/$<PLATFORM_ID:Linux>  # /PLATFORM_ID/0
  
  ## $<C_COMPILER_ID:...>
  /C_COMPILER_ID/$<C_COMPILER_ID:Clang> # /C_COMPILER_ID/1
  /C_COMPILER_ID/$<C_COMPILER_ID:GNU>   # /C_COMPILER_ID/0
  
  ## $<CXX_COMPILER_ID:...>
  /CXX_COMPILER_ID/$<CXX_COMPILER_ID:Clang> # /CXX_COMPILER_ID/1
  /CXX_COMPILER_ID/$<CXX_COMPILER_ID:GNU>   # /CXX_COMPILER_ID/0
  
  ## $<VERSION_GREATER:...>
  /VERSION_GREATER/$<VERSION_GREATER:1.19,1.2> # /VERSION_GREATER/1
  /VERSION_GREATER/$<VERSION_GREATER:1.2,1.19> # /VERSION_GREATER/0
  
  ## $<VERSION_LESS:...>
  /VERSION_LESS/$<VERSION_LESS:1.2,1.19> # /VERSION_LESS/1
  /VERSION_LESS/$<VERSION_LESS:1.19,1.2> # /VERSION_LESS/0
  
  ## $<VERSION_EQUAL:...>
  /VERSION_EQUAL/$<VERSION_EQUAL:1.0,1.0.0> # /VERSION_EQUAL/1
  /VERSION_EQUAL/$<VERSION_EQUAL:1.0,1.0.1> # /VERSION_EQUAL/0
  
  ## $<C_COMPILER_VERSION:...>
  /C_COMPILER_VERSION/$<C_COMPILER_VERSION:6.0.0.6000054> # /C_COMPILER_VERSION/1
  /C_COMPILER_VERSION/$<C_COMPILER_VERSION:6.0.0>         # /C_COMPILER_VERSION/0
  
  ## $<CXX_COMPILER_VERSION:...>
  /CXX_COMPILER_VERSION/$<CXX_COMPILER_VERSION:6.0.0.6000054> # /CXX_COMPILER_VERSION/1
  /CXX_COMPILER_VERSION/$<CXX_COMPILER_VERSION:6.0.0>         # /CXX_COMPILER_VERSION/0
  
  ## $<TARGET_POLICY:...>
  # * CMP0003: NEW
  # * CMP0004: OLD
  # -------------------------------------------------------------------------
  # $<TARGET_POLICY:prop> may only be used with a limited number of policies.
  # Currently it may be used with the following policies:
  # * CMP0003
  # * CMP0004
  # * CMP0008
  # * CMP0020
  # * CMP0021
  # * CMP0022
  # * CMP0027
  # * CMP0038
  # * CMP0041
  # * CMP0042
  # * CMP0046
  /TARGET_POLICY/$<TARGET_POLICY:CMP0003> # /TARGET_POLICY/1
  /TARGET_POLICY/$<TARGET_POLICY:CMP0004> # /TARGET_POLICY/0
  
  
  /@@@/InformationExpressions/@@@
  # Information Expressions
  ## $<CONFIGURATION> !!DEPRECATED!!
  /CONFIGURATION/$<CONFIGURATION> # /CONFIGURATION/Debug
  
  ## $<CONFIG>
  /CONFIG/$<CONFIG> # /CONFIG/Debug
  
  ## $<PLATFORM_ID>
  /PLATFORM_ID/$<PLATFORM_ID> # /PLATFORM_ID/Darwin
  
  ## $<C_COMPILER_ID>
  /C_COMPILER_ID/$<C_COMPILER_ID> # /C_COMPILER_ID/Clang
  
  ## $<CXX_COMPILER_ID>
  /CXX_COMPILER_ID/$<CXX_COMPILER_ID> # /CXX_COMPILER_ID/Clang
  
  ## $<C_COMPILER_VERSION>
  /C_COMPILER_VERSION/$<C_COMPILER_VERSION> # /C_COMPILER_VERSION/6.0.0.6000054
  
  ## $<CXX_COMPILER_VERSION>
  /CXX_COMPILER_VERSION/$<CXX_COMPILER_VERSION> # /CXX_COMPILER_VERSION/6.0.0.6000054
  
  ## $<TARGET_FILE:...>
  /TARGET_FILE/$<TARGET_FILE:src1_bin> # /TARGET_FILE/.../gen/src1_bin
  
  ## $<TARGET_FILE_NAME:...>
  /TARGET_FILE_NAME/$<TARGET_FILE_NAME:src1_bin> # /TARGET_FILE_NAME/src1_bin
  
  ## $<TARGET_FILE_DIR:...>
  /TARGET_FILE_DIR/$<TARGET_FILE_DIR:src1_bin> # /TARGET_FILE_DIR/../gen
  
  ## $<TARGET_LINKER_FILE:...> 
  /TARGET_LINKER_FILE/$<TARGET_LINKER_FILE:hoge> # /TARGET_LINKER_FILE/.../gen/libhoge.a
  
  ## $<TARGET_LINKER_FILE_NAME:...>
  /TARGET_LINKER_FILE_NAME/$<TARGET_LINKER_FILE_NAME:hoge> # /TARGET_SONAME_FILE_NAME/libhoge.a
  
  ## $<TARGET_LINKER_FILE_DIR:...>
  /TARGET_LINKER_FILE_DIR/$<TARGET_LINKER_FILE_DIR:hoge> # /TARGET_LINKER_FILE_DIR/.../gen
  
  ## $<TARGET_SONAME_FILE:...>
  /TARGET_SONAME_FILE/$<TARGET_SONAME_FILE:foo> # /TARGET_SONAME_FILE/.../gen/libfoo.dylib
  
  ## $<TARGET_SONAME_FILE_NAME:...>
  /TARGET_SONAME_FILE_NAME/$<TARGET_SONAME_FILE_NAME:foo> # /TARGET_SONAME_FILE_NAME/libfoo.dylib
  
  ## $<TARGET_SONAME_FILE_DIR:...>
  /TARGET_SONAME_FILE_DIR/$<TARGET_SONAME_FILE_DIR:foo> # /TARGET_SONAME_FILE_DIR/.../gen
  
  ## $<TARGET_PROPERTY:...>
  /TARGET_PROPERTY/$<TARGET_PROPERTY:VALUE>          # /TARGET_PROPERTY/200
  /TARGET_PROPERTY/$<TARGET_PROPERTY:src1_bin,VALUE> # /TARGET_PROPERTY
  
  ## $<INSTALL_PREFIX>
  #[=[
    /INSTALL_PREFIX/$<INSTALL_PREFIX> #[[
      CMake Error at CMakeLists.txt:16 (set_property):
      Error evaluating generator expression:
      
        $<INSTALL_PREFIX>
      
      INSTALL_PREFIX is a marker for install(EXPORT) only.  It should never be evaluated.
    ]]
  ]=]
  
  
  /@@@/OutputExpressions/@@@
  # Output Expressions
  ## $<JOIN:...>
  /JOIN/$<JOIN:a\;b\;c,/> # /JOIN/a/b/c
  
  ## $<ANGLE-R>
  /ANGLE-R/$<ANGLE-R> # /ANGLE-R/>
  
  ## $<COMMA>
  /COMMA/$<COMMA> # /COMMA/,
  
  ## $<SEMICOLON>
  /SEMICOLON/\\$<SEMICOLON> # /SEMICOLON/;
  
  ## $<TARGET_NAME:...>
  /TARGET_NAME/$<TARGET_NAME:hoge> # /TARGET_NAME/hoge
  
  ## $<INSTALL_INTERFACE:...>
  /INSTALL_INTERFACE/$<INSTALL_INTERFACE:src1_bin> # /INSTALL_INTERFACE
  
  # $<BUILD_INTERFACE:...>
  /BUILD_INTERFACE/$<BUILD_INTERFACE:src1_bin> # /BUILD_INTERFACE/src1_bin
  
  # $<LOWER_CASE:...>
  /LOWER_CASE/$<LOWER_CASE:Hoge> # /LOWER_CASE/hoge
  
  # $<UPPER_CASE:...>
  /UPPER_CASE/$<UPPER_CASE:Hoge> # /UPPER_CASE/HOGE
  
  ## $<MAKE_C_IDENTIFIER:...>
  /MAKE_C_IDENTIFIER/$<MAKE_C_IDENTIFIER:0a-b\ c+d/eあf> # _0a_b_c_d_e___f
  
  /@@@/End/@@@
)
