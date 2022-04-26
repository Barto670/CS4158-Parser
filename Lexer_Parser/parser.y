%{
    /* definitions  */
    #include <stdio.h>


    char value[10] = {};
    int size[10] = {};
    char *name[10] = {};
    int i = 0;

%}

%union{
    int num;
    char sym;
    char *str;
}

%token<num> NUMBER DECLARATION 
%token EOL DOT SEMICOLON
%token BODY BEGINING END
%token INPUT MOVE ADD TO PRINT 
%token<str> VARNAME STRING

%type<num> numexp 
%type<str> printcontent
%type<str> strfiller

%%
/* rules  */

input:
|   line input
;

line: 
    numexp DOT EOL  {printf("%d\n", $1);}
|   BEGINING DOT EOL {printf("Begining");}
|   BODY DOT EOL {printf("BODY");}
|   END DOT EOL {printf("END");}
|   PRINT printcontent DOT EOL {printf("String = %d\n", $2);}
|   ADD VARNAME TO VARNAME DOT EOL {printf("String = %d\n", $2);}
|   MOVE NUMBER TO VARNAME DOT EOL {printf("String = %d\n", $2);}
|   INPUT VARNAME DOT EOL {printf("String = %d\n", $2);}
|   DECLARATION VARNAME DOT EOL {printf("String of name: ");printf($2);printf("has lenght: %d", $1); }
|   EOL
;

strfiller:
    VARNAME
|   STRING
;

printcontent:
    strfiller { $$ = $1;} 
|   printcontent SEMICOLON printcontent { $$ = $1;}

numexp:
    NUMBER { $$ = $1;} 
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