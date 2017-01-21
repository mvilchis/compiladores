%{
#include <stdio.h>
typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int yylex();
int yyerror(char *s){
    fprintf(stderr, "Error %s", s);
}

%}
%union {
	int ival;
}
/*tokens*/
%token <ival> NUMBER
%token ADD
%token ENTER

%type <ival> goal term exp
%%
goal: exp {printf("= %d ---\n", $1);}
    |exp ENTER {printf("= %d \n", $1);}
;

exp : term
    |exp ADD term {$$ =$1 + $3; }
;

term: NUMBER {printf("-----%d \n", $1);$$ =$1;}
;
%%
int main (int argc, char **argv) {
    /*int i;
    for(i=0; i<argc; ++i)
    {   printf("Argument %d : %s\n", i, argv[i]);
    } */
    YY_BUFFER_STATE buffer = yy_scan_string("3+1 \n");
    yyparse();
    printf( "Salio");
    return 0;

}
