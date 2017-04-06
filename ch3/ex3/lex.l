%{
%}
%x COMMENT
%%
"//"        { BEGIN COMMENT; }
<COMMENT>.  { }
<COMMENT>\n { BEGIN INITIAL;}
.|\n        { ECHO;/*printf("%s", yytext);*/ }
%%
int main(int argc, char *argv[]) {
    yylex();
    return 0;
    //  "//".*      { BEGIN INITIAL;/* Do nothing */ }
}
