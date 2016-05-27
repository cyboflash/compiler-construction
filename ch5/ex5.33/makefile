EXE=parser

YACC=bison
YFLAGS= -v --graph -x -r all -t

CFLAGS= -Wall -Werror -g

# Files with these extensions will be removed
RM_EXT=c output dot xml pdf png html

all: $(EXE) dfa

$(EXE): $(EXE).c
	$(CC) $< $(CFLAGS) -o $@

clean:
	rm -f $(EXE)
	for ext in $(RM_EXT) ; do \
		rm -f *.$$ext ; \
	done

$(EXE).c: $(EXE).y
	$(YACC) $< $(YFLAGS) -o $@

# Creates an image of a DFA
dfa: $(EXE).png

$(EXE).png: $(EXE).dot
	dot $< -Tpng -o $@

$(EXE).dot: $(EXE)
