@echo off
REM Clean up duplicate generated files from source directories
REM This script removes the generated files from scanner/ and parser/ directories
REM since they are now generated directly in build/

echo === Cleaning Up Duplicate Generated Files ===

REM Remove generated files from scanner directory
if exist "scanner\Lexer.java" (
    echo Removing scanner\Lexer.java...
    del "scanner\Lexer.java"
)

if exist "scanner\Lexer.java~" (
    echo Removing scanner\Lexer.java~...
    del "scanner\Lexer.java~"
)

REM Remove backup files from build/java directory
if exist "build\java\Lexer.java~" (
    echo Removing build\java\Lexer.java~...
    del "build\java\Lexer.java~"
)

REM Remove generated files from parser directory
if exist "parser\Parser.java" (
    echo Removing parser\Parser.java...
    del "parser\Parser.java"
)

if exist "parser\sym.java" (
    echo Removing parser\sym.java...
    del "parser\sym.java"
)

echo ✓ Cleanup complete! Generated files now only exist in build/java/ directory
echo.
echo Note: Run compile.bat to regenerate files in build/java/ directory
pause
