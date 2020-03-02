@echo off
REM Compile the XZU compiler: Scanner + Parser + Code Generator

echo === Compiling XZU Compiler ===

REM Paths
set LIB_DIR=lib
set BUILD_DIR=build
set JFLEX_JAR=%LIB_DIR%\jflex-1.7.0.jar
set CUP_JAR=%LIB_DIR%\java-cup-11b.jar
set CUP_RUNTIME=%LIB_DIR%\java-cup-11b-runtime.jar

REM Check if dependencies exist
if not exist "%JFLEX_JAR%" (
    echo Dependencies not found. Run setup-deps.bat first
    pause
    exit /b 1
)

if not exist "%CUP_JAR%" (
    echo Dependencies not found. Run setup-deps.bat first
    pause
    exit /b 1
)

REM Create build directory
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

echo [1/5] Generating Scanner with JFlex...
java -cp "%JFLEX_JAR%;%CUP_RUNTIME%" jflex.Main -d "%BUILD_DIR%" scanner\lexer.flex

echo [2/5] Generating Parser with CUP...
java -cp "%CUP_JAR%;%CUP_RUNTIME%" java_cup.Main -destdir "%BUILD_DIR%" -parser Parser -symbols sym parser\parser.cup

echo [3/5] Compiling AST classes...
javac -d "%BUILD_DIR%" -cp "%CUP_RUNTIME%" ast\*.java

echo [4/5] Compiling Scanner and Parser...
javac -d "%BUILD_DIR%" -cp "%CUP_RUNTIME%;%BUILD_DIR%" "%BUILD_DIR%\*.java"

echo [5/5] Compiling Code Generator and Compiler...
javac -d "%BUILD_DIR%" -cp "%CUP_RUNTIME%;%BUILD_DIR%" codegen\*.java compiler\*.java

echo [6/6] Cleaning up backup files...
if exist "%BUILD_DIR%\Lexer.java~" del "%BUILD_DIR%\Lexer.java~"

echo ✓ Compilation successful! Output in %BUILD_DIR%\
pause


