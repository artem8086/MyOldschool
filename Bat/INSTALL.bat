@echo  off
echo Копирование...
xcopy A:\Программы\*.* C:\Программы\*.* /s /a /q
explorer.exe c:\Программы
