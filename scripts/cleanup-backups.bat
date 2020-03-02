@echo off
REM Clean up all backup files created by JFlex and CUP
REM This script removes all .java~ backup files from the project

echo === Cleaning Up Backup Files ===

REM Remove backup files from build/java directory
if exist "build\java\*.java~" (
    echo Removing backup files from build/java/ directory...
    del "build\java\*.java~"
)

REM Remove backup files from scanner directory
if exist "scanner\*.java~" (
    echo Removing backup files from scanner/ directory...
    del "scanner\*.java~"
)

REM Remove backup files from parser directory
if exist "parser\*.java~" (
    echo Removing backup files from parser/ directory...
    del "parser\*.java~"
)

echo ✓ Backup files cleanup complete!
echo.
echo Note: Backup files are automatically cleaned up during compilation
pause
