%{
#include <stdio.h>
#include <ctype.h>

#define YYSTYPE Res

typedef struct {
  double val;
  unsigned isDouble;
} Res;

int yylex();
int yyerror();
%}

%%

command : exp 
          { 
            if ($1.isDouble) printf("%lf\n", $1.val); 
            else printf("%d\n", (int)$1.val);
          }
        ; /* allows printing of the result */

exp : exp '+' term { $$.val = $1.val + $3.val; $$.isDouble = $1.isDouble || $3.isDouble; }
    | exp '-' term { $$.val = $1.val - $3.val; $$.isDouble = $1.isDouble || $3.isDouble; }
    | term { $$.val = $1.val; }
    ;

term : term '*' factor { $$.val = $1.val * $3.val; $$.isDouble = $1.isDouble || $3.isDouble; }
     | factor { $$.val = $1.val; }
     ;

factor : integer { $$.val = $1.val; }
       | float {$$.val = $1.val; }
       | '(' exp ')' { $$.val = $2.val; }
       ;

integer : integer digit { $$.val = 10*$1.val + $2.val; $$.isDouble = 0; }
        | digit { $$.val = $1.val; $$.isDouble = 0; }
        ;

float : integer '.' fraction { $$.val = $1.val + $3.val; $$.isDouble = 1; }

fraction : digit fraction { $$.val = 0.1*$1.val + 0.1*$2.val; }
         | digit { $$.val = 0.1*$1.val; }

digit : '0' { $$.val = 0; } 
      | '1' { $$.val = 1; } 
      | '2' { $$.val = 2; } 
      | '3' { $$.val = 3; } 
      | '4' { $$.val = 4; } 
      | '5' { $$.val = 5; } 
      | '6' { $$.val = 6; } 
      | '7' { $$.val = 7; } 
      | '8' { $$.val = 8; } 
      | '9' { $$.val = 9; }


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
