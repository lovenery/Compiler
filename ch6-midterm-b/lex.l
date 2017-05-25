%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option noyywrap

%%

"<and>"         { return ANDs; }
"</and>"        { return ANDe; }
"<or>"          { return ORs; }
"</or>"         { return ORe; }
"<not>"         { return NOTs; }
"</not>"        { return NOTe; }
"<true/>"       { yylval.ival = 1; return TaF; }
"<false/>"      { yylval.ival = 0; return TaF; }
.|\n            { ; }

%%
