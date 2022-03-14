%{
    /* definitions */
%}

%union{
    int num;
    char sym;
}

%token EOL
%token<num> NUMBER
%token PLUS MINUS MULTIPLY

%%
/* rules  */

input {};

%%


int main() { 
    yyparse();

    return 0;
}


yyerror(char* s){
    printf("ERROR: %s\n", s);

    return 0;
}