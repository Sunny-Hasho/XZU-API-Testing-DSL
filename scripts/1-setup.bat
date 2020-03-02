@echo off
REM Setup script - downloads JFlex and CUP if not present

set LIB_DIR=lib
set JFLEX_VERSION=1.9.1
set CUP_VERSION=11b

if not exist "%LIB_DIR%" mkdir "%LIB_DIR%"

REM Download JFlex if not present
if not exist "%LIB_DIR%\jflex-full-%JFLEX_VERSION%.jar" (
    echo Downloading JFlex %JFLEX_VERSION%...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/jflex-de/jflex/releases/download/v%JFLEX_VERSION%/jflex-full-%JFLEX_VERSION%.jar' -OutFile '%LIB_DIR%\jflex-full-%JFLEX_VERSION%.jar'"
)

REM Download CUP if not present
if not exist "%LIB_DIR%\java-cup-%CUP_VERSION%.jar" (
    echo Downloading CUP %CUP_VERSION%...
    powershell -Command "Invoke-WebRequest -Uri 'http://www2.cs.tum.edu/projects/cup/releases/java-cup-bin-%CUP_VERSION%-20160615.tar.gz' -OutFile '%LIB_DIR%\java-cup-%CUP_VERSION%.tar.gz'"
    powershell -Command "Expand-Archive -Path '%LIB_DIR%\java-cup-%CUP_VERSION%.tar.gz' -DestinationPath '%LIB_DIR%\temp' -Force"
    copy "%LIB_DIR%\temp\java-cup-11b\java-cup-11b.jar" "%LIB_DIR%\java-cup-%CUP_VERSION%.jar"
    rmdir /s /q "%LIB_DIR%\temp"
    del "%LIB_DIR%\java-cup-%CUP_VERSION%.tar.gz"
)

REM Download CUP runtime if not present
if not exist "%LIB_DIR%\java-cup-%CUP_VERSION%-runtime.jar" (
    echo Downloading CUP runtime %CUP_VERSION%...
    powershell -Command "Invoke-WebRequest -Uri 'http://www2.cs.tum.edu/projects/cup/releases/java-cup-bin-%CUP_VERSION%-20160615.tar.gz' -OutFile '%LIB_DIR%\java-cup-runtime-%CUP_VERSION%.tar.gz'"
    powershell -Command "Expand-Archive -Path '%LIB_DIR%\java-cup-runtime-%CUP_VERSION%.tar.gz' -DestinationPath '%LIB_DIR%\temp' -Force"
    copy "%LIB_DIR%\temp\java-cup-11b\java-cup-11b-runtime.jar" "%LIB_DIR%\java-cup-%CUP_VERSION%-runtime.jar"
    rmdir /s /q "%LIB_DIR%\temp"
    del "%LIB_DIR%\java-cup-runtime-%CUP_VERSION%.tar.gz"
)

echo ✓ Dependencies ready in %LIB_DIR%\
pause


