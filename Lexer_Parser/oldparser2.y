%{
    /* definitions  */
    #include <stdio.h>
    #include <stdbool.h>
    #include <stdlib.h>


    void insertVal(char value[], int posi);
    int search(char name[]);
    void insert(char name[], char size[], char value[]);
    void printTab();

    int ptr = 0;

    

    struct symtab{
        char name[100];
        char size[100]; // 1 is int, 2 is float
        char value[100];
    };

    struct symtab tab[100];
    

%}

%union{
    int num;
    char sym;
    char *str;
}

%token<num> NUMBER DECLARATION 
%token EOL DOT SEMICOLON WHITESPACE
%token BODY BEGINING END
%token INPUT MOVE ADD TO PRINT 
%token<str> VARNAME STRING

%type<num> numexp 
%type<str> printcontent
%type<str> strfiller
%type<str> variables
%type<str> vardefs
%type<str> begining

%%
/* rules  */

input:
     begining variables body bodydef end
;

begining:
    BEGINING DOT EOL {printf("Begining\n");}
;

variables: | vardefs variables
;


vardefs :   
    DECLARATION WHITESPACE VARNAME DOT EOL {
        printf("String of name: ");
        printf($3);
        printf("has lenght: %d\n", $1);



        int flag;
		char *t;
	    flag = search($3);

		if(flag == -1){
			insert($3, "40" , "0");
		}else{
			t = "Identifier already defined - ";
            printf(t);
		}
    }
|   DECLARATION WHITESPACE DECLARATION DOT EOL { yyerror("    Variable name cannot be only 'x' or 'X'");}
|   EOL
;

body:
    BODY DOT EOL {printf("BODY\n");}
;

end:
    END DOT EOL {printf("Program compiled successfully\n");}
;

bodydef:  | bodycontent bodydef
;

bodycontent: 
|   numexp DOT EOL  {printf("%d\n", $1);}
|   PRINT WHITESPACE printcontent DOT EOL {printf("String = %d\n", $3);}
|   ADD WHITESPACE VARNAME WHITESPACE TO WHITESPACE VARNAME DOT EOL {printf("String = %d\n", $3);}
|   MOVE WHITESPACE NUMBER WHITESPACE TO WHITESPACE VARNAME DOT EOL {printf("String = %d\n", $3);}
|   INPUT WHITESPACE VARNAME DOT EOL {printf("String = %d\n", $3);}
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



int search(char name[]){

	int i;
	int flag = -1;

	for(i = 0; i < ptr; i++){
		if(strcmp(tab[i].name, name) == 0){
			flag = i;
			break;
		}
	}

	return flag;

}

void insert(char name[], char size[], char value[]){

	strcpy(tab[ptr].name, name);
    strcpy(tab[ptr].size, size);
	strcpy(tab[ptr].value, value);
	

	ptr++;

    printTab();

}

void insertVal(char value[], int posi){

	strcpy(tab[posi].value, value);

    printTab();
}


void printTab(){

	int i;

	for(i = 0; i < ptr; i++){

	    printf("Name - %s, value - %d, size - %d sadsada \n", tab[i].name, tab[i].value, tab[i].size);
	}
}



void yyerror(char* s){
    printf("ERROR: %s\n", s);

    return 0;
}
