package compiler;

import scanner.Lexer;
import parser.Parser;
import ast.ProgramNode;
import codegen.CodeGenerator;
import java_cup.runtime.Symbol;

import java.io.FileReader;
import java.io.IOException;

/**
 * XZU Compiler - Main Entry Point
 * 
 * This is the main compiler class that orchestrates the entire compilation process:
 * 1. Lexical Analysis (Scanner) - Converts text to tokens
 * 2. Syntax Analysis (Parser) - Builds Abstract Syntax Tree
 * 3. Code Generation - Produces JUnit 5 test code
 * 
 * Usage: java compiler.XZUCompiler input.test output.java
 */
public class XZUCompiler {
    
    /**
     * Main method - Entry point for the compiler
     * Takes two arguments: input .test file and output .java file
     */
    public static void main(String[] args) {
        if (args.length != 2) {
            System.err.println("Usage: java compiler.XZUCompiler <input.test> <output.java>");
            System.exit(1);
        }
        
        String inputFile = args[0];
        String outputFile = args[1];
        
        try {
            compile(inputFile, outputFile);
            System.out.println("✓ XZU Compilation successful!");
            System.out.println("  Input:  " + inputFile);
            System.out.println("  Output: " + outputFile);
        } catch (Exception e) {
            System.err.println("\n" + "=".repeat(60));
            System.err.println("*** XZU COMPILATION FAILED ***");
            System.err.println("=".repeat(60));
            System.err.println("ERROR: " + e.getMessage());
            System.err.println("\nWhat to do next:");
            System.err.println("   1. Check the error messages above");
            System.err.println("   2. Fix the syntax issues in your .test file");
            System.err.println("   3. Run the compiler again");
            System.err.println("\nNeed help? Check the README.md for examples");
            System.err.println("=".repeat(60) + "\n");
            System.exit(1);
        }
    }
    
    /**
     * Main compilation method that executes the 3-phase compiler pipeline
     */
    public static void compile(String inputFile, String outputFile) throws Exception {
        // Step 1: Lexical Analysis (Scanning) - JFlex converts text to tokens
        System.out.println("[1/3] XZU Scanning...");
        Lexer lexer = new Lexer(new FileReader(inputFile));
        
        // Step 2: Syntax Analysis (Parsing) - CUP builds Abstract Syntax Tree
        System.out.println("[2/3] XZU Parsing...");
        Parser parser = new Parser(lexer);
        Symbol parseResult = parser.parse();
        ProgramNode program = (ProgramNode) parseResult.value;
        
        // Step 2.5: Semantic Validation - Check test requirements
        validateProgram(program);
        
        // Step 3: Code Generation - Convert AST to JUnit 5 test code
        System.out.println("[3/3] XZU Generating code...");
        CodeGenerator generator = new CodeGenerator(program);
        generator.generate(outputFile);
    }
    
    /**
     * Validate the parsed program
     */
    private static void validateProgram(ProgramNode program) {
        // Check that we have at least one test
        if (program.getTests().isEmpty()) {
            System.err.println("\n*** Validation Error: No test blocks found ***");
            System.err.println("Your .test file must contain at least one test block");
            System.err.println("Example:");
            System.err.println("   test MyTest {");
            System.err.println("     GET \"/api/users\";");
            System.err.println("     expect status = 200;");
            System.err.println("     expect body contains \"users\";");
            System.err.println("   }");
            throw new RuntimeException("No test blocks found");
        }
        
        // Validate each test
        for (var test : program.getTests()) {
            if (test.getRequests().isEmpty()) {
                System.err.println("\n*** Validation Error: Test '" + test.getName() + "' has no requests ***");
                System.err.println("Each test must contain at least one HTTP request");
                System.err.println("Example:");
                System.err.println("   test " + test.getName() + " {");
                System.err.println("     GET \"/api/users\";  <-- Add this");
                System.err.println("     expect status = 200;");
                System.err.println("   }");
                throw new RuntimeException("Test '" + test.getName() + "' has no requests");
            }
            if (test.getAssertions().size() < 2) {
                System.err.println("\n*** Validation Error: Test '" + test.getName() + "' has only " + 
                                 test.getAssertions().size() + " assertion(s) ***");
                System.err.println("Each test must contain at least 2 assertions");
                System.err.println("Example:");
                System.err.println("   test " + test.getName() + " {");
                System.err.println("     GET \"/api/users\";");
                System.err.println("     expect status = 200;  <-- Add this");
                System.err.println("     expect body contains \"users\";  <-- Add this");
                System.err.println("   }");
                throw new RuntimeException("Test '" + test.getName() + "' needs at least 2 assertions");
            }
        }
    }
}