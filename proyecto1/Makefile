all: program
program: 
	#bison -dv operations.y
	flex pylex.l
	g++ -o $@ lex.yy.c -lfl
clean:
	-@rm lex.yy.c  2>/dev/null || true 
	-@rm operations.tab.c  2>/dev/null || true
	-@rm operations.tab.h  2>/dev/null || true
	-@rm program  2>/dev/null || true
	-@rm operations.output  2>/dev/null || true
	-@rm program_result.c 2>/dev/null || true

run:
	./program
