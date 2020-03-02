@echo off
echo Creating XZU Backend Snapshot...

REM Navigate to target directory
cd /d "%~dp0target"

REM Check if old JAR exists
if exist "testlang-demo-0.0.1-SNAPSHOT.jar" (
    echo Found existing JAR file, creating XZU snapshot...
    copy "testlang-demo-0.0.1-SNAPSHOT.jar" "xzu-demo-0.0.1-SNAPSHOT.jar"
    echo XZU Backend Snapshot created: xzu-demo-0.0.1-SNAPSHOT.jar
) else (
    echo No existing JAR found. Please compile the backend first.
    echo You can use: mvn clean package -DskipTests
)

echo.
echo XZU Backend Snapshot Ready!
echo To start the backend: java -jar xzu-demo-0.0.1-SNAPSHOT.jar