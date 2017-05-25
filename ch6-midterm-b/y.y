%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(char *msg) {
    printf("語法錯誤\n");
}
char ans;
%}


%union {
    char ival;
    char arr[2];
}
%token <ival> ANDs ANDe ORs ORe NOTs NOTe TaF
%type <ival> E
%type <arr> T


%%
S   :   E                 { ans = $1; }
    ;

E   :   ANDs T ANDe       { $$ = $2[0]; }
    |   ORs T ORe         { $$ = $2[1]; }
    |   NOTs E NOTe       { $$ = !$2; }
    |   TaF               { $$ = $1; }
    ;

T   :   E T               {
        $$[0] = ($1 & $2[0]);
        $$[1] = ($1 | $2[1]);
    }
    |   /* between tag */ { $$[0] = 1; $$[1] = 0; }
    ;
%%

int main() {
    yyparse();
    if (ans != '\0') {
        printf("true\n"); 
    } else {
        printf("false\n");
    }
    return(0);
}
