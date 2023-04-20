cmake_minimum_required(VERSION 3.26)

project(VulkanTutorial)

# Tool to normalize path. Useful if working both on posix and windows platforms
# using msys2 for instance.
include(cmake/normalize_path.cmake)

# Find Vulkan
find_package(Vulkan REQUIRED)

# Add executable
add_executable(VulkanTutorial main.cpp)

normalize_path($ENV{VULKAN_SDK}/lib/SDL2.lib SDL2_LIB_PATH)
target_link_libraries(VulkanTutorial Vulkan::Vulkan ${SDL2_LIB_PATH})

normalize_path($ENV{VULKAN_SDK}/include/SDL2/ SDL2_INCLUDE_PATH)
target_include_directories(VulkanTutorial PRIVATE ${SDL2_INCLUDE_PATH})
