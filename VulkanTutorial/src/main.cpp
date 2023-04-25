#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>
#include <fmt/core.h>
#include <iostream>
#include <vulkan/vulkan.hpp>

class HelloTriangleApplication
{
public:
  void run()
  {
    initWindow();
    initVulkan();
    mainLoop();
    cleanup();
  }

private:
  SDL_Window *window_{ nullptr };

  void initWindow()
  {
    if( SDL_Init( SDL_INIT_VIDEO ) == 0 )
      throw std::runtime_error{ "Could not initialize SDL2 video subsystem." };

    constexpr unsigned int width = 800, height = 600;
    window_ = SDL_CreateWindow( "VulkanTutorial", SDL_WINDOWPOS_UNDEFINED,
                                SDL_WINDOWPOS_UNDEFINED, width, height,
                                SDL_WINDOW_SHOWN | SDL_WINDOW_VULKAN );

    if( window_ == nullptr )
      throw std::runtime_error{ "Could not create a SDL2 window" };
  }

  void initVulkan()
  {
    uint32_t extensionCount = 0;
    vkEnumerateInstanceExtensionProperties( nullptr, &extensionCount, nullptr );

    if( extensionCount == 0 )
    {
      throw std::runtime_error{
        "Could not get supported vulkan extension count."
      };
    }
  }

  void mainLoop()
  {
    bool done = false;
    while( !done )
    {
      SDL_Event event;
      while( SDL_PollEvent( &event ) != 0 )
      {
        if( event.type == SDL_QUIT )
          done = true;
      }
    }
  }

  void cleanup()
  {
    SDL_DestroyWindow( window_ );
    SDL_Quit();
  }
};

auto main( int /*unused*/, char * /*unused*/[] ) -> int
{
  HelloTriangleApplication app;

  try
  {
    app.run();
  }
  catch( const std::exception &e )
  {
    fmt::print( "Global failure: {}\n", e.what() );
    fmt::print( "Press any key to continue...\n" );
    std::cin.get();

    return EXIT_FAILURE;
  }

  fmt::print( "Press any key to continue...\n" );
  std::cin.get();

  return EXIT_SUCCESS;
}
