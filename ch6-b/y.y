%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
void yyerror(const char* msg) {
    printf("Invalid format\n");
}
struct node {
    struct node* next;
    char element[3];
    int num;
};
struct node *createNode(const char* name, int num) {
    struct node *np = (struct node *) malloc( sizeof(struct node) );
    strcpy(np->element, name);
    np->num = num;
    np->next = NULL;
    return np;
}
void multiply(struct node *np, int times) {
    while (np != NULL) {
        np->num *= times;
        np = np->next;
    }
}
struct node *check(struct node *np, char* name) {
    while (np != NULL) {
        if(strcmp(np->element, name) == 0) {
            return np;
        }
        np = np->next;
    }
    return NULL;
}
struct node *concatenate(struct node *left, struct node *right) {
    struct node *result = NULL, *current, *location;
    int i;
    for(i = 0 ; i < 2 ; i++) {
        if (i == 1) {
            current = left;
        } else {
            current = right;
        }
        while (current != NULL) {
            if ((location = check(result, current->element)) == NULL) {
                struct node *nn = (struct node *) malloc( sizeof(struct node) );
                memcpy(nn, current, sizeof(struct node));
                nn->next = result;
                result = nn;
            }
            else{
                location->num += current->num;
            }
            current = current->next;
        }
    }
    return result;
}
void printAnswer(struct node *leftnp, struct node *rightnp) {
    // negative right nodes
    struct node *tmp1 = rightnp;
    while (tmp1 != NULL) {
        tmp1->num = -tmp1->num;
        tmp1 = tmp1->next;
    }

    // concatenate left and right
    struct node *result = concatenate(leftnp, rightnp);

    // finally, sorting the result
    struct node *tmp2 = NULL;
    while(result != NULL) {
        struct node **resultp = &result; 
        struct node *mini = result;
        struct node *current;
        for(current = result ; current->next ; current = current->next)
            if(strcmp(mini->element, current->next->element) < 0){
                mini = current->next;
                resultp = &current->next;
            }
        *resultp = mini->next;
        mini->next = tmp2;
        tmp2 = mini;
    }
    result = tmp2;

    // print answer
    struct node *np;
    for(np = result; np; np = np->next) {
        if(np->num != 0) {
            printf("%s %d\n", np->element, np->num);
        }
    }
}
%}


%union {
    int ival;
    char *name;
    struct node *np;
}
%token<ival> NUMBER
%token<name> ELEMENT
%type<np> EXPR TERM FACTOR SINGLE


%%
LINE    : EXPR '-' '>' EXPR {
            printAnswer($1, $4);
        }
        ;
EXPR    : EXPR '+' TERM {
            $$ = concatenate($1, $3);
        }
        | TERM {
            $$ = $1;
        }
        ;
TERM    : NUMBER TERM {
            multiply($2, $1);
            $$ = $2;
        }
        | FACTOR {
            $$ = $1;
        }
        ;
FACTOR  : FACTOR SINGLE {
            $$ = concatenate($1, $2);
        }
        | SINGLE {
            $$ = $1;
        }
        ;
SINGLE  : '(' FACTOR ')' NUMBER {
            multiply($2, $4);
            $$ = $2;
        }
        | '(' FACTOR ')' {
            $$ = $2;
        }
        | ELEMENT NUMBER {
            $$ = createNode($1, $2);
        }
        | ELEMENT {
            $$ = createNode($1, 1);
        }
        ;


%%
int main()
{
    yyparse();
    return 0;
}
