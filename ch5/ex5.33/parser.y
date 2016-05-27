%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int yylex();
int yyerror();
%}

%token NUMBER

%%

command : exp '\n' { printf("%d\n", $1); exit(0); }
        ;

exp : exp '+' term { $$ = $1 + $3; }
    | exp '-' term { $$ = $1 - $3; }
    | exp exp { yyerror("missing operator"); exit(0); }
    | term { $$ = $1; }
    ;

half_exp : exp '+' { $$ = $1; }
         | exp '-' { $$ = $1; }
         | exp '*' { $$ = $1; }
         ;

term : term '*' factor { $$ = $1 * $3; }
     | factor { $$ = $1; }
     ;

factor : NUMBER { $$ = $1; }
       | '(' exp ')' { $$ = $2; }
       | '(' exp { yyerror("missing right parenthesis"); exit(0); }
       | exp ')' { yyerror("missing left parenthesis"); exit(0); }
       | '(' half_exp ')' { yyerror("missing operand"); exit(0); }
       ;

%%

int main(int argc, char** argv) {
  if (2 == argc && strcmp("-g", argv[1]))
    yydebug = 1;

  return yyparse();
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

  return (c);
}

int yyerror(char * s) {
  fprintf(stderr, "%s\n", s);
  return 0;
} /* allows for printing of an error message */
