option(BUILD_TESTING "Build unit tests" ON)
option(BUILD_EXAMPLES "Build examples" OFF)
option(BUILD_DOCS "Build documentation" OFF)
option(BUILD_SHARED_LIBS "Build shared libraries" ON)

option(ENABLE_CHECK_DOC 
    "Enable documentation check"
    OFF
)

option(
    ENABLE_CLANG_FORMAT
    "Enable clang-format target"
    OFF
)

option(
    ENABLE_CLANG_TIDY
    "Enable clang-tidy"
    OFF
)