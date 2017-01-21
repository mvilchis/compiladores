all: program
program: 
	bison -dv operations.y
	flex operations.l
	cc -o $@ operations.tab.c lex.yy.c -lfl
clean:
	rm lex.yy.c
	rm operations.tab.c
	rm operations.tab.h
	rm program
	rm operations.output
run:
	./program
