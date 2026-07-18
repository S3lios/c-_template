find_program(CLANG_TIDY_EXE clang-tidy)

if(NOT CLANG_TIDY_EXE)
    message(FATAL_ERROR "clang-tidy not found")
endif()


file(GLOB_RECURSE TIDY_FILES
    CONFIGURE_DEPENDS
    src/*.cpp
    tests/*.cpp
)


add_custom_target(check-tidy

    COMMAND
        ${CMAKE_COMMAND} -E echo
        "Running clang-tidy analysis"


    COMMAND
        ${CMAKE_COMMAND} -E env
        clang-tidy
        -p ${CMAKE_BINARY_DIR}
        ${TIDY_FILES}
        --warnings-as-errors=*


    WORKING_DIRECTORY
        ${CMAKE_SOURCE_DIR}


    COMMENT
        "Running clang-tidy"

)