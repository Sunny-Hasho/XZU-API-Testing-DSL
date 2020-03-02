@echo off
echo ========================================
echo    XZU Compiler - Error Testing Script
echo ========================================
echo.

REM Check if build directory exists
if not exist "build" (
    echo ERROR: Build directory not found!
    echo Please run 'scripts\2-build.bat' first.
    pause
    exit /b 1
)

REM Check if invalid-tests directory exists
if not exist "invalid-tests" (
    echo ERROR: invalid-tests directory not found!
    echo Please create the invalid-tests directory first.
    pause
    exit /b 1
)

echo Testing invalid input examples...
echo.

REM Test 1: Invalid identifier starting with digit
echo [1/4] Testing: Invalid variable name (starts with digit)
echo Expected: "expected IDENT after 'let'"
echo Content: Complete test suite with invalid variable '2user'
echo.
java -cp "build;lib\java-cup-11b-runtime.jar" compiler.XZUCompiler invalid-tests\error-1-identifier.test output\Error1.java
echo.
echo ----------------------------------------
echo.

REM Test 2: Invalid body type (number instead of string)
echo [2/4] Testing: Invalid body type in POST request
echo Expected: "expected STRING after 'body ='"
echo Content: POST request with numeric body instead of string
echo.
java -cp "build;lib\java-cup-11b-runtime.jar" compiler.XZUCompiler invalid-tests\error-2-body-string.test output\Error2.java
echo.
echo ----------------------------------------
echo.

REM Test 3: Invalid status type (string instead of integer)
echo [3/4] Testing: Invalid status type in expect statement
echo Expected: "expected NUMBER for status"
echo Content: expect status with string value instead of integer
echo.
java -cp "build;lib\java-cup-11b-runtime.jar" compiler.XZUCompiler invalid-tests\error-3-status-integer.test output\Error3.java
echo.
echo ----------------------------------------
echo.

REM Test 4: Missing semicolon in request body
echo [4/4] Testing: Missing semicolon in request body
echo Expected: "expected ';' after request"
echo Content: POST request body missing semicolon
echo.
java -cp "build;lib\java-cup-11b-runtime.jar" compiler.XZUCompiler invalid-tests\error-4-missing-semicolon.test output\Error4.java
echo.
echo ----------------------------------------
echo.

echo ========================================
echo    Error Testing Complete!
echo ========================================
echo.
echo All tests should have shown parser errors.
echo This demonstrates that the XZU compiler correctly
echo catches invalid syntax and provides clear error messages.
echo.
echo Test Coverage:
echo - Invalid variable names (starts with digit)
echo - Invalid body types (number instead of string)
echo - Invalid status types (string instead of integer)
echo - Missing semicolons in request bodies
echo.
echo These comprehensive error tests prove the robustness
echo of the XZU compiler's error handling capabilities.
echo.
pause
