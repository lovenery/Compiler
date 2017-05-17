#include <stdio.h>
#include "scanner.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

char *names[] = { NULL, "db_type", "db_name", "db_table_prefix", "db_port" };

int main(void)
{

    int ntoken, vtoken;

    ntoken = yylex();
    while(ntoken) {
        // detect db_xxx to 1, 2, 3...
        printf("%d\n", ntoken);

        // detect :
        if(yylex() != COLON) {
            printf("Syntax error in line %d, Expected a ':' but found %s\n", yylineno, yytext);
            return 1;
        }

        // detect value
        vtoken = yylex();
        switch (ntoken) {
            case TYPE:
            case NAME:
            case TABLE_PREFIX:
                if(vtoken != IDENTIFIER) {
                    printf("Syntax error in line %d, Expected an identifier but found %s\n", yylineno, yytext);
                    return 1;
                }
                printf("%s is set to %s\n", names[ntoken], yytext);
                break;
            case PORT:
                if(vtoken != INTEGER) {
                    printf("Syntax error in line %d, Expected an integer but found %s\n", yylineno, yytext);
                    return 1;
                }
                printf("%s is set to %s\n", names[ntoken], yytext);
                break;
            default:
                printf("Syntax error in line %d\n", yylineno);
        }
        ntoken = yylex();
    }
    return 0;
}