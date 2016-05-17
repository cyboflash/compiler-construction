#ifndef TOKENS_H
#define TOKENS_H

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
  ID,
  NUM,
  NUM_TOKEN_TYPES
} TokenType;

#endif
