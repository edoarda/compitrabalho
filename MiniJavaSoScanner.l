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
[\{\}\(\)\[\]=<>+\-*/\.%!,;]  { cout << yytext << endl;  }
\n      { ++line_num; }
[+-]?[0-9]+          { cout << yytext << endl; yylval.ival = atoi(yytext);   }
"boolean"   { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"class"     { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"extends"   { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"public"    { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"static"    { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"void"      { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"main"      { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"String"    { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"return"    { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"int"       { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"if"        { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"else"      { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"while"     { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"System.out.println"    { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"length"    { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"true"  { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"false" { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"this"  { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"new"   { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"null"  { cout << yytext << endl;yylval.sval = strdup(yytext);   }
[a-zA-Z]+[a-zA-Z0-9\_]* { cout << yytext << endl; yylval.sval = strdup(yytext);   }
"==" { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"!=" { cout << yytext << endl;yylval.sval = strdup(yytext);   }
"&&" { cout << yytext << endl;yylval.sval = strdup(yytext);   }
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
