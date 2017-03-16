%{
%}
/* why can't \s pass!? */
match_noodles2   [a-zA-Z]+\s+[a-zA-Z]+\s+noodles\s+[a-zA-Z]+
match_noodles   [a-zA-Z]+[ ]+[a-zA-Z]+[ ]+noodles[ ]+[a-zA-Z]+
%%
{match_noodles} {
    printf("%s\n", yytext);
}
\n {}
. {}
%%
int main(int argc, char *argv[]) {
    yylex();
    return(0);
}