@echo off
:a
echo Калькулятор
echo введите первое число:
set /p a=
if "%a%"=="выход" goto b
echo введите действие:
set /p c=
if "%c%"=="выход" goto b
echo введите второе число:
set /p b=
if "%b%"=="выход" goto b
if "%c%"=="+" set /a a=a+b
if "%c%"=="-" set /a a=a-b
if "%c%"=="*" set /a a=a*b
if "%c%"=="/" set /a a=a/b
if "%c%"=="%" set /a a=a%b
if "%c%"=="&" set /a a=a&b
echo Ответ: "%a%"
goto a
:b