%{
%}
match_cpy   [_A-Za-z0-9]*cpy[_A-Za-z0-9]*
%%
{match_cpy} {
    printf("%s\n", yytext);
}
\n {}
. {}
%%
int main(int argc, char *argv[]) {
    yylex();
    return(0);
}