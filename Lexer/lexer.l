
%option caseless
%{
    
    /* definitions */
    /*#include "parser.tab.h"*/

    
%}

/* \n {return EOL;}  */
%%

"begining" { printf(" [VALID Begining Declaration] "); }
"body" { printf(" [VALID Body Declaration] "); }
"move" { printf(" [VALID Move Declaration] "); }
"input" { printf(" [VALID Input Declaration] "); }
"and" { printf(" [VALID Add Declaration] "); }
"end" { printf(" [VALID End Declaration] "); }
"print" { printf(" [VALID Print Declaration] "); }
"to" { printf(" [VALID To Declaration] "); }
[xX]+ { printf(" [VALID Variable Declaration that can hold a digit of lenght %d] ", strlen(yytext)); }
[0]+[1-9]+ { printf(" [VALID Number = %d ] ", atoi(yytext)); }
(?:;) { printf(" [VALID Semi-colon] "); }
[.] { printf(" [VALID . (end of line)] "); }
["][a-zA-Z0-9]+["] { printf(" [VALID String] "); }
[a-zA-Z0-9-]+ { printf(" [VALID Variable Name] "); }
[ ] /* Whitespace */
[\n]  { printf(" [VALID New line]\n"); }
. {printf("INVALID");}

%%


yywrap() {}


int main(){
    yylex();

    return 0;
}


