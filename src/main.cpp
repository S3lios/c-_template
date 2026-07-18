#include <math/add.hpp>
#include <print>

int main() {
    try {
        std::println("Hello world !");
        std::println("1 + 1 = {}", add(1, 1));
        return EXIT_SUCCESS;
    } catch (...) {
        return EXIT_FAILURE;
    }
}