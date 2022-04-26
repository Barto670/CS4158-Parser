%{
/* definitions  */
%}

%union{
    int num;
    char sym;
}

%token<num> NUMBER DECLARATION
%token PLUS EQUALS  
%token EOL DOT SEMICOLON
%token BODY BEGINING END
%token INPUT MOVE AND TO PRINT  STRING
%token<sym> VARNAME

%type<num> numexp 

%%
/* rules  */

input:
|   line input
;

line: 
    numexp DOT EOL  {printf("%d\n", $1);}
|   DECLARATION VARNAME DOT EOL {printf("Lenght of variable %d = %d\n", $2, $1);}
|   VARNAME DOT EOL {printf("variable %d\n", $1);}
|   EOL
;


numexp:
    NUMBER { $$ = $1;} 
|   numexp PLUS numexp { $$ = $1 + $3; }
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