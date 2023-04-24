find_package(Vulkan REQUIRED)

set(VulkanTutorial_sources "main.cpp")

add_executable(VulkanTutorial ${VulkanTutorial_sources})

target_compile_features(VulkanTutorial PRIVATE cxx_std_23)

# provide a function to create sanitized target and expose their names in the
# specified target properties
include(../cmake/create_clang_sanitize_targets.cmake)

# Tool to normalize path. Useful if working both on posix and windows platforms
# using msys2 for instance.
include(../cmake/normalize_path.cmake)

normalize_path($ENV{VULKAN_SDK}/lib/SDL2.lib SDL2_LIB_PATH)
target_link_libraries(VulkanTutorial Vulkan::Vulkan ${SDL2_LIB_PATH})

normalize_path($ENV{VULKAN_SDK}/include/SDL2/ SDL2_INCLUDE_PATH)
target_include_directories(VulkanTutorial PRIVATE ${SDL2_INCLUDE_PATH})

create_clang_sanitize_targets(VulkanTutorial ${VulkanTutorial_sources})
