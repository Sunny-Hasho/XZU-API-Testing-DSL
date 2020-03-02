@echo off
REM Start the Spring Boot backend server

set BACKEND_DIR=backend

if not exist "%BACKEND_DIR%" (
    echo Error: Backend directory not found
    pause
    exit /b 1
)

cd "%BACKEND_DIR%"

REM Check if JAR exists
set JAR_FILE=target\xzu-demo-0.0.1-SNAPSHOT.jar

if not exist "%JAR_FILE%" (
    echo Backend JAR not found. Building with Maven...
    
    mvn --version >nul 2>&1
    if errorlevel 1 (
        echo Error: Maven not installed. Please install Maven first.
        echo Download from: https://maven.apache.org/download.cgi
        pause
        exit /b 1
    )
    
    mvn clean package -DskipTests
)

echo === Starting Backend Server ===
echo Server will be available at: http://localhost:8080
echo.

java -jar "%JAR_FILE%"
pause


