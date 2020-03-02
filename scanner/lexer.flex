package scanner;

import java_cup.runtime.*;
import parser.sym;

%%

%class Lexer
%public
%unicode
%cup
%line
%column

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline + 1, yycolumn + 1);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline + 1, yycolumn + 1, value);
    }
    
    // State for multiline string handling
    private StringBuilder multilineContent = new StringBuilder();
%}

%state MULTILINE_STRING

/* Regular Expressions */
LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
Comment        = "//" [^\r\n]*

Identifier     = [A-Za-z_][A-Za-z0-9_]*
Number         = 0 | [1-9][0-9]*
String         = \"([^\\\"]|\\.)*\"

%%

/* Keywords */
<YYINITIAL> {
    "config"        { return symbol(sym.CONFIG); }
    "base_url"      { return symbol(sym.BASE_URL); }
    "header"        { return symbol(sym.HEADER); }
    "let"           { return symbol(sym.LET); }
    "test"          { return symbol(sym.TEST); }
    "GET"           { return symbol(sym.GET); }
    "POST"          { return symbol(sym.POST); }
    "PUT"           { return symbol(sym.PUT); }
    "DELETE"        { return symbol(sym.DELETE); }
    "expect"        { return symbol(sym.EXPECT); }
    "status"        { return symbol(sym.STATUS); }
    "body"          { return symbol(sym.BODY); }
    "contains"      { return symbol(sym.CONTAINS); }
    "in"            { return symbol(sym.IN); }

    /* Operators and Delimiters */
    "="             { return symbol(sym.EQUALS); }
    ";"             { return symbol(sym.SEMICOLON); }
    "{"             { return symbol(sym.LBRACE); }
    "}"             { return symbol(sym.RBRACE); }
    ".."            { return symbol(sym.RANGE); }

    /* Literals */
    {Identifier}    { return symbol(sym.IDENTIFIER, yytext()); }
    {Number}        { return symbol(sym.NUMBER, Integer.parseInt(yytext())); }
    {String}        { 
        // Remove quotes and handle escape sequences
        String str = yytext();
        str = str.substring(1, str.length() - 1); // Remove quotes
        str = str.replace("\\\"", "\"");
        str = str.replace("\\\\", "\\");
        return symbol(sym.STRING, str); 
    }
    
    /* Triple-quoted string start */
    \"\"\"          { 
        multilineContent.setLength(0); 
        yybegin(MULTILINE_STRING); 
    }

    /* Whitespace and Comments */
    {WhiteSpace}    { /* ignore */ }
    {Comment}       { /* ignore */ }
}

/* Multiline string state */
<MULTILINE_STRING> {
    \"\"\"          { 
        String result = multilineContent.toString();
        multilineContent.setLength(0);
        yybegin(YYINITIAL);
        result = result.replace("\\\"", "\"");
        result = result.replace("\\\\", "\\");
        return symbol(sym.MULTILINE_STRING, result); 
    }
    
    [^]             { multilineContent.append(yytext()); }
}

/* Error fallback */
[^] { 
    System.err.println("\n" + "=".repeat(50));
    System.err.println("*** XZU LEXICAL ERROR ***");
    System.err.println("=".repeat(50));
    System.err.println("Location: Line " + (yyline + 1) + ", Column " + (yycolumn + 1));
    System.err.println("Problem: Illegal character '" + yytext() + "'");
    System.err.println("\nSuggestions:");
    System.err.println("   - Remove or replace the invalid character");
    System.err.println("   - Check for typos in keywords");
    System.err.println("   - Make sure strings are properly quoted with \"");
    System.err.println("   - Use only letters, numbers, and underscores in identifiers");
    System.err.println("\nValid characters: a-z, A-Z, 0-9, _, {, }, =, ;, \", space, tab");
    System.err.println("=".repeat(50) + "\n");
    throw new Error("Lexical error");
}