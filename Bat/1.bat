@echo off
:a
echo      (  /   )?
set /p a=
if "%a%"=="  " (echo       )
goto a