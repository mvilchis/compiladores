%{
#include <stdio.h>
#include <string.h>
typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int yylex();
int yyerror(char *s){
    fprintf(stderr, "Error %s", s);
}

%}
/*tokens*/
%token  NUMBER
%token ADD
%token ENTER

%%
goal: exp {return $1;}
    |exp ENTER {return $1;}
;

exp :  NUMBER| exp ADD NUMBER {$$ =$1 + $3; }

;

%%
int main (int argc, char **argv) {
    int i;
    char *OUT_FLAG = "-i";
    char *C_FLAG = "-e";
    char *c_program = "#include <stdio.h> \n int main(){\n printf(\"%s = %d \\n \");\n}";

    if (argc > 4 & argc <=1 ) {
        printf("El programa requiere al menos un parametro \n");
        printf("%s <Cadena a evaluar>", argv[0]);
    }
    if (argc == 2) { //Then eval and print expression
        YY_BUFFER_STATE buffer = yy_scan_string(argv[1]);
        int parse_result=  yyparse(); 
        printf("%s = %d\n",argv[argc-1],parse_result);

    }
    
    YY_BUFFER_STATE buffer = yy_scan_string(argv[argc-1]); 
    int parse_result=  yyparse();

    for(i = 1; i<argc-1; ++i ) {
        char *flag = argv[i];
        if (strcmp(flag,OUT_FLAG) == 0) {
            printf("%s = %d\n",argv[argc-1],parse_result);
            continue;
        }
        if(strcmp(flag, C_FLAG) == 0) {
            FILE *f = fopen("program_result.c", "w");
            if (f == NULL) {
                printf("Error opening file!\n");
                return 1;
            }

            fprintf(f, c_program, argv[argc-1], parse_result);
            fclose(f); 
        } else {
            printf("%s parametro no valido \n", flag);
            return 1;
        
        }
           
    } 
    return 0;

}
