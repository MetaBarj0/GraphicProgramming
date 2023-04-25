#define SDL_MAIN_HANDLED
#include <SDL2/SDL.h>
#include <vulkan/vulkan.hpp>

auto main( int /*unused*/, char * /*unused*/[] ) -> int
{
  if( SDL_Init( SDL_INIT_VIDEO ) != 0 )
    return 1;

  constexpr unsigned int width = 800, height = 600;
  auto *window = SDL_CreateWindow( "VulkanTutorial", SDL_WINDOWPOS_UNDEFINED,
                                   SDL_WINDOWPOS_UNDEFINED, width, height,
                                   SDL_WINDOW_SHOWN | SDL_WINDOW_VULKAN );

  uint32_t extensionCount = 0;
  vkEnumerateInstanceExtensionProperties( nullptr, &extensionCount, nullptr );

  if( extensionCount == 0 )
    return 1;

  if( window == nullptr )
    return 1;

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

  SDL_DestroyWindow( window );
  SDL_Quit();

  return 0;
}
