cmake_minimum_required(VERSION 3.26)

project(VulkanTutorial)

# Tool to normalize path. Useful if working both on posix and windows platforms
# using msys2 for instance.
include(cmake/normalize_path.cmake)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Vulkan REQUIRED)

add_executable(VulkanTutorial main.cpp)

target_compile_features(VulkanTutorial PRIVATE cxx_std_23)

target_compile_options(VulkanTutorial PRIVATE -Wall -Wextra -Wshadow
  -Wnon-virtual-dtor -pedantic -Wold-style-cast -Wcast-align -Wunused
  -Woverloaded-virtual -Wconversion -Wdouble-promotion -Wformat=2
  -Wimplicit-fallthrough)

normalize_path($ENV{VULKAN_SDK}/lib/SDL2.lib SDL2_LIB_PATH)
target_link_libraries(VulkanTutorial Vulkan::Vulkan ${SDL2_LIB_PATH})

normalize_path($ENV{VULKAN_SDK}/include/SDL2/ SDL2_INCLUDE_PATH)
target_include_directories(VulkanTutorial PRIVATE ${SDL2_INCLUDE_PATH})
