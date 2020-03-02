@echo off
REM Run the XZU compiler on a .test file

if "%1"=="" (
    echo Usage: %0 ^<input.test^> [output.java]
    echo Example: %0 examples\example.test output\GeneratedTests.java
    echo.
    echo Note: Per assignment spec, all tests should go in ONE .test file
    echo       and generate a SINGLE GeneratedTests.java file
    pause
    exit /b 1
)

set INPUT_FILE=%1
if "%2"=="" (
    set OUTPUT_FILE=output\GeneratedTests.java
) else (
    set OUTPUT_FILE=%2
)

if not exist "%INPUT_FILE%" (
    echo Error: Input file '%INPUT_FILE%' not found
    pause
    exit /b 1
)

REM Ensure output directory exists
for %%f in ("%OUTPUT_FILE%") do set OUTPUT_DIR=%%~dpf
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Paths
set BUILD_DIR=build
set CUP_RUNTIME=lib\java-cup-11b-runtime.jar

if not exist "%BUILD_DIR%" (
    echo Build directory not found. Run compile.bat first
    pause
    exit /b 1
)

echo === Running XZU Compiler ===
echo Input:  %INPUT_FILE%
echo Output: %OUTPUT_FILE%
echo.

java -cp "%BUILD_DIR%;%CUP_RUNTIME%" compiler.XZUCompiler "%INPUT_FILE%" "%OUTPUT_FILE%"

echo.
echo ✓ Generated: %OUTPUT_FILE%
pause


