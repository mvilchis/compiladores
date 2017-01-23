%{
#include <stdio.h>
# include "operations.tab.h"
%}

%%
"+" {return ADD;}
[0-9]+ {yylval= atoi(yytext);return NUMBER;}
[ \t] {}
\n {return ENTER;}
. exit(1); 
%%
