EXE=parser

all: $(EXE).c
	$(CC) $< -Wall -Wno-unused-label -Werror -g -o $(EXE)


$(EXE).c: $(EXE).y
	bison $< -o $@
