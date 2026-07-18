find_program(CLANG_FORMAT_EXE clang-format)

if(NOT CLANG_FORMAT_EXE)
    message(FATAL_ERROR "clang-format not found")
endif()

file(GLOB_RECURSE FORMAT_FILES
    CONFIGURE_DEPENDS
    src/*.cpp
    src/*.hpp
    include/*.hpp
    tests/*.cpp
)

add_custom_target(check-format
    COMMAND
        ${CLANG_FORMAT_EXE}
        --dry-run
        --Werror
        ${FORMAT_FILES}

    COMMENT
            "Checking source formatting with clang-format"
)

add_custom_target(apply-format

    COMMAND
        ${CMAKE_COMMAND} -E echo
        "Applying clang-format"


    COMMAND
        ${CLANG_FORMAT_EXE}
        -i
        ${FORMAT_FILES}


    WORKING_DIRECTORY
        ${CMAKE_SOURCE_DIR}


    COMMENT
        "Formatting source files with clang-format"

)