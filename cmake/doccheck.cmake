find_package(Python3 REQUIRED)

add_custom_target(check-doc
    COMMAND
        ${Python3_EXECUTABLE}
        ${PROJECT_SOURCE_DIR}/tools/check_doc.py

    WORKING_DIRECTORY
        ${PROJECT_SOURCE_DIR}

    COMMENT
        "Checking Doxygen comments in headers"
)