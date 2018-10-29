; #########################################################################
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\gdi32.inc
include \masm32\include\opengl32.inc
include \masm32\include\glu32.inc
include \masm32\include\masm32.inc


includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\opengl32.lib
includelib \masm32\lib\glu32.lib
includelib \masm32\lib\masm32.lib



; #########################################################################

szText MACRO Name,Text:VARARG
LOCAL lbl
jmp lbl
Name db Text,0
lbl:
ENDM

m2m MACRO M1, M2
push M2
pop M1
ENDM

return MACRO arg
mov eax,arg
ret
ENDM

literal MACRO quoted_text:VARARG
LOCAL local_text
.data
local_text db quoted_text,0
align 4
.code
EXITM <local_text>
ENDM

SADD MACRO quoted_text:VARARG
EXITM <ADDR literal(quoted_text)>
ENDM


; #########################################################################

.data
szClassName db "OpenGl",0
szDisplayName db "Трехосный эллипсоид",0


CommandLine dd 0
hWnd dd 0
hInstance dd 0
hIcon dd 0
hCursor dd 0

; #########################################################################
include opngl.asm

; #########################################################################




WinMain PROTO :DWORD,:DWORD,:DWORD,:DWORD
RegisterWinClass PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
WndProc PROTO :DWORD,:DWORD,:DWORD,:DWORD
TopXY PROTO :DWORD,:DWORD