%{
#include <stdio.h>
#include <ctype.h>

int yylex();
int yyerror();
%}

%%

command : exp { printf("%d\n", $1); }
        ; /* allows printing of the result */

exp : exp '+' term { $$ = $1 + $3; }
    | exp '-' term { $$ = $1 - $3; }
    | term { $$ = $1; }
    ;

term : term '*' factor { $$ = $1 * $3; }
     | factor { $$ = $1; }
     ;

factor : number { $$ = $1; }
       | '(' exp ')' { $$ = $2; }
       ;

number : number digit {$$ = 10*$1 + $2; }
       | digit { $$ = $1; }
       ;

digit : '0' { $$ = 0; } 
      | '1' { $$ = 1; } 
      | '2' { $$ = 2; } 
      | '3' { $$ = 3; } 
      | '4' { $$ = 4; } 
      | '5' { $$ = 5; } 
      | '6' { $$ = 6; } 
      | '7' { $$ = 7; } 
      | '8' { $$ = 8; } 
      | '9' { $$ = 9; }


%%

int main() {
  return yyparse();
}

int yylex() {
  int c;

  /* eliminate blanks*/
  while((c = getchar()) == ' ');

  /* makes the parse stop */
  if (c == '\n') return 0;

  return (c);
}

int yyerror(char * s) {
  fprintf(stderr, "%s\n", s);
  return 0;
} /* allows for printing of an error message */
