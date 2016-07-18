%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int line_num;
 
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
    //Variaveis
	int ival;
    char *sval;
	
}

// define the "terminal symbol" token types I"m going to use (in CAPS
// by convention), and associate each with a field of the union:
//Variáveis
%token <ival> num
%token <sval> Id
//Palavras reservadas
%token Boolean
%token Class
%token Extends
%token Public
%token Static
%token Void
%token Main
%token String
%token Return
%token Int
%token If
%token Else
%token While
%token Sout
%token Length
%token True
%token False
%token This
%token New
%token Null
//operators
%token <op> igual
%token <op> diferente
%token <op> eLogico

%%
// this is the actual grammar that bison will parse, but for right now it"s just
// something silly to echo to the screen what bison gets from flex.  We"ll
// make a real one shortly:
PROG:
	MAIN CLASSE
	;

MAIN:
    Class Id '{' Public Static Void Main '(' String '[' ']' Id ')' '{' CMD '}' '}'
    ; 


CLASSE:
	Class Id Extends Id '{' VARLIST METODOLIST '}'
	| Class Id '{' VARLIST METODOLIST '}'
    ; 

VARLIST:
    VARLIST VAR
	|
    ;

VAR:
	TIPO Id ';'
	;

METODOLIST:
	METODOLIST METODO
	|
	;

METODO:
    Public TIPO Id '(' PARAM ')' '{' VARLIST CMD Return EXP ';' '}'
	;

PARAM:
	PARAM ',' TIPO Id
	| TIPO Id	
	| 
	;

TIPO:
	Int '[' ']'
	| Boolean
	| Int
	| Id
	;

CMDLIST:
	CMDLIST CMD
	|
	;

CMD:
	'{' CMDLIST '}'
	| If '(' EXP ')' CMDLIST
	| If '(' EXP ')' CMDLIST Else CMD
	| While '(' EXP ')' CMDLIST
	| Sout '(' EXP ')' ';'
	| Id '=' EXP ';'
	| Id '[' EXP ']' '=' EXP ';'
	;

EXP:
	EXP eLogico REXP
	| REXP
	;

REXP:
	REXP '<' AEXP
	| REXP igual AEXP
	| REXP diferente AEXP
	| AEXP
	;

AEXP:
	AEXP '+' MEXP 
	| AEXP '-' MEXP 
	| MEXP
	;

MEXP:
	MEXP '*' SEXP
	| MEXP '/' SEXP
	| SEXP
	;

SEXP:
	'!' SEXP
	| '-' SEXP
	| True
	| False
	| num
	| Null
	| New Int '[' EXP ']'
	| PEXP '.' Length
	| PEXP '[' EXP ']'
	| PEXP
	;

PEXP:
	Id
	| This
	| New Id '(' ')'
	| '(' EXP ')'
	| PEXP '.' Id
	| PEXP '.' Id '(' EXPS ')'
	| PEXP '.' Id '(' ')'
	;

EXPS:
	EXPS ',' EXP 
	| EXP
	|
	;
%%
int main(int, char**) {
	
	// open a file handle to a particular file:
	FILE *myfile = fopen("mini.java", "r");
	// make sure it"s valId:
	if (!myfile) {
		cout << "I can't open mini.java!" << endl;
		return -1;
	}
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// lex through the input:
	yylex();
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror(const char *s) {
	cout << "EEK, parse error!" << line_num <<  "Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}

/*#include lex.yy.c*/
