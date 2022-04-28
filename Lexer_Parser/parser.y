%{
    /* definitions  */
    #include <stdio.h>
    #include <stdbool.h>
    #include <stdlib.h>


    int search(char name[]);
    void insertVar(char name[], int size, int value);
    int intLen(int x);
    void yyerror(char* s);
    char* removeChar(char *str, char garbage);
    

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
%type<str> var

%%
/* rules  */

input:
     begining variables body bodydef end
;

begining:
    BEGINING DOT EOL {}
;

variables: | vardefs variables
;


vardefs :   
    DECLARATION WHITESPACE VARNAME DOT EOL {



        int flag;
		char *t;
	    flag = search($3);

		if(flag == -1){
			insertVar($3, $1, 0);
		}else{
			t = "      ERROR: Identifier already defined ";
            yyerror(t);
		}
    }
|   DECLARATION WHITESPACE DECLARATION DOT EOL { yyerror("    Variable name cannot be only 'x' or 'X'");}
|   EOL
;

body:
    BODY DOT EOL {}
;

end:
    END DOT EOL {printf("Program compiled successfully\n");}
;

bodydef:  | bodycontent bodydef
;

bodycontent: 
|   PRINT WHITESPACE printcontent DOT EOL { printf("\n");}
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
            yyerror(t);
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

        int varValue = (int)tab[flag].value;

		if(flag == -1){
			t = "ERROR : No variable found with that name ";
            yyerror(t);
		}

        printf("%d",varValue);
    }
|   STRING {

    char *p = $1;
    p++[strlen(p)] = 0;

    printf(p); 
}
;

printcontent:
    strfiller { $$ = $1;} 
|   printcontent SEMICOLON printcontent { $$ = $1;}


var: VARNAME { 

        int flag;
		char *t;
	    flag = search($1);

		if(flag == -1){
			t = "ERROR : No variable found with that name ";
            yyerror(t);
		}else{
            int testInteger;
            scanf("%d", &testInteger);  

            tab[flag].value = testInteger;

        }

    } 


inputcontent:
    var { $$ = $1;}
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


char* removeChar(char *str, char garbage) {

    char *src, *dst;
    for (src = dst = str; *src != '\0'; src++) {
        *dst = *src;
        if (*dst != garbage) dst++;
    }
    *dst = '\0';

    return *dst;
}


void insertVar(char name[], int size, int value){

	strcpy(tab[ptr].name, name);

    tab[ptr].value = value;
    tab[ptr].size = size;
	

	ptr++;

}



void yyerror(char* s){
    printf("ERROR: %s\n", s);

    exit(0);
}
