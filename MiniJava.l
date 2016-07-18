%{
#include <iostream>
#include "MiniJava.tab.h"
using namespace std;
#define YY_DECL extern "C" int yylex()
int line_num = 1;
%}

%x COMMENTS

%%
[ \t\r\f]         ;
[{}()[\]=<>+\-*/\.%!,;]  { cout << yytext << endl; return (unsigned char) *yytext;   }
\n      { ++line_num; }
[+-]?[0-9]+          { cout << yytext << endl; yylval.ival = atoi(yytext); return num; }
"boolean"   { cout << yytext << endl;yylval.sval = strdup(yytext); return Boolean; }
"class"     { cout << yytext << endl;yylval.sval = strdup(yytext); return Class; }
"extends"   { cout << yytext << endl;yylval.sval = strdup(yytext); return Extends; }
"public"    { cout << yytext << endl;yylval.sval = strdup(yytext); return Public; }
"static"    { cout << yytext << endl;yylval.sval = strdup(yytext); return Static; }
"void"      { cout << yytext << endl;yylval.sval = strdup(yytext); return Void; }
"main"      { cout << yytext << endl;yylval.sval = strdup(yytext); return Main; }
"String"    { cout << yytext << endl;yylval.sval = strdup(yytext); return String; }
"return"    { cout << yytext << endl;yylval.sval = strdup(yytext); return Return; }
"int"       { cout << yytext << endl;yylval.sval = strdup(yytext); return Int; }
"if"        { cout << yytext << endl;yylval.sval = strdup(yytext); return If; }
"else"      { cout << yytext << endl;yylval.sval = strdup(yytext); return Else; }
"while"     { cout << yytext << endl;yylval.sval = strdup(yytext); return While; }
"System.out.println"    { cout << yytext << endl;yylval.sval = strdup(yytext); return Sout; }
"length"    { cout << yytext << endl;yylval.sval = strdup(yytext); return Length; }
"true"  { cout << yytext << endl;yylval.sval = strdup(yytext); return True; }
"false" { cout << yytext << endl;yylval.sval = strdup(yytext); return False; }
"this"  { cout << yytext << endl;yylval.sval = strdup(yytext); return This; }
"new"   { cout << yytext << endl;yylval.sval = strdup(yytext); return New; }
"null"  { cout << yytext << endl;yylval.sval = strdup(yytext); return Null; }
[a-zA-Z]+[[a-zA-Z0-9\_]*[a-zA-Z0-9]+]* { cout << yytext << endl; yylval.sval = strdup(yytext); return Id; }
"==" { cout << yytext << endl;yylval.sval = strdup(yytext); return igual; }
"!=" { cout << yytext << endl;yylval.sval = strdup(yytext); return diferente; }
"&&" { cout << yytext << endl;yylval.sval = strdup(yytext); return eLogico; }
<<EOF>> {yyterminate(); }

\/\* { // start of a comment: go to a 'COMMENTS' state.
	BEGIN(COMMENTS);
	}
<COMMENTS>\*\/    {   // end of a comment: go back to normal parsing.
	BEGIN(INITIAL);
	}
<COMMENTS>\n      { ++line_num; }   // still have to increment line numbers inside of comments!
<COMMENTS>.       ;   // ignore every other character while we're in this state
%%
