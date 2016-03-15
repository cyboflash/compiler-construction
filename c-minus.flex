%{
#include "tokens.h"
#include <string>  // std::string, std::to_string
#include <map>     // std::map
#include <fstream> // std::ifstream
#include <iostream> // std::cout

static std::map<std::string, TokenType> KeywordToTokenType;
static yyFlexLexer l;
static unsigned columnno;

%}

%x IN_COMMENT

digit   [0-9]
letter  [a-zA-Z]
ID      {letter}+
NUM     {digit}+
ws      [ \t\n\r]+

/* direct flex to generate a scanner that maintains the number of the current 
   line read from its input in the global variable yylineno */
%option yylineno

/* make the scanner not call yywrap() upon an end-of-file, but simply assume 
   that there are no more files to scan (until the user points yyin at a new 
   file and calls yylex() again). 

   This is done because during compilation an error is generated saying that
   yywrap is not defined. */
%option noyywrap

/* direct flex to write the scanner to the scanner.cpp instead of lex.yy.c */
%option outfile="scanner.cpp"
%%
{ID} {
  std::map<std::string, TokenType>::iterator it = KeywordToTokenType.find(l.YYText());
  if (it != KeywordToTokenType.end())
    return it->second;
  return ID;
}

{NUM} return NUM;

"+"  return PLUS;
"-"  return MINUS;
"*"  return MULTIPLY;
"/"  return DIVIDE;
"<"  return LT;
"<=" return LTEQ;
">"  return GT;
">=" return GTEQ;
"==" return EQ;
"!=" return NEQ;
"="  return ASSIGN;
";"  return SEMICOLON;
","  return COMA;
"("  return LPAREN;
")"  return RPAREN;
"["  return LBRACKET;
"]"  return RBRACKET;
"{"  return LBRACE;
"}"  return RBRACE;

"/*"              BEGIN(IN_COMMENT);
<IN_COMMENT>"*/"  BEGIN(INITIAL);
<IN_COMMENT>.|\n  ;

{ws} ;

. { 
  std::string msg = "ERROR: Unknown symbol on line " + std::to_string(l.lineno()) + ": ";
  msg += l.YYText();
  l.LexerError(msg.c_str()); 
}

%%
void init(void);

int main(int argc, char **argv) {
  init();
 
  std::ifstream ifs(argv[1]);
  l.switch_streams(&ifs);
  while (l.yylex()) {}
  return 0;
}

void init(void) {
  columnno = 0;
  KeywordToTokenType["else"]   = ELSE;
  KeywordToTokenType["if"]     = IF;
  KeywordToTokenType["int"]    = INT;
  KeywordToTokenType["return"] = RETURN;
  KeywordToTokenType["void"]   = VOID;
}
