all: parser.c
	$(CC) $< -Wall -Werror -g

parser.c: parser.y
	bison $< -o $@
