#pragma once

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <iostream>

class Engine {
    public:
        Engine(int width, int height, std::string title);
        ~Engine();
        void    loop();
    private:
        std::string _title;
        int         _width;
        int         _height;
        GLFWwindow  *_window;
};