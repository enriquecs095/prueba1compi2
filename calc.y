%{

    #include <cstdio>
    using namespace std;
    int yylex();
    #define YYERROR_VERBOSE 1
    #define YYDEBUG  1
    extern int yylineno;
    
    void yyerror(const char * s){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, s);
    }

%}

%token EOL
%token ADD SUB MUL DIV ABS MAYOR MINUS MAYOR_EQUAL MINUS_EQUAL EQUAL
%token NUMBER TRUE FALSE

%%

exprlist: /* E */
    | exprlist exp EOL 
    ;

exp: exp ADD factor {$$ = $1+$3; }
    | exp SUB factor {$$ = $1 - $3;}
    | factor { $$ = $1; }
    | bools { $$ = $1; }
    ;

factor: factor MUL term { $$ = $1*$3; }
    | factor DIV term { $$ = $1/$3; }
    | factor MAYOR term {$$ = $1 > $3 ? 1 : 0;  }
    | factor MINUS term {$$ = $1 < $3 ? 1 : 0;  }
    | factor MAYOR_EQUAL term {$$ = $1 >= $3 ? 1 : 0;  }
    | factor MINUS_EQUAL term {$$ = $1 <= $3 ? 1 : 0;  }
    | factor EQUAL term {$$ = $1 == $3 ? 1 : 0;  }
    | term { $$ = $1; }
    ;

term: NUMBER { $$ = $1; }
    | ABS term { $$ = $2 >= 0 ? $2 : -1 * $2;  }  
    ;

bools :  bools EQUAL boolean {$$ = $1 == $3 ? 1 : 1;  }
        | boolean  { $$ = $1; }
        ;

boolean: TRUE {$$ = $1; }
        | FALSE {$$ = $1; }
        ;



%%
    