%{
#include <stdio.h>
#include <string.h>
void yyerror(const char *message);
%}
%union{
int ival;
char* word;
}
%token<ival> INUMBER
%token<word> WORD
%type<ival> integer
%type<word> test
%%

line : test test integer { printf("%d\n", $3); }
     ;

test : WORD
     ;

integer : INUMBER { printf("first: %s second: %s\n", $<word>-1,$<word>0); $$=$1; }    
        ;

%%
void yyerror(const char *message)
{
	fprintf(stderr, "%s\n",message);
}

int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}
