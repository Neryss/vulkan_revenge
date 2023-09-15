CC= clang++
CFLAGS=  -Wall -Wextra -Werror -std=c++17
LDFLAGS=  -lGL -lGLU -lGLEW -lglfw
MAKEFLAGS += --no-print-directory -j

NAME= vox

HEADER_PATH := ./headers
HEADER := $(wildcard $(HEADER_PATH)/*.hpp)

SRC_PATH := ./src
SRC := $(wildcard $(SRC_PATH)/*.cpp)
OBJS = $(SRC:%.cpp=%.o)


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