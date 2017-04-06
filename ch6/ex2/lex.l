%{
#include "y.tab.h"
%}
%%

\n	{ return(0); /* EOF */ }
[ \t]+	{ /* do nothing */ }
[0-9]+	{ yylval.ival= atoi(yytext); return(INUMBER); }
[a-zA-Z]+ { yylval.word = strdup(yytext); return WORD; }

.	{ return(yytext[0]); }

%%

