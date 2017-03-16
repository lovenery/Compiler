%{
unsigned int charCount=0, wordCount=0, lineCount=0;
%}
letter          [a-zA-z_]
digit           [0-9]
identifier      {letter}({letter}|{digit})*
%%
{identifier}    { ECHO; printf(" is identifier.\n"); } // 字母開頭,後面無限數字字母
.               ;
%%
int main(int argc, char *argv[]) {
    yylex();
    return(0);
}

