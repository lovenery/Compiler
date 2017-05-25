%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(char *msg) {
    printf("syntax error");
}

struct Node {
    char data;
    struct Node *left, *right;
    int num;
} *root;
struct Node *newNode(int num) {
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
        case '&':
            np = newNode(npLeft->num & npRight->num);
            break;
        case '|':
            np = newNode(npLeft->num | npRight->num);
            break;
        case '^':
            np = newNode(npLeft->num ^ npRight->num);
            break;
        case '<':
            np = newNode(npLeft->num << npRight->num);
            break;
        case '>':
            np = newNode(npLeft->num >> npRight->num);
            break;
    }
    np->data = data;
    np->left = npLeft;
    np->right = npRight;
    return np;
}
struct Node *operateNOT(struct Node *np) {
    struct Node *new_node;
    new_node = newNode(np->num ^ 31);
    new_node->left = np;
    return new_node;
}

void traverseAST(struct Node *np) {
    if (np == NULL) {
        return;
    }
    switch(np->data) {
        case 'f':
            traverseAST(np->left);
            traverseAST(np->right);
            printf("Integer Number: %d\n", np->num);
            break;
        default:
            traverseAST(np->left);
            traverseAST(np->right);
            printf("Sign: %c (%d)\n", np->data, np->num);
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
    // printf("Final Answer is: %d\n", np->num);
    printf("%d", np->num);
    freeAST(np);
}
%}


%union {
    int f;
    struct Node *np;
}
%token SPACES
%token <f> NUM
%type <np> E


%%
S   :   E           {
        // printf("------\n");
        // traverseAST($1);
        // printf("------\n");
        root = $1;
    }
    ;
E   :   '&' SPACES E SPACES E       { $$ = calculate($3, $5, '&'); }
    |   '|' SPACES E SPACES E       { $$ = calculate($3, $5, '|'); }
    |   '^' SPACES E SPACES E       { $$ = calculate($3, $5, '^'); }
    |   '<' '<' SPACES E SPACES E   { $$ = calculate($4, $6, '<'); }
    |   '>' '>' SPACES E SPACES E   { $$ = calculate($4, $6, '>'); }
    |   '~' SPACES E                { $$ = operateNOT($3); }
    |   NUM                         { $$ = newNode($1); }
    ;


%%
int main() {
    int a = yyparse();
    if(a == 0) {
        printAnswer(root);
    } else {
        /* yyerror() */
    }
}
