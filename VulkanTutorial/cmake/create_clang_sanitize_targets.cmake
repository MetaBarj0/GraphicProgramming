# this function will create targets that are built using different llvm
# sanitizers and output newly create target names in a variable of your
# choosing.
# arguments:
# - input:
#   - target is a string representing the base target name for an executable or
#     a library.
#   - sources is a list of source file to build the newly created sanitized
#     target. It is the same list used to create the base target.
# - ouput:
#   - results is an output argument that will contain the list of new targets
#     under sanitization.
# usage example:
# - first, include this cmake file to use the function:
#   `include(cmake/create_clang_sanitize_targets.cmake)`
# - then, call the function such as:
#   `create_clang_sanitize_targets(MyTarget ${Sources} SanitizedTargets)`
# - finally, after the call, you can observe 2 things:
#   - up to 3 new targets are created (it depends on the platform) for
#     instance:
#     - MyTargetSanitizeAddress
#     - MyTargetSanitizeThread
#     - MyTargetSanitizeMemory
#     you will be able to see newly created target in a message at generation
#     time.
#   - The variable `SanitizedTargets` you pass to the function will be
#     initialized with the list of newly created target names. This variable
#     can be used to build targets for test suites for instance.
function(create_clang_sanitize_targets target sources results)
  if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug" OR NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    return()
  endif()

  string(CONCAT TargetSanitizeAddress "${target}" "SanitizeAddress")

  add_executable(${TargetSanitizeAddress} EXCLUDE_FROM_ALL ${sources})

  target_compile_features(${TargetSanitizeAddress} PRIVATE cxx_std_23)
  target_compile_options(${TargetSanitizeAddress} PRIVATE -fsanitize=address)
  target_link_options(${TargetSanitizeAddress} PRIVATE -fsanitize=address)
  set(sanitize_target_list "${TargetSanitizeAddress}")

  # unsupported on windows platform
  if(NOT WIN32)
    string(CONCAT TargetSanitizeThread "${target}" "SanitizeThread")

    add_executable(${TargetSanitizeThread} EXCLUDE_FROM_ALL ${sources})

    target_compile_features(${TargetSanitizeThread} PRIVATE cxx_std_23)
    target_compile_options(${TargetSanitizeThread} PRIVATE -fsanitize=thread)
    target_link_options(${TargetSanitizeThread} PRIVATE -fsanitize=thread)

    set(sanitize_target_list "${sanitize_target_list}" "${TargetSanitizeThread}")
  endif()

  # unsupported on windows platform
  if(NOT WIN32)
    string(CONCAT TargetSanitizeMemory "${target}" "SanitizeMemory")

    add_executable(TargetSanitizeMemory EXCLUDE_FROM_ALL ${sources})

    target_compile_features(${TargetSanitizeMemory} PRIVATE cxx_std_23)
    target_compile_options(${TargetSanitizeMemory} PRIVATE -fsanitize=memory)
    target_link_options(${TargetSanitizeMemory} PRIVATE -fsanitize=memory)

    set(sanitize_target_list "${sanitize_target_list}" "${TargetSanitizeMemory}")
  endif()

  message("Additional sanitized targets:")

  foreach(target IN LISTS sanitize_target_list)
    message("  - ${target}")
  endforeach()

  message("You have to specifically ask your build system to build those target that are excluded from the all target.")
  message("Newly created target names are stored in the `${results}` variable.")

  set(${results} ${sanitize_target_list} PARENT_SCOPE)
endfunction()

