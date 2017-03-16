/* wordcount.l */
%{
unsigned int charCount=0, wordCount=0, lineCount=0;
%}
/* 不是空白不是tab不是換行 */
word    [^ \t\n]+
/* 如果遇到換行 就定義他是eol的token */
eol     \n
%%
{word}  { wordCount++; charCount += yyleng; } /* 讀到屬於此token 做括號內的事, 從第一行開始不成功才會執行下一行 */
{eol}   { charCount++; lineCount++; }
.   charCount++;
%%
int main(int argc, char *argv[]) {
    yylex(); // 用上面的rule 產生token
    printf("%u %u %u\n", lineCount, wordCount, charCount);
    return(0);
}
