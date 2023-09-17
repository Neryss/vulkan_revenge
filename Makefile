CC= clang++
CFLAGS=  -Wall -Wextra -Werror -std=c++17
MAKEFLAGS += --no-print-directory -j

NAME= vox

HEADER_PATH := ./headers
HEADER := $(wildcard $(HEADER_PATH)/*.hpp)

SRC_PATH := ./src
SRC := $(wildcard $(SRC_PATH)/*.cpp)
OBJS = $(SRC:%.cpp=%.o)

OS= $(shell uname)

ifeq ($(OS), Linux)
	CC= clang++
	LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
else ifeq ($(OS), Windows)
	CC= mingw32-g++.exe
	CFLAGS += -IC:\VulkanSDK\1.3.261.1\Include -IC:\MinGW\glfw-3.3.8.bin.WIN64\include
	LDFLAGS = -LC:\VulkanSDK\1.3.261.1\Lib -lvulkan-1 -LC:\MinGW\glfw\lib-mingw-w64 -lglfw3dll
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

re: fclean
	$(MAKE) all

run: $(NAME)
	./$(NAME)


.PHONY: clean fclean re run debug leaks