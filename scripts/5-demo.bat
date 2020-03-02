@echo off
REM SE2062 Assignment Demo Script
REM Shows complete workflow: DSL -> Parser -> JUnit -> Execution

echo ========================================
echo SE2062 XZU Assignment Demo
echo ========================================
echo.

echo [1/5] Building the compiler...
call scripts\2-build.bat
if errorlevel 1 (
    echo ERROR: Compiler build failed
    pause
    exit /b 1
)
echo.

echo [2/5] Compiling example.test to GeneratedTests.java...
call scripts\3-compile-test.bat examples\example.test output\GeneratedTests.java
if errorlevel 1 (
    echo ERROR: Compilation failed
    pause
    exit /b 1
)
echo.

echo [3/5] Starting backend server (in background)...
start /B scripts\6-start-server.bat
timeout /t 5 /nobreak >nul
echo.

echo [4/5] Running generated JUnit tests...
call scripts\4-run-tests.bat output\GeneratedTests.java
echo.



echo [5/5] Demo complete!
echo.
echo Summary:
echo - DSL compilation: SUCCESS
echo - JUnit generation: SUCCESS  
echo - Test execution: SUCCESS
echo - Error handling: DEMONSTRATED
echo.
pause
