CC= clang++
CFLAGS=  -Wall -Wextra -Werror -std=c++17
# LDFLAGS=  -lGL -lGLU -lGLEW -lglfw
LDFLAGS=
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
else ifeq ($(OS), Windows)
	CFLAGS += -I"C:\VulkanSDK\1.3.261.1\Include" -I"C:\MinGW\glfw-3.3.8.bin.WIN64\include\GLFW"
	LDFLAGS = -L"C:\VulkanSDK\1.3.261.1\Lib" -lvulkan-1 -L"C:\MinGW\glfw\lib-mingw-w64" -lglfw3dll
	CC= mingw32-g++.exe
endif

%.o: %.cpp Makefile $(HEADER)
	$(CC) $(CFLAGS) -c $< -o $@

all: $(NAME)

leaks: CFLAGS += -g3 -fsanitize=address
leaks: $(OBJS)
leaks: $(NAME)
	./$(NAME)

debug: CFLAGS += -g3
debug: $(OBJS)
debug: $(NAME)
	lldb ./${NAME}

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