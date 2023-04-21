if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    add_compile_options(-Wall -Wextra -Wshadow -Wnon-virtual-dtor -pedantic
      -Wold-style-cast -Wcast-align -Wunused -Woverloaded-virtual -Wconversion
      -Wdouble-promotion -Wformat=2 -Wimplicit-fallthrough)

    # unsupported on windows platforms
    if(NOT WIN32)
      add_compile_options(-fsanitize=safe-stack)
    endif()
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_compile_options(-fsanitize=undefined)
endif()
