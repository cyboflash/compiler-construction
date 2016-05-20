%{
#include <stdio.h>
#include <ctype.h>

#define YYSTYPE SyntaxTree

typedef enum {Plus, Minus, Times, None} OpKind;
typedef enum {OpK, ConstK} ExpKind;
typedef struct streenode {
  ExpKind exp;
  OpKind op;

  struct streenode *lChild, *rChild;
  int val;
} STreeNode;

typedef STreeNode* SyntaxTree;

int yylex();
int yyerror();
int calculate(SyntaxTree t);

STreeNode* newConstNode(int val);
STreeNode* newOpNode(OpKind kind);

SyntaxTree syntaxTree;

%}

%token NUMBER

%%

command : exp { syntaxTree = $1; }
        ; /* allows printing of the result */

exp : exp '+' term
      { 
        $$ = newOpNode(Plus);
        $$->lChild = $1; 
        $$->rChild = $3; 
      }
    | exp '-' term 
      { 
        $$ = newOpNode(Minus);
        $$->lChild = $1; 
        $$->rChild = $3; 
      }
    | term { $$ = $1; }
    ;

term : term '*' factor 
       { 
         $$ = newOpNode(Times); 
         $$->lChild = $1;
         $$->rChild = $3;
       }
     | factor { $$ = $1; }
     ;

factor : NUMBER { $$ = $1; }
       | '(' exp ')' { $$ = $2; }
       ;

%%

int main() {
  int ret;
  syntaxTree = NULL;
  ret = yyparse();

  /* If parsing is successful */
  if (!ret) {
    if (NULL != syntaxTree)
      printf("%d\n", calculate(syntaxTree));
  } 
  return ret;
}

int yylex() {
  int c;

  /* eliminate blanks*/
  while((c = getchar()) == ' ');

  if (isdigit(c)) {
    ungetc(c, stdin);
    scanf("%d", &c);
    yylval = newConstNode(c);
    return (NUMBER);
  }

  /* makes the parse stop */
  if (c == '\n') return 0;

  return (c);
}

int yyerror(char * s) {
  fprintf(stderr, "%s\n", s);
  return 0;
} /* allows for printing of an error message */

int calculate(SyntaxTree t) {
  int l, r;
  switch(t->exp) {
    ConstK: return t->val;
    OpK: 
      l = calculate(t->lChild);
      r = calculate(t->rChild);
      switch(t->op) {
        Plus: return l + r;
        Minus: return l - r;
        Times: return l * r;
        default: printf("ERROR: Unknown operator type, %d\n", t->op); 
      }
      break;
    default: printf("ERROR: Unknown node type, %d\n", t->exp);
  }
  return ~0;
}

STreeNode* newConstNode(int val) {
  STreeNode* node = malloc(sizeof(STreeNode)); 
  if (NULL == node)
    printf("ERROR:Out of memory. Unable to allocate memory for a new node. \n");
  else {
    node->exp = ConstK;
    node->op = None;
    node->val = val;
    node->lChild = NULL;
    node->rChild = NULL;
  }
  return node;
}

STreeNode* newOpNode(OpKind kind) {
  STreeNode* node = malloc(sizeof(STreeNode)); 
  if (NULL == node)
    printf("ERROR:Out of memory. Unable to allocate memory for a new node. \n");
  else {
    node->exp = OpK;
    node->op = kind;
    node->val = ~0;
    node->lChild = NULL;
    node->rChild = NULL;
  }
  return node;
}
