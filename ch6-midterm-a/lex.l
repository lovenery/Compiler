%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option noyywrap

/*
    fail...
    lshift  "<<"
    rshift  '>' '>'
*/
%%


[(&)(|)(^)(~)(<<)(>>)]                  { return yytext[0]; }
[ \t]+                                  { return SPACES; }
([1-2]?[0-9])|"30"|"31"                 { yylval.f = atoi(yytext); return NUM; }
-[1-9][0-9]*|(3[2-9])|([4-9][0-9])      { printf("integer out of range"); exit(0); }
[\f\v\n]                                { ; }
.                                       { ; }
%%

// 0~31