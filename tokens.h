#ifndef TOKENS_H
#define TOKENS_H

#include <string>
#include <vector>

typedef enum {
  ELSE,
  IF,
  INT,
  RETURN,
  VOID,
  WHILE,
  PLUS,
  MINUS,
  MULTIPLY,
  DIVIDE,
  LT,
  LTEQ,
  GT,
  GTEQ,
  EQ,
  NEQ,
  ASSIGN,
  SEMICOLON,
  COMA,
  LPAREN,
  RPAREN,
  LBRACKET,
  RBRACKET,
  LBRACE,
  RBRACE,
  COMMENT_START,
  COMMEN_END,
  ID,
  NUM,
  WHITESPACE,
  NUM_TOKENS
} TokenType;

extern std::vector<std::string> Keywords;



#endif
