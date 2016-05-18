%{
#include <stdio.h>
#include <ctype.h>
#include <math.h>

#define YYSTYPE double

int yylex();
int yyerror();

%}

%token NUMBER

%left  '+' '-' 
%left  '*' '/' '%'
%right '^'

%%

command : exp { printf("%lf\n", $1); }
        ; /* allows printing of the result */

exp : '-' exp { $$ = -$2; }
    | exp '+' term { $$ = $1 + $3; }
    | exp '-' term { $$ = $1 - $3; }
    | term { $$ = $1; }
    ;

term : term '*' exponent { $$ = $1 * $3; }
     | term '/' exponent { $$ = $1 / $3; }
     | exponent { $$ = $1; }
     ;

exponent : factor '^' exponent { $$ = pow($1, $3); }
         | factor { $$ = $1; }
         ;

factor : NUMBER { $$ = $1; }
       | '(' exp ')' { $$ = $2; }
       ;

%%

int main() {
  return yyparse();
}

int yylex() {
  int c;
  while((c = getchar()) == ' ');
  /* eliminate blanks*/
  if (isdigit(c)) {
    ungetc(c, stdin);
    scanf("%lf", &yylval);
    return (NUMBER);
  }
  if (c == '\n') return 0;
  /* makes the parse stop */
  return (c);
}

int yyerror(char * s) {
  fprintf(stderr, "%s\n", s);
  return 0;
} /* allows for printing of an error message */
