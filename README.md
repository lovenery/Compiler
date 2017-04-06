# Compiler
- Book: Crafting a Compiler
- Test on `OS X El Capitan`

# Lex
`$ flex lex.l`  
`$ gcc lex.yy.c -ll`  
`$ ./a.out < input.txt`  

# Lex + Yacc
`$ flex lex.l`  
`$ bison -d -o y.tab.c yacc.y`  
`$ gcc lex.yy.c y.tab.c -ll`  
`$ ./a.out < input.txt`  