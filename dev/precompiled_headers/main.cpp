#include <iostream>
#include <boost/asio.hpp>

int main() {
    namespace asio = boost::asio;
    using asio::ip::tcp;
    
    tcp::iostream s("www.boost.org","http"); s
        << "GET / HTTP/1.0\r\n"
        << "Host: www.boost.org\r\n"
        << "\r\n"
        << std::flush;
    
    std::string l;
    while (std::getline(s,l)) std::cout << l << std::endl;
    
    return 0;
}
