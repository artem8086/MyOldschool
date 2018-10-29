@echo off
ml /c /coff /Cp electronica.asm
rc electronica.rc
link /subsystem:windows electronica.obj electronica.res
electronica.exe