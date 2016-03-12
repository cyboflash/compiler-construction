%{
#include "tokens.h"

std::vector<std::string> Keywords = {"else", "if", "int", "return", "void"};
%}

/* direct flex to generate a scanner that maintains the number of the current 
   line read from its input in the global variable yylineno */
%option yylineno

/* make the scanner not call yywrap() upon an end-of-file, but simply assume 
   that there are no more files to scan (until the user points yyin at a new 
   file and calls yylex() again). */
%option noyywrap
%%
%%
int main(void) {
  for ( yyFlexLexer l; l.yylex(); ) {}
  return 0;
}
