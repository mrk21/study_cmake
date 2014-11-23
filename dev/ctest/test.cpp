#include <iostream>
#include <vector>
#include <string>
#include <boost/filesystem.hpp>

int main(int argc, char * argv[]) {
    std::vector<std::string> args(argv, argv + argc);
    std::cout << "######### test" << std::endl;
    for (auto && v: args) {
        std::cout << "======= " << v << std::endl;
    }
    std::cout << boost::filesystem::current_path() << std::endl;
    return 0;
}
