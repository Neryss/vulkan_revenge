CC= clang++
CFLAGS=  -Wall -Wextra -Werror -std=c++17
MAKEFLAGS += --no-print-directory -j

NAME= vox

HEADER_PATH := ./include
HEADER := $(wildcard $(HEADER_PATH)/*.hpp)

SRC_PATH := ./src
SRC := $(wildcard $(SRC_PATH)/*.cpp)
OBJS = $(SRC:%.cpp=%.o)

OS= $(shell uname)

#g++ .\src\main.cpp -IC:\msys64\glfw-3.3.8.bin.WIN64\include -IC:\VulkanSDK\1.3.261.1\Include -o a.exe

ifeq ($(OS), Linux)
	CC= clang++
	LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
else ifeq ($(OS), Windows)
	NAME= vox.exe
	CC= /mnt/c/mingw64/bin/g++.exe
	CFLAGS += -I"C:\VulkanSDK\1.3.261.1\Include" -I"C:\mingw64\glfw\include" -static
	LDFLAGS = -L"C:\VulkanSDK\1.3.261.1\Lib" -lvulkan-1 -L"C:\mingw64\glfw\lib-vc2022" -lglfw3dll
endif

%.o: %.cpp Makefile $(HEADER)
	$(CC) $(CFLAGS) -c $< -o $@

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $(NAME)

clean:
	@rm -f $(OBJS)

fclean: clean
	@rm -f $(NAME)
	@rm -f vox.exe

re: fclean
	$(MAKE) all

run: $(NAME)
	./$(NAME)


.PHONY: clean fclean re run debug leaks