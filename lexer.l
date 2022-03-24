%{
    /* definitions */
    /*#include "parser.tab.h"*/
%}

/* \n {return EOL;}  */
%%

[Bb][Ee][Gg][Ii][Nn][Ii][Nn][Gg] { printf(" [VALID Body Declaration] "); }
[Bb][Oo][Dd][Yy] { printf(" [VALID Body Declaration] "); }
[Mm][Oo][Vv][Ee] { printf(" [VALID Move Declaration] "); }
[Ii][Nn][Pp][Uu][Tt] { printf(" [VALID Input Declaration] "); }
[Aa][Dd][Dd] { printf(" [VALID Add Declaration] "); }
[Ee][Nn][Dd] { printf(" [VALID End Declaration] "); }
[Pp][Rr][Ii][Nn][Tt] { printf(" [VALID Print Declaration] "); }
[Tt][Oo] { printf(" [VALID To Declaration] "); }
[xX]+ { printf(" [VALID Variable Declaration that can hold a digit of lenght %d] ", strlen(yytext)); }
[0-9]+ { printf(" [VALID Number] "); }
(?:;) { printf(" [VALID Semi-colon] "); }
[.] { printf(" [VALID . (end of line)] "); }
["] { printf(" [VALID quotation mark] "); }
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


