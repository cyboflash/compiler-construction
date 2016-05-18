all: parser.c
	$(CC) -Wall -Werror $< -lm

parser.c: parser.y
	bison $< -v -o $@
