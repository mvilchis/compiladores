%{
#include <stdio.h>
#include <iostream>
#include <map>
#include "scanner.h"
typedef std::map<char *, char*> Map;
using namespace std;

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
SPACES [ \t\n]+
NEWLINE [\n]
 //map<char*,char*> defines;
 map<string, string> defines;
%%
"\#define"{SPACES}[A-Z]+{SPACES}+[^\n]* {
					  std::string def       = yytext;
					  std::string delimiter = " ";

                      string s = def;
                      size_t pos = 0;
                      std::string token;
                      
                      pos = s.find(delimiter);
                      string define = s.substr(0, pos);
                      s.erase(0, pos + delimiter.length());
                      
                      pos = s.find(delimiter);
                      string key = s.substr(0, pos);
                      s.erase(0, pos + delimiter.length());
                      
                      pos = s.find(delimiter);
                      string value = s.substr(0, pos);
                      
                      std::cout << value << std::endl;
                      std::cout << key << std::endl;
                      defines.insert(std::make_pair(key, value));
                    }
"\#"[A-Z]+ {
                      string text = strdup(yytext);
					  std::string delimiter = "#";
                      size_t pos = 0;
				      string s = text; 
                      pos = s.find(delimiter);
                      string define = s.substr(0, pos);
                      s.erase(0, pos + delimiter.length());
                      
                      pos = s.find(delimiter);
                      string key = s.substr(0, pos);
                     
					  std::cout<< defines.find(key)->second <<std::endl;
}
%%

int main( int argc, char **argv) {
	yylex();
}
