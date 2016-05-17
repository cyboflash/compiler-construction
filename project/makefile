LEX=flex++

CC=g++
CXXFLAGS=-std=c++11 -I . -Wall -Werror -fmax-errors=1

scanner: scanner.o

scanner.cpp: c-minus.flex
	$(LEX) $<

clean:
	rm -f scanner *.o scanner.cpp
