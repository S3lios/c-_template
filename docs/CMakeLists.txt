find_package(Doxygen REQUIRED)

set(DOXYGEN_WARNINGS_AS_ERRORS YES)
if(Doxygen_FOUND)

    message(STATUS "Doxygen found: ${DOXYGEN_EXECUTABLE}")

else()

    message(WARNING
        "Doxygen not found, API documentation disabled"
    )

endif()

# -------------------------
# Doxygen API documentation
# -------------------------

set(DOXYGEN_OUTPUT_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}/doxygen
)

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/doxygen/Doxyfile.in
    ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
    @ONLY
)

add_custom_target(doc_api
    COMMAND
        ${DOXYGEN_EXECUTABLE}
        ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile

    WORKING_DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}

    COMMENT
        "Generating API documentation with Doxygen"
)


# -------------------------
# Architecture PDF (LaTeX)
# -------------------------
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/latex/version.tex.in
    ${CMAKE_CURRENT_BINARY_DIR}/latex/version.tex
    @ONLY
)

find_package(LATEX COMPONENTS PDFLATEX)

if(LATEX_FOUND)

    set(LATEX_OUTPUT_DIR
        ${CMAKE_CURRENT_BINARY_DIR}/latex
    )
    file(MAKE_DIRECTORY ${LATEX_OUTPUT_DIR})

    add_custom_target(doc_latex
        COMMAND
            ${CMAKE_COMMAND} -E env
            TEXINPUTS=${LATEX_OUTPUT_DIR}:$ENV{TEXINPUTS}
            ${PDFLATEX_COMPILER}
            -interaction=nonstopmode
            -output-directory ${LATEX_OUTPUT_DIR}
            ${CMAKE_CURRENT_SOURCE_DIR}/latex/main.tex

        WORKING_DIRECTORY
            ${CMAKE_CURRENT_SOURCE_DIR}/latex

        COMMENT
            "Generating architecture documentation"
    )

    add_custom_command(
        TARGET doc_latex
        POST_BUILD
        COMMAND
            ${CMAKE_COMMAND} -E copy
            ${LATEX_OUTPUT_DIR}/main.pdf
            ${LATEX_OUTPUT_DIR}/${PROJECT_NAME}_Architecture.pdf
    )

else()

    message(WARNING
        "LaTeX not found, architecture documentation disabled"
    )

endif()


# -------------------------
# Documentation complète
# -------------------------

add_custom_target(doc
    DEPENDS
        doc_api
        doc_latex
)