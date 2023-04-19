cmake_minimum_required(VERSION 3.26)
project(VulkanTutorial)

# Find Vulkan
find_package(Vulkan REQUIRED)

# Add executable
add_executable(VulkanTutorial main.cpp)

# Link with Vulkan
target_link_libraries(VulkanTutorial Vulkan::Vulkan)
