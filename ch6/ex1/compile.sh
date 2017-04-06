#compile bison
bison -d -o y.tab.c ex1.y
gcc -c -g -I.. y.tab.c
#compile flex
flex -o lex.yy.c ex1.l
gcc -c -g -I.. lex.yy.c
#compile and link bison and flex
gcc -o ex1 y.tab.o lex.yy.o -ll
