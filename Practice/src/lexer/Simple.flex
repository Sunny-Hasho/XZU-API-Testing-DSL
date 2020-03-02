package lexer;

import java_cup.runtime.Symbol;
import parser.sym;

%%

%class SimpleLexer
%unicode
%public
%cup
%line
%column

%%

[0-9]+                 { return new Symbol(sym.NUMBER, yyline, yycolumn, yytext()); }
[a-zA-Z_][a-zA-Z0-9_]* { return new Symbol(sym.IDENTIFIER, yyline, yycolumn, yytext()); }
"="                    { return new Symbol(sym.EQUALS); }
"+"                    { return new Symbol(sym.PLUS); }
"-"                    { return new Symbol(sym.MINUS); }
[ \t\r\n]+             { /* skip whitespace */ }
.                      { return new Symbol(sym.UNKNOWN, yytext()); }

<<EOF>>                { return new Symbol(sym.EOF); }
