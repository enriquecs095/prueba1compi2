%option noyywrap
%option yylineno

%{
    #include "tokens.h"
    extern int yylval;
%}

%%
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
">=" { return MAYOR_EQUAL; }
"<=" { return MINUS_EQUAL; }
">" { return MAYOR; }
"<" { return MINUS; }
"==" { return EQUAL; }
"true" { return TRUE; }
"false" { return FALSE; }


[0-9]+ { yylval = atoi(yytext); return NUMBER; }
[\n] { return EOL; }
[ \t ] { /* ignorar */ }
. { printf("invalido %c\n", yytext[0]); }
%%