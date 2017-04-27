%{
int haha = 0;
%}

%%
"Directions"            { haha = 1; }
([1-9][ ])?[0-9]?\/?[0-9][ ](cups|cup|teaspoons|teaspoon|tablespoons|tablespoon) {
  if(haha == 1) {
    printf("# ");
  }
  printf("%s\n", yytext); 
}
[ \t\n]                 {  }
.                       {  }
%%

int main(int argc, char *argv[]) {
    yylex();
    return(0);
}
