Before any of the below I installed flex and bison and a c compiler

1) Open any kind of terminal (I used Windows 10 Command Prompt)
2) Navigate to the project directory
3) run 'flex lexer.l' to create a .c file called 'lex.yy.c' 
4) run 'gcc lex.yy.c' to create an executable called 'a.exe'
5) run the executable 'a.exe' using './a' or 'a'
6) the program is now running and it can be tested

7a) one way I tested the program was to input a single line of code and test the lexer e.g.

XXXX test-

--Termial Output--: 

xxxxx test-
[VALID Variable Declaration that can hold a digit of lenght 5]  [VALID Variable Name]  [VALID New line]

7b) another way is pasting a couple of lines into the terminal e.g.

XXXX test-
ADD test- TO test--

--Termial Output--: 

xxxxx test-
[VALID Variable Declaration that can hold a digit of lenght 5]  [VALID Variable Name]  [VALID New line]
ADD test- TO test--
[VALID Add Declaration]  [VALID Variable Name] [VALID To Declaration] [VALID Variable Name] [VALID New line]
