bison -d -o ex2.tab.c ex2.y
gcc -c -g -I.. ex2.tab.c
flex -o ex2.yy.c ex2.l
gcc -c -g -I.. ex2.yy.c
gcc -o ex2 ex2.tab.o ex2.yy.o -lfl -ly
