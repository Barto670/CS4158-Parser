%{
    #include <stdio.h>
    int yylex (void);
    void yyerror(const char *s);
%}

%token INTEGER

%%
/* rules  */

integers: integers INTEGER | INTEGER;             // one or a sequence of integers

%%


int main() { 
    yyparse();

    return 0;
}


void yyerror(char* s){
    printf("ERROR: %s\n", s);

    return 0;
}