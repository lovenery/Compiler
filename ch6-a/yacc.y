%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(const char* msg) {
    printf("語法錯誤 Syntax Error!\n");
};
struct node {
    char data;
    struct node *left, *right;
    int location, row, col;
} *rootNode;
struct node *createNode(char, struct node *, struct node *, int, int, int);
void checkTree(struct node *);
int validate = 1;
%}


%union {
    int ival;
    int location;
    struct node *np;
}
%token<ival> NUM
%token<location> '-' '+' '*'
%type<np> EXPR TERM FACTOR MATRIX


%%
line    : EXPR {
            rootNode = $1;
        }
        ;

EXPR    : EXPR '+' TERM {
            $$ = createNode('+', $1,  $3, $2, 0, 0);
            // printf("Location of '+' = %d\n", $2);
        }
        | EXPR '-' TERM {
            $$ = createNode('-', $1, $3, $2, 0, 0);
            // printf("Location of '-' = %d\n", $2);
        }
        | TERM {
            $$ = $1;
        }
        ;

TERM    : TERM '*' FACTOR {
            $$ = createNode('*', $1, $3, $2,0,0);
            // printf("Location of '*' = %d\n", $2);
        }
        | FACTOR {
            $$ = $1;
        }
        ;

FACTOR  : FACTOR '^' 'T' {
            $$ = createNode('T', $1,0,0,0,0);
        }
        | '(' EXPR ')' {
            $$ = $2;
        }
        | MATRIX {
            $$ = $1;
        }
        ;
MATRIX  : '[' NUM ',' NUM ']' {
            // printf("MATRIX %d %d\n", $2, $4);
            $$ = createNode('M',NULL, NULL, 0, $2, $4);
        }
        ;


%%
int main()
{
    yyparse();
    checkTree(rootNode);
    free(rootNode);
    if(validate) {
        printf("Accepted\n");
    }
    return 0;
}

struct node *createNode(char data, struct node *left, struct node *right, int location, int row, int col) {
    struct node *np = (struct node*) malloc( sizeof(struct node) );
    np->data = data;
    np->left = left;
    np->right = right;
    np->location = location;
    np->row = row;
    np->col = col;
    return np;
}

void checkTree(struct node *np) {
    switch(np->data){
        // 轉置
        case 'T':
            checkTree(np->left); // 往左找MATRIX
            // 變成新矩陣
            np->row = np->left->col;
            np->col = np->left->row;
            break;
        // 不做事
        case 'M':
            // printf("(%d, %d)", np->row, np->row);
            break;
        // 檢查乘法對不對
        case '*':
            checkTree(np->left); checkTree(np->right); 
            if(np->left->col != np->right->row && validate) {
                printf("Semantic error on col %d\n", np->location);
                validate = 0;
                return;
            }
            // 變成新矩陣
            np->row = np->left->row;
            np->col = np->right->col;
            break;
        // 檢查加減法對不對
        case '-':
        case '+':
            checkTree(np->left); checkTree(np->right); 
            if((np->left->row != np->right->row || np->left->col != np->right->col) && validate) {
                printf("Semantic error on col %d\n", np->location);
                validate = 0;
                return;
            }
            // 變成新矩陣
            np->row = np->left->row;
            np->col = np->left->col;
            break;
    }
    return;
}