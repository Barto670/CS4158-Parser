
%option caseless
%option noyywrap

%{
    
    /* definitions */
    #include "parser.tab.h"
    #include <stdio.h>
    #include <string.h>

    
    
%}


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
[0-9]+ { yylval.num = atoi(yytext); return NUMBER; printf("%d", atoi(yytext));}
(?:;) { return SEMICOLON; }
[.] { return DOT; }
["][^\n"]*["] { yylval.str = strdup(yytext); return STRING; }
[a-zA-Z0-9-]+ { yylval.str = strdup(yytext); return VARNAME;}
[ ] { return WHITESPACE;} /* Whitespace */
[\n]  { return EOL; }
. {printf("INVALID");}

%%


