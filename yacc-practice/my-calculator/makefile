all:
	bison -d -o y.tab.c y.y
	flex -o lex.yy.c lex.l
	gcc lex.yy.c y.tab.c

test: all
	./a.out < input.txt
	make clean

clean:
	rm lex.yy.c y.tab.c y.tab.h a.out