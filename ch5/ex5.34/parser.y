%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "linkedstack.h"

int yylex();
int yyerror();

node *operatorStack;

%}

%token NUMBER

%%
command : lexp { printf("%d\n", $1); };

lexp : NUMBER { $$ = $1; }
     | '(' op lexp_seq ')' 
       { 
         int operator;
         operatorStack = pop(operatorStack, &operator); 
         switch(operator) {
           default: 
             yyerror("Unknown operator");
             exit(1);
             break;

           case '+':
           case '*':
             $$ = $3;
             break;

           case '-':
             $$ = -$3;
             break;
         }
       }
     ;

op : '+' { operatorStack = push(operatorStack, '+'); } 
   | '-' { operatorStack = push(operatorStack, '-'); } 
   | '*' { operatorStack = push(operatorStack, '*'); }
   ; 

lexp_seq : lexp_seq lexp 
           {
             switch(operatorStack->data) {
               default:
                 yyerror("Unrecognized operator");
                 exit(1);
                 break;
               case '+':
                 $$ = $1 + $2;
                 break;
               case '-':
                 $$ = $1 - $2;
                 break;
               case '*':
                 $$ = $1 * $2;
                 break;
             }
           }

         | lexp { $$ = $1; }
         ;
%%

int main(int argc, char** argv) {
  int retVal;

  init(operatorStack);

  if (2 == argc && (0 == strcmp("-g", argv[1])))
    yydebug = 1;

  retVal = yyparse();

  destroy(operatorStack);

  return retVal;
}

int yylex() {
  int c;

  /* eliminate blanks*/
  while((c = getchar()) == ' ');

  if (isdigit(c)) {
    ungetc(c, stdin);
    scanf("%d", &yylval);
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
