#include <mylib/lib.hpp>

#ifdef MYLIB_USE_LIBRARY
#define MYLIB_INLINE
#else
#define MYLIB_INLINE inline
#endif

namespace mylib {
    MYLIB_INLINE void func() {
        std::cout << "mylib::func()" << std::endl;
    }
}
