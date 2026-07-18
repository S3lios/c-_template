find_package(Git QUIET)

set(PROJECT_GIT_TAG "N/A")
set(PROJECT_GIT_HASH "N/A")
set(PROJECT_GIT_VERSION "0.0.0")


if(NOT GIT_FOUND)
    message(WARNING "Git not found, version information unavailable")
else()

    set(PROJECT_GIT_VERSION "0.0.0")

    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
        RESULT_VARIABLE GIT_HASH_RESULT
    )

    if(GIT_HASH_RESULT EQUAL 0 AND NOT GIT_HASH STREQUAL "")
        set(PROJECT_GIT_HASH "${GIT_HASH}")

        execute_process(
            COMMAND ${GIT_EXECUTABLE} status --porcelain
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            OUTPUT_VARIABLE GIT_DIRTY
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        if(NOT GIT_DIRTY STREQUAL "")
            set(PROJECT_GIT_HASH "${PROJECT_GIT_HASH}+")
        endif()
    endif()


    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --tags --abbrev=0
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_TAG
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
        RESULT_VARIABLE GIT_TAG_RESULT
    )

    if(GIT_TAG_RESULT EQUAL 0 AND NOT GIT_TAG STREQUAL "")

        set(PROJECT_GIT_TAG "${GIT_TAG}")

        execute_process(
            COMMAND ${GIT_EXECUTABLE}
                rev-list ${GIT_TAG}..HEAD --count
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            OUTPUT_VARIABLE COMMITS_AFTER_TAG
            OUTPUT_STRIP_TRAILING_WHITESPACE
            ERROR_QUIET
        )

        if(COMMITS_AFTER_TAG GREATER 0)
            set(PROJECT_GIT_TAG "${PROJECT_GIT_TAG}+")
        endif()

    endif()

    set(PROJECT_GIT_VERSION "0.0.0")

    if(GIT_TAG_RESULT EQUAL 0 AND NOT GIT_TAG STREQUAL "")

        # Extract X.X.X or X.X.X.X from the tag
        if(GIT_TAG MATCHES "([0-9]+\\.[0-9]+\\.[0-9]+(\\.[0-9]+)?)")

            set(PROJECT_GIT_VERSION "${CMAKE_MATCH_1}")
        else()
            set(PROJECT_GIT_VERSION "0.0.0")
        endif()

    endif()

endif()


# Export vers le scope parent uniquement si nécessaire
set(PROJECT_GIT_TAG "${PROJECT_GIT_TAG}" PARENT_SCOPE)
set(PROJECT_GIT_HASH "${PROJECT_GIT_HASH}" PARENT_SCOPE)