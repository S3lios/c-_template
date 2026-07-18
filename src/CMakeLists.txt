add_executable(XXX)

target_include_directories(XXX
    PUBLIC
        ${CMAKE_CURRENT_BINARY_DIR}/generated
        ${CMAKE_SOURCE_DIR}
)

add_subdirectory(math)

target_sources(XXX
    PRIVATE
        main.cpp
)

target_link_libraries(XXX
    PRIVATE
        math
)

install(TARGETS XXX
    RUNTIME DESTINATION bin
)