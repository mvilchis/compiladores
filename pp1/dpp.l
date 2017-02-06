/*
 * file:  dpp.l
 * ------------
 * Lex inupt file to generate the scanner for the preprocessor.
 * If you decide to use lex for the preprocesor, put your rules
 * here, otherwise the file can remain empty.
 */
%{
#include <stdio.h>
#include <iostream>
#include <map>
#include "errors.h"
using namespace std;

static void DoBeforeEachAction();
#define YY_USER_ACTION DoBeforeEachAction();

%}
SPACES [ \t]+
COMMENT "//"[^\n]*
MULTIPLE_COMMENT \/\*([^*]|[\n]*|(\*+([^*/]|[\n])))*
 map<string, string> defines;
 int first_line = 0;
 int in_comment = 0;

%%

"\#define"{SPACES}[A-Z]+{SPACES}+[^\n]* {
                      string delimiter = " ";
                      string yytext_copy = strdup(yytext);
                      size_t pos = yytext_copy.find(delimiter);
                      string define = yytext_copy.substr(0, pos);
                      yytext_copy.erase(0, pos + delimiter.length());
                      pos = yytext_copy.find(delimiter);
                      string key = yytext_copy.substr(0, pos);
                      yytext_copy.erase(0, pos + delimiter.length());
                      string value = yytext_copy;
                      defines.insert(std::make_pair(key, value));

                    }
"\#define".* {
      ReportError::InvalidDirective(first_line);
            }
"\#"[A-Z]+ {
                      string yytext_copy = strdup(yytext);
                      string key = yytext_copy.substr(1);
                      if (defines.count(key) > 0) {
                        printf("%s", defines.find(key)->second.c_str());
                      }else {
                        ReportError::InvalidDirective(first_line);
                      }
}

{MULTIPLE_COMMENT} {
                    in_comment = 1;
                    string yytext_copy = strdup(yytext);
                    int i;
                    for (i=0;i<yytext_copy.length();i++)
                      if (  yytext_copy[i] == '\n'){
                        printf(" \n");
                      }
                }

\*+\/ {in_comment = 0; }
{COMMENT} {}
<<EOF>>     {if (in_comment) {ReportError::UntermComment();} return 0;}
. {
	printf("%s", yytext);
}
%%
static void DoBeforeEachAction()
{
  if (yytext[0] == '\n'){
    first_line = first_line +1;
  }

}
