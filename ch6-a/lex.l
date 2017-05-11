%{
#include "y.tab.h"
int num_of_column = 1;
%}


%option noyywrap


%%
[0-9]+              { 
    yylval.ival = atoi(yytext);
    num_of_column += strlen(yytext);
    return NUM;
}
[-+*(),\[\]\^T]     {
    yylval.ival = num_of_column;
    num_of_column++;
    return yytext[0];
}
[ ]                 { num_of_column++; }
[\t\f\v\n]          { ; }
.                   { ; }


%%