%{
    /* definitions  */
    #include <stdio.h>
    #include <stdbool.h>
    #include <stdlib.h>


    void insertVal(int value, int posi);
    int search(char name[]);
    void insert(char name[], int size, int value);
    void printTab();
    int intLen(int x);
    void yyerror(char* s);
    

    int ptr = 0;

    

    struct symtab{
        char name[100];
        int size;
        int value;
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

%type<str> printcontent
%type<str> inputcontent
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
			insertNameSize($3, $1);
		}else{
			t = "      ERROR: Identifier already defined ";
            yyerror(t);
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
|   PRINT WHITESPACE printcontent DOT EOL {}
|   ADD WHITESPACE VARNAME WHITESPACE TO WHITESPACE VARNAME DOT EOL {


        int flag;
        int flag2;
        char *t;
        flag = search($3);
        flag2 = search($7);

        if(flag == -1 || flag2 == -1){
            t = "ERROR : No variable found with that name ";
            yyerror(t);
        }else{

            int numberToAdd = (int)tab[flag].value;
            int variableLenght = (int)tab[flag2].size;

            int valueOfVariable = (int)tab[flag2].value;

            int temp = (int)valueOfVariable + (int)numberToAdd;

            int lenght = 0;

            lenght = intLen(temp);

            if(lenght > variableLenght){
                t = "ERROR : Variable doesn't have enough space assigned";
                yyerror(t);
            }else{
                tab[flag].value = temp;
                printTab();
            }

            
        }

    }
|   ADD WHITESPACE NUMBER WHITESPACE TO WHITESPACE VARNAME DOT EOL {


        int flag;
        char *t;
        flag = search($7);

        if(flag == -1){
            t = "ERROR : No variable found with that name ";
            yyerror(t);
        }else{

            int numberToAdd = $3;
            int variableLenght = (int)tab[flag].size;

            int valueOfVariable = (int)tab[flag].value;

            int temp = (int)valueOfVariable + (int)numberToAdd;

            int lenght = 0;

            lenght = intLen(temp);

            if(lenght > variableLenght){
                t = "ERROR : Variable doesn't have enough space assigned";
                yyerror(t);
            }else{
                tab[flag].value = temp;
                printTab();
            }

            
        }

    }
|   MOVE WHITESPACE NUMBER WHITESPACE TO WHITESPACE VARNAME DOT EOL {


        int flag;
        char *t;
        flag = search($7);

        if(flag == -1){
            t = "ERROR : No variable found with that name ";
            yyerror(t);
        }else{

            int numberToReplace = $3;
            int variableLenght = (int)tab[flag].size;

            int valueOfVariable = (int)tab[flag].value;

            int temp = (int)numberToReplace;

            int lenght = 0;

            lenght = intLen(temp);

            if(lenght > variableLenght){
                t = "ERROR : Variable doesn't have enough space assigned";
                yyerror(t);
            }else{
                tab[flag].value = temp;
                printTab();
            }

            
        }

    }
|   MOVE WHITESPACE VARNAME WHITESPACE TO WHITESPACE VARNAME DOT EOL {


        int flag;
        int flag2;
        char *t;
        flag = search($3);
        flag2 = search($7);

        if(flag == -1 || flag2 == -1){
            t = "ERROR : No variable found with that name ";
            printf(t);
        }else{

            int numberToReplace = (int)tab[flag].value;
            int variableLenght = (int)tab[flag2].size;

            int valueOfVariable = (int)tab[flag2].value;

            int temp = (int)numberToReplace;

            int lenght = 0;

            lenght = intLen(temp);

            if(lenght > variableLenght){
                t = "ERROR : Variable doesn't have enough space assigned";
                yyerror(t);
            }else{
                tab[flag2].value = temp;
                printTab();
            }

            
        }

    }
|   INPUT WHITESPACE inputcontent DOT EOL {}
|   EOL
;

strfiller:
    VARNAME { 

        int flag;
		char *t;
	    flag = search($1);

		if(flag == -1){
			t = "ERROR : No variable found with that name ";
            yyerror(t);
		}

        if(tab[flag].value <= 0 || tab[flag].value > 0 ){
            t = "ERROR : Variable doesn't have a value";
            yyerror(t);
        }
    }
|   STRING
;

printcontent:
    strfiller { $$ = $1;} 
|   printcontent SEMICOLON printcontent { $$ = $1;}


inputcontent:
    VARNAME { 

        int flag;
		char *t;
	    flag = search($1);

		if(flag == -1){
			t = "ERROR : No variable found with that name ";
            yyerror(t);
		}else{
            int testInteger;
            printf("Enter an integer: ");
            scanf("%d", &testInteger);  
            printf("Number = %d",testInteger);
        }

        

        
    } 
|   inputcontent SEMICOLON WHITESPACE inputcontent { $$ = $1;}



%%


int main() { 
    yyparse();

    return 0;
}

int intLen(int x)
{
  if(!x) return 1;
  int i;
  for(i=0; x!=0; ++i)
  {
    x /= 10;
  }
  return i;
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

void insertNameSize(char name[], int size){

	strcpy(tab[ptr].name, name);
    tab[ptr].size = size;
	

	ptr++;

    printTab();

}

void insert(char name[], int size, int value){

	strcpy(tab[ptr].name, name);

    tab[ptr].value = value;
    tab[ptr].size = size;
	

	ptr++;

    printTab();

}

void insertVal(int value, int posi){

	tab[ptr].value = value;

    printTab();
}


void printTab(){

	int i;

	for(i = 0; i < ptr; i++){

	    printf("Name - %s, value - %d, size - %d  \n", tab[i].name, tab[i].value, tab[i].size);
	}
}



void yyerror(char* s){
    printf("ERROR: %s\n", s);

    exit(0);
}
