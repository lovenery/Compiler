%{
// http://stackoverflow.com/questions/22430980/removing-spaces-from-a-string
void deleteSpaces(char src[], char dst[]){
   // src is supposed to be zero ended
   // dst is supposed to be large enough to hold src
  int s, d=0;
  for (s = 0; src[s] != 0; s++) {
    if (src[s] != ' ') {
       dst[d] = src[s];
       d++;
    }
  }
  dst[d] = 0;
}
%}

z    [a-fA-F0-9]
%%

^[ ]*0[xX]{z}{z}?{z}?{z}?{z}?{z}?$ { char* a = yytext; deleteSpaces(a, a); printf("%s\n",a); } /*another way*//* while(*yytext == ' ') { yytext++; } printf("%s\n", yytext); */ 
[ \t\n]                 {}
.                       {}
%%


int main(int argc, char *argv[]) {
    
    yylex();

    return(0);
}