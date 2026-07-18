cmake_minimum_required(VERSION 3.28)

include(cmake/gitversion.cmake)

project(
    XXX
    LANGUAGES CXX
    VERSION ${PROJECT_GIT_VERSION}
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

list(APPEND CMAKE_MODULE_PATH
    "${PROJECT_SOURCE_DIR}/cmake"
)

include(options)

configure_file(
    include/XXX/version.hpp.in
    ${CMAKE_CURRENT_BINARY_DIR}/generated/version.hpp
    @ONLY
)

if (ENABLE_CLANG_FORMAT) 
    include(format)
endif()

if (ENABLE_CHECK_DOC)
    include(doccheck)
endif()

if (ENABLE_CLANG_TIDY) 
    include(tidy)
endif()

add_subdirectory(src)

if (BUILD_TESTING)
    enable_testing()
    add_subdirectory(tests)
endif()

if (BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

if (BUILD_DOCS)
    add_subdirectory(docs)
endif()

include(cmake/summary.cmake)
