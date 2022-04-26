
%option caseless
%{
    
    /* definitions */
    #include "parser.tab.h"
    #include <stdio.h>
    #include <string.h>
    
    
%}

/* \n {return EOL;}  */
%%

"begining" { return BEGINING; }
"body" { return BODY; }
"end" { return END; }
"move" { return MOVE; }
"input" { return INPUT; }
"add" { return ADD; }
"print" { return PRINT; }
"to" { return TO; }
[xX]+ { yylval.num = strlen(yytext); return DECLARATION; }
[0]+[1-9]+ { yylval.num = atoi(yytext); return NUMBER; }
[1-9]+ { yylval.num = atoi(yytext); return NUMBER; }
(?:;) { return SEMICOLON; }
[.] { return DOT; }
["][a-zA-Z0-9]+["] { yylval.str = strdup(yytext); return STRING; }
[a-zA-Z0-9-]+ { yylval.str = strdup(yytext); return VARNAME;}
[ ] /* Whitespace */
[\n]  { return EOL; }
. {printf("INVALID");}

%%


yywrap() {}


// int main(){
//     yylex();

//     return 0;
// }


