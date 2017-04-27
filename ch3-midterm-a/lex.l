%{
#include <string.h> // 不加也對
int indent = -2; // 當前要印幾個縮排
char tmp[3000] = "haha"; // 暫存器
char ans[5000] = ""; // 答案字串
int total = 0; // 總答案長度
int validate = 1; // 是否符合要求
%}


tagId     [a-zA-Z_]+
lefttag   <
righttab  >
%%
{lefttag}{tagId}{righttab} {
  // 如果跟前一個不match 就加縮排
  if (strcmp(tmp, yytext) != 0) {
    indent += 2;
  }

  // 複製到當前處理
  strcpy(tmp, yytext);

  // 印出縮排
  int i = 0;
  while(i++ < indent) {
    strcat(ans, " ");
    total += 1;
  }

  // 答案接上去
  strcat(ans, tmp);
  total += strlen(tmp);

  // 答案接換行上去
  strcat(ans, "\n");
  total += 1;

  // debug
  // printf("%s\n", tmp);
  // printf("%d\n", indent);
}
[ \t\n]                 { }
.                       { validate = 0; /* 不能有怪怪的字 */ }
%%


int main(int argc, char *argv[]) {
    
    yylex();

    if (validate == 1) {
      int i;
      for(int i = 0; i < total - 1 ; i++) { // 最後換行的char不印
        printf("%c", ans[i]);
      }
    } else {
      printf("please don\'t eat me");
    }

    // 直接印 最後會有換行就錯了
    // printf("%s", ans);
    
    return(0);
}
/*
備註：
最後面不能有換行
*/