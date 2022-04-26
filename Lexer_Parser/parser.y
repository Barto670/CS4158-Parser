%{
/* definitions  */
%}

%union{
    int num;
    char sym;
}

%token<num> NUMBER
%token EOL
%type<num> exp
%token PLUS EQUALS

%%
/* rules  */

input:
|   line input
;

line: 
    exp EOL {printf("%d\n", $1);}
|       EOL
;

exp:
    NUMBER { $$ = $1;} 
|   exp PLUS exp { $$ = $1 + $3; }
;

%%


int main() { 
    yyparse();

    return 0;
}


void yyerror(char* s){
    printf("ERROR: %s\n", s);

    return 0;
}