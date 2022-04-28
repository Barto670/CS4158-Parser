**Program accepts only 'BEGINING' instead of 'BEGINNING'**

Before any of the below I installed flex and bison and a c compiler

1) Open any kind of terminal (I used Windows 10 Command Prompt)
2) Navigate to the project directory
3) run 'flex lexer.l' to create a .c file called 'lex.yy.c' 
4) run 'bison -d parser.y;' to create the bison file
5) run 'gcc -Wno-write-strings -o a lex.yy.c parser.tab.c;' to create an executable called 'a.exe'
6) run the executable 'a.exe' using './a' or 'a'
7) the program is now running and it can be tested

8) one way I tested the program was to input a single line of code, valid code I tested is below;

Example 1(compiles succesfully)

begining.
xxx sss.
xxx ssss.
body.
input sss; ssss.
3
5
move 15 to sss.
move 20 to ssss.
add 15 to sss.
add 20 to ssss.
move sss to ssss.
print "new value is";ssss.
end.

Example 2(compiles succesfully)

BEGINING.
XXX XY-1.
XXXX Y.
XXXX Z.
BODY.
PRINT "Please enter a number? ".
INPUT Y.
5
MOVE 15 TO Z.
ADD Y TO Z.
PRINT XY-1;" + ";Y;"=";Z.
END.


Example 3(error)

BEGINING.
XXX XY-1.
XXXX Y.
XXXX Z.
XXXX XX.
BODY.
PRINT "Please enter a number? ".
INPUT Y.
6
MOVE 15 TO Z.
ADD Y TO Z.
PRINT XY;" + ";Y;"=";Z.
END.
