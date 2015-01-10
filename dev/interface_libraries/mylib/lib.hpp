#ifndef MYLIB_LIB_HPP
#define MYLIB_LIB_HPP

#include <iostream>

namespace mylib {
    void func();
}

#ifndef MYLIB_USE_LIBRARY
#include <mylib/lib.cpp>
#endif

#endif
