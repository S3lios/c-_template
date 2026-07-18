add_library(math)

target_sources(math
    PRIVATE
        src/add.cpp
)

target_include_directories(math
    PUBLIC
        include
)