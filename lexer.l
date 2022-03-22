%{
    /* definitions */
    /*#include "parser.tab.h"*/
%}

/* \n {return EOL;}  */
%%

[Bb][Ee][Gg][Ii][Nn][Ii][Nn][Gg] { printf("VALID Body Declaration\n"); }
[Bb][Oo][Dd][Yy] { printf("VALID Body Declaration\n"); }
[Mm][Oo][Vv][Ee] { printf("VALID Move Declaration\n"); }
[Ii][Nn][Pp][Uu][Tt] { printf("VALID Input Declaration\n"); }
[Aa][Dd][Dd] { printf("VALID Add Declaration\n"); }
[Ee][Nn][Dd] { printf("VALID End Declaration\n"); }
[Pp][Rr][Ii][Nn][Tt] { printf("VALID Print Declaration\n"); }
[Tt][Oo] { printf("VALID To Declaration\n"); }
[xX]+ { printf("VALID Variable Declaration that can hold a digit of lenght %d\n", strlen(yytext)); }
[0-9]+ { printf("VALID Number\n"); }
(?:;) { printf("VALID Semi-colon\n"); }
[.] { printf("VALID . (end of line)\n"); }
["] { printf("VALID quotation mark \n"); }
[a-zA-Z0-9-]+ { printf("VALID Variable Name\n"); }
. {}

%%


yywrap() {}


int main(){
    yylex();

    return 0;
}


