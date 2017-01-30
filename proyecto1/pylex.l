%{
#include <stdio.h>
%}
DIGIT [1-9][0-9]* 
INTEGER [0]|{DIGIT}
REAL {INTEGER}["."][0-9]* 
DOUBLE {INTEGER}["."][0-9]*[E,e][+-]?{INTEGER}
HEX_INTEGER 0[x,X]{INTEGER}
HEX_REAL 0[X,x]{REAL}
COMMENT "//"[^\n]
MULTIPLE_COMMENT [^*]+([^*]+)*|.*
IDENTIFIER [a-zA-ZñÑ_][a-zA-ZñÑ_0-9]*
STRING \"[^\n"]*\"
%%
"void" {}
"int" {}
"double" {}
"bool" {}
"string" {} 
"class" {}
"interface" {}
"null" {}
"this"  {}
"extends" {}
"implements" {}
"for" {}
"while" {}
"if" {}
"else" {}
"return" {}
"break" {}
"New" {}
"NewArray" {}
"true" {}
"false" {}
{IDENTIFIER} {char subbuff[32];memcpy( subbuff, &yytext[0], 31); subbuff[32] = '\0'; printf("Identificador%s",subbuff);}
\/\*{MULTIPLE_COMMENT}\*\/  {printf ("Comentario multiple: %s", yytext);}
{STRING} {printf("Cadena%s", yytext);}
{HEX_REAL} {printf("Hexadecimal %s", yytext);}
{HEX_INTEGER} {printf("Hexadecimal %s", yytext);} 
{INTEGER} {printf("Entero %s", yytext);}
{REAL} {printf("Real %s", yytext);}
{DOUBLE} {printf("Doble %s", yytext);}
"+" {}
"-" {}
"*" {}
"/" {}
"%" {}
"<" {}
"<=" {}
">" {}
">=" {}
"=" {}
"==" {}
"!=" {}
"&&" {}
"||" {}
"!" {}
";" {}
"," {}
"." {}
"[" {}
"]" {}
"(" {}
")" {}
"{" {}
"}" {}

. {printf( "Error en la cadena %s \n", yytext);}
%%

int main( int argc, char **argv) {
	yylex();
}
