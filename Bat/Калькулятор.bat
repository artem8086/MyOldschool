@echo off
:a
echo ��������
echo ������ ��ࢮ� �᫮:
set /p a=
if "%a%"=="��室" goto b
echo ������ ����⢨�:
set /p c=
if "%c%"=="��室" goto b
echo ������ ��஥ �᫮:
set /p b=
if "%b%"=="��室" goto b
if "%c%"=="+" set /a a=a+b
if "%c%"=="-" set /a a=a-b
if "%c%"=="*" set /a a=a*b
if "%c%"=="/" set /a a=a/b
if "%c%"=="%" set /a a=a%b
if "%c%"=="&" set /a a=a&b
echo �⢥�: "%a%"
goto a
:b