#include <iostream>
#include <vector>
#include <string>
#include <chrono>
#include <thread>
#include <cstdlib>
#include <boost/filesystem.hpp>

int main(int argc, char * argv[]) {
    std::cout << "### test.cpp" << std::endl;
    
    std::vector<std::string> args(argv, argv + argc);
    for (auto && v: args) {
        std::cout << "@@ args: " << v << std::endl;
    }
    
    std::cout << "@@ working_dir: " << boost::filesystem::current_path() << std::endl;
    
    std::cout << "@@ ${VALUE1}: ";
    if (auto && env = std::getenv("VALUE1")) std::cout << env;
    std::cout << std::endl;
    
    std::cout << "@@ ${VALUE2}: ";
    if (auto && env = std::getenv("VALUE2")) std::cout << env;
    std::cout << std::endl;
    
    std::cout << "@@ sleep..." << std::endl;
    std::this_thread::sleep_for(std::chrono::seconds{2});
    std::cout << "@@ finish" << std::endl;
    
    return 0;
}
