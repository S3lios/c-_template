add_executable(math_tests)

target_sources(math_tests
    PRIVATE
        test_math.cpp
)

target_link_libraries(math_tests
    PRIVATE
        math
        GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(math_tests)