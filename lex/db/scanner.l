%{
#include "scanner.h"
%}

%%
:                 return COLON;
"db_type"         return TYPE;
"db_name"         return NAME;
"db_table_prefix" return TABLE_PREFIX;
"db_port"         return PORT;

[a-zA-Z][_a-zA-Z0-9]* return IDENTIFIER;
[1-9][0-9]*           return INTEGER;
[ \t\n]               ; /*ignore space tab \n */
.                     printf("unexpected character\n");
%%

// 加了這個就不用依賴flex library (gcc lex.yy.c -ll => gcc lex.yy.c)
int yywrap(void)
{
  return 1;
}