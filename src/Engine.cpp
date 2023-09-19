#include "../include/Engine.hpp"

Engine::Engine(int width, int height, std::string title): _title(title), _width(width), _height(height)
{
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    _window = glfwCreateWindow(_width, _height, _title.c_str(), nullptr, nullptr);

    uint32_t extensionCount = 0;
    vkEnumerateInstanceExtensionProperties(nullptr, &extensionCount, nullptr);

    std::cout << extensionCount << " extensions supported\n";
}

Engine::~Engine()
{
    glfwDestroyWindow(_window);
    glfwTerminate();
}

void    Engine::loop()
{
    while(!glfwWindowShouldClose(_window)) {
        glfwPollEvents();
    }
}