%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(char *msg) {
    printf("語法錯誤！\n");
}
struct Node {
    char data; // +-*/
    struct Node *left, *right;
    float num;
};
struct Node *newNode(float num) {
    struct Node *np = (struct Node *) malloc( sizeof(struct Node) );
    np->num = num;
    np->data = 'f';
    np->left = NULL;
    np->right = NULL;
    return np;
}
struct Node *calculate(struct Node *npLeft, struct Node *npRight, char data) {
    struct Node *np;
    switch(data) {
        case '+':
            np = newNode(npLeft->num + npRight->num);
            break;
        case '-':
            np = newNode(npLeft->num - npRight->num);
            break;
        case '*':
            np = newNode(npLeft->num * npRight->num);
            break;
        case '/':
            np = newNode(npLeft->num / npRight->num);
            break;
    }
    np->data = data;
    np->left = npLeft;
    np->right = npRight;
    return np;
}
struct Node *negetive(struct Node *np) {
    np->num = -np->num;
    return np;
}
void traverseAST(struct Node *np) {
    if (np == NULL) {
        return;
    }
    switch(np->data) {
        case 'f':
            traverseAST(np->left);
            traverseAST(np->right);
            printf("Float Number: %f\n", np->num);
            break;
        case '+':
        case '-':
        case '*':
        case '/':
            traverseAST(np->left);
            traverseAST(np->right);
            printf("Sign: %c (%f)\n", np->data, np->num);
            break;
    }
}
void freeAST(struct Node* np) { // free with postorder
    if (np != NULL) {
        freeAST(np->left);
        freeAST(np->right);
        free(np);
    }
}
void printAnswer(struct Node *np) {
    printf("Final Answer is: %f\n", np->num);
    freeAST(np);
}
%}


%union {
    float f;
    struct Node *np;
}
%token <f> NUM /* Token */
%type <np> E T F /* non-Terminal */


%%
S   :   E           {
        printf("------\n");
        traverseAST($1);
        printf("\n");
        printAnswer($1);
        printf("------\n");
    }
    ;

E   :   E '+' T     { $$ = calculate($1, $3, '+'); }
    |   E '-' T     { $$ = calculate($1, $3, '-'); }
    |   T           { $$ = $1; }
    ;

T   :   T '*' F     { $$ = calculate($1, $3, '*'); }
    |   T '/' F     { $$ = calculate($1, $3, '/'); }
    |   F           { $$ = $1; }
    ;

F   :   '(' E ')'   { $$ = $2; }
    |   '-' F       { $$ = negetive($2); }
    |   NUM         { $$ = newNode($1); }
    ;


%%
int main() {
    yyparse();
}

// 6/2*(1+2)
// 6,2,/,1,2,-,*