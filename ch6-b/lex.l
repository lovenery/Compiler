%{
#include "y.tab.h"
%}

%%
\n { return 0; }
[A-Z][a-z]? {
    char *name = (char*) malloc(sizeof(yytext));
    strcpy(name, yytext);
    yylval.name = name;
    return ELEMENT;
}
[0-9]+ {
    yylval.ival = atoi(yytext);
    return NUMBER;
}
[->+\(\)] { return yytext[0]; }
.         { /*do nothing*/ }
%%
