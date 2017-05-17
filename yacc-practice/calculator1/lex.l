%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

/* solve yywrap 1 */
%option noyywrap

%%

[0-9]+(\.[0-9]+)?([eE][0-9]+)?  { yylval.f = atof(yytext); return NUM; }
[-+()*/]                        { return yytext[0]; }
[ \t\f\v\n]                     { ; }

%%

/* solve yywrap 2 */
/*int yywrap () {return -1;}*/

/* solve yywrap 3 */
/* OS:X gcc ..... -ll */
/* Linux gcc ..... -lfl */