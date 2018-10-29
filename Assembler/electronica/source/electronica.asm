.386
.model flat,stdcall
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\shell32.inc
include \masm32\include\gdi32.inc
include \masm32\include\comdlg32.inc

includelib \masm32\lib\comdlg32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\shell32.lib
includelib \masm32\lib\gdi32.lib

WinMain proto :dword,:dword,:dword
WndProc proto :dword,:dword,:dword,:dword
WndProc2 proto :dword,:dword,:dword,:dword
IconButton PROTO :DWORD,:DWORD,:DWORD
GetPos proto :dword
SetLine proto :dword
GetLine proto :dword
SetElement proto :DWORD
GetElement proto :dword
CmpLine proto
DrawLine proto :DWORD,:DWORD
CmpElement proto
GetLevelLine proto :DWORD
SetLevelLine proto :DWORD,:DWORD
RedrawElement proto
LoadIconArray proto :DWORD

.data
appname db "Электроника   (автор: Святоха Артём)",0
static db "STATIC",0
classname db "SWC",0
dialogname db "a2",0
menu db "MENUP",0
maxel db "Количество елементов не должно превышать 255 штук!",0
maxln db "Количество проводов не должно превышать 255 штук!",0
close1 db "Вы действительно хотите выйти,",0
close2 db "Выход",0
butn db "BUTTON",0
ask db "%d",0
empty db 0
element db 5
eor db "Или",0,0,0,0,0,0,0
exor db "Искл. или",0
eand db "И",0,0,0,0,0,0,0,0,0
enot db "Не",0,0,0,0,0,0,0,0
ebuttonon db "Вкл.",0,0,0,0,0,0
ebuttonoff db "Выкл.",0,0,0,0,0
eline db "Провод",0,0,0,0
ecursor db "Указатель",0

Filteropendlg	db "*.alf",0,0
Titleopendlg1	db "Открыть файл",0
Titleopendlg2	db "Сохранить файл",0
opendlg1STR		OPENFILENAME <>

.data?
arrayicon dd 10 dup (?)

;setupline db ?
;setupelement db ?

;hdc2 dd ?
hpen dd ?
hwnd2 dd ?
hwnd3 dd ?
data db ?
code dd ?
exit db ?
hdc dd ?
hbut dd ?
hstatic dd ?
hinstance dd ?
hicon dd ?
hicon2 dd ?
hiconmain dd ?
memdc dd ?
xyp dw ?
xp db ?
yp db ?
el1 db ?
el2 db ?
el3 db ?
el4 db ?

byte1 db ?
byte2 db ?
byte3 db ?
byte4 db ?
byte5 db ?
byte6 db ?

levelline db 16 dup (?)

numline db ?
maxline db ?
numelement db ?
cline db 1275 dup (?)
celement db 1530 dup (?)

hfile dd ?
buffer db 512 dup (?)
.code
begin:
invoke GetModuleHandle,0
mov hinstance,eax
invoke WinMain,hinstance,0,SW_SHOWDEFAULT
invoke ExitProcess,eax

WinMain proc hinst:dword,hprevinst:dword,cmdshow:dword
local wc:WNDCLASSEX
local msg:MSG
mov wc.cbSize,sizeof WNDCLASSEX
mov wc.style,CS_HREDRAW or CS_VREDRAW
mov wc.lpfnWndProc,offset WndProc
mov wc.cbClsExtra,0
mov wc.cbWndExtra,0
push hinstance
pop wc.hInstance
mov wc.hbrBackground,COLOR_WINDOW+1
mov wc.lpszMenuName,0
mov wc.lpszClassName,offset classname
invoke LoadIcon,hinstance,10
mov wc.hIcon,eax
mov hiconmain,eax
mov wc.hIconSm,eax
invoke LoadCursor,hinstance,11
mov wc.hCursor,eax
invoke RegisterClassEx,addr wc
invoke LoadMenu,hinstance,addr menu
invoke CreateWindowEx,0,addr classname,addr appname,WS_OVERLAPPEDWINDOW,0,88,517,563,0,eax,hinst,0
mov hwnd3,eax
invoke ShowWindow,eax,cmdshow
invoke DialogBoxParamA,hinstance,addr dialogname,0,offset WndProc2,0
WinMain endp

WndProc proc hwnd:dword,umsg:dword,wparam:dword,lparam:dword
local ps:PAINTSTRUCT
;local hdc2:HDC

mov al,element
.IF al==8
mov ecx,0
mov cl,numelement
.IF cl!=0
lopel:
push ecx
dec cl
invoke GetElement,ecx
mov dl,byte1
.IF dl!=0
mov bl,byte4
xor eax,eax
.IF bl!=0

.IF dl>=1
.IF dl<=3
xor eax,eax
mov al,byte2
.IF al!=0
invoke GetLevelLine,eax
.ENDIF
mov dl,al
mov al,byte3
.IF al!=0
invoke GetLevelLine,eax
.ENDIF
mov dh,al
mov bl,byte1
.IF bl==1
or dl,dh
.ELSEIF bl==2
xor dl,dh
.ELSE
and dl,dh
.ENDIF
mov al,dl
xor ebx,ebx
mov bl,byte4
invoke SetLevelLine,ebx,eax
.ELSEIF dl>=4
jmp notel
.ENDIF
.ELSEIF dl>=4
jmp notel
.ENDIF
jmp nextel
notel:
mov al,byte2
.IF al!=0
invoke GetLevelLine,eax
.ENDIF
.IF dl==4
xor al,1
.ELSEIF dl==5
xor al,al
.ENDIF
xor ebx,ebx
mov bl,byte4
invoke SetLevelLine,ebx,eax
nextel:
.ENDIF
.ENDIF

pop ecx
dec cl
jnz lopel
.ENDIF
invoke GetDC,hwnd
mov hdc,eax
invoke DrawLine,0,4
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ENDIF

.IF umsg==WM_CREATE
mov opendlg1STR.lStructSize,SIZEOF opendlg1STR
push hwnd
pop opendlg1STR.hWndOwner
push hinstance
pop opendlg1STR.hInstance
mov opendlg1STR.lpstrFilter,offset Filteropendlg
mov opendlg1STR.lpstrFile,offset buffer
mov opendlg1STR.nMaxFile,260
mov opendlg1STR.Flags,OFN_LONGNAMES+OFN_HIDEREADONLY+OFN_FILEMUSTEXIST+OFN_EXPLORER+OFN_CREATEPROMPT
invoke GetDC,hwnd
mov hdc,eax


invoke CreateCompatibleBitmap,hdc,1023,1023
mov hicon,eax
invoke CreateCompatibleDC,hdc
mov memdc,eax
invoke SelectObject,memdc,hicon

;invoke CreateCompatibleBitmap,hdc,1023,1023
;mov hicon,eax
;invoke CreateCompatibleDC,hdc
;mov hdc2,eax
;invoke SelectObject,hdc2,hicon

;invoke PatBlt,hdc2,0,0,1023,1023,White
invoke PatBlt,memdc,0,0,1023,1023,White

invoke CreatePen,PS_NULL,1,0
mov hpen,eax
invoke SelectObject,memdc,hpen
;invoke SelectObject,hdc2,hpen

invoke ReleaseDC,hwnd,hdc

;invoke CheckMenuItem,hmenu,21,MF_CHECKED
;invoke CheckMenuItem,hmenu,23,MF_CHECKED
.ELSEIF umsg==WM_COMMAND
.IF wparam==5
invoke ShellAbout,hwnd,ADDR appname,ADDR appname,hiconmain
.ELSEIF wparam==4
jmp exitprog
.ELSEIF wparam==2
mov opendlg1STR.lpstrTitle,offset Titleopendlg1
invoke	GetOpenFileName,ADDR opendlg1STR
.IF eax==TRUE
invoke _lopen,opendlg1STR.lpstrFile,OF_READ
mov hfile,eax
mov ecx,16
mov ebx,offset levelline
xor al,al
lop11:
mov [ebx],al
inc ebx
loop lop11

invoke _hread,hfile,addr numline,3
xor eax,eax
mov al,numline
mov bx,5
mul bx
invoke _hread,hfile,addr cline,eax
xor eax,eax
mov al,numelement
mov bx,6
mul bx
invoke _hread,hfile,addr celement,eax
invoke _lclose,hfile
invoke GetDC,hwnd
mov hdc,eax
invoke PatBlt,memdc,0,0,1023,1023,White
invoke DrawLine,0,4
invoke RedrawElement
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ENDIF

.ELSEIF wparam==3
mov opendlg1STR.lpstrTitle,offset Titleopendlg2
invoke	GetSaveFileName,ADDR opendlg1STR
.IF eax==TRUE
;invoke DeleteFile,opendlg1STR.lpstrFile
invoke _lopen,opendlg1STR.lpstrFile,OF_WRITE+OF_CREATE
mov hfile,eax
invoke _hwrite,hfile,addr numline,3
xor eax,eax
mov al,numline
mov bx,5
mul bx
invoke _hwrite,hfile,addr cline,eax
xor eax,eax
mov al,numelement
mov bx,6
mul bx
invoke _hwrite,hfile,addr celement,eax
invoke _lclose,hfile
.ENDIF
.ELSEIF wparam==1
invoke GetDC,hwnd
mov hdc,eax
invoke PatBlt,memdc,0,0,1023,1023,White
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
mov ecx,19
mov ebx,offset levelline
xor al,al
lop8:
mov [ebx],al
inc ebx
loop lop8
.ELSEIF wparam==10
invoke GetDC,hwnd
mov hdc,eax
invoke PatBlt,memdc,0,0,1023,1023,White
invoke RedrawElement
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
mov ecx,18
mov ebx,offset levelline
xor al,al
lop9:
mov [ebx],al
inc ebx
loop lop9
.ELSEIF wparam==11
mov ecx,16
mov ebx,offset levelline
xor al,al
mov numelement,al
lop10:
mov [ebx],al
inc ebx
loop lop10
invoke GetDC,hwnd
mov hdc,eax
invoke PatBlt,memdc,0,0,1023,1023,White
invoke DrawLine,0,4
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ELSEIF wparam==12
invoke CmpElement
mov cl,numelement
.IF cl!=0
dec numelement
invoke GetDC,hwnd
mov hdc,eax
invoke PatBlt,memdc,0,0,1023,1023,White
invoke DrawLine,0,4
invoke RedrawElement
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ENDIF

.ELSEIF wparam==13
invoke CmpElement
mov cl,numline
.IF cl!=0
dec numline
invoke GetDC,hwnd
mov hdc,eax
invoke PatBlt,memdc,0,0,1023,1023,White
invoke DrawLine,0,4
invoke RedrawElement
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ENDIF
;.ELSEIF wparam==20
;invoke CheckMenuItem,hmenu,20,MF_CHECKED
;invoke CheckMenuItem,hmenu,21,MF_UNCHECKED
;mov al,1
;mov setupline,al
;.ELSEIF wparam==21
;invoke CheckMenuItem,hmenu,20,MF_UNCHECKED
;invoke CheckMenuItem,hmenu,21,MF_CHECKED
;xor al,al
;mov setupline,al
;.ELSEIF wparam==22
;invoke CheckMenuItem,hmenu,22,MF_CHECKED
;invoke CheckMenuItem,hmenu,23,MF_UNCHECKED
;mov al,1
;mov setupelement,al
;.ELSEIF wparam==23
;invoke CheckMenuItem,hmenu,22,MF_UNCHECKED
;invoke CheckMenuItem,hmenu,23,MF_CHECKED
;xor al,al
;mov setupelement,al
.ENDIF

.ELSEIF umsg==WM_PAINT
invoke BeginPaint,hwnd,addr ps
mov hdc,eax
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke BitBlt,hdc,0,0,1023,1023,hdc2,0,0,SRCCOPY
invoke EndPaint,hwnd,addr ps
.ELSEIF umsg==WM_LBUTTONDOWN
mov al,element
.IF al>=1
.IF al<=6
mov al,numelement
.IF al==255
invoke MessageBox,hwnd,addr maxel,addr appname,MB_ICONINFORMATION
.ELSEIF
xor al,al
mov data,al
invoke GetDC,hwnd
mov hdc,eax
invoke GetPos,lparam
invoke DrawIcon,memdc,eax,ebx,hicon
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
invoke GetPos,lparam
shr ax,2
shr bx,2
mov byte5,al
mov byte6,bl

xor al,al
mov byte2,al
mov byte3,al
mov byte4,al

mov al,element
mov byte1,al
xor eax,eax
mov al,numelement
invoke SetElement,eax
inc numelement
.ENDIF
.ENDIF
.ENDIF
mov al,element
.IF al==7
mov al,numline
.IF al==255
invoke MessageBox,hwnd,addr maxln,addr appname,MB_ICONINFORMATION
.ELSE
mov al,data
.IF al==0
invoke GetPos,lparam
shr ax,2
shr bx,2
mov ah,bl
mov el2,al
mov el3,ah
mov xyp,ax

xor al,al
mov el1,al
mov ecx,0
mov cl,numline
.IF ecx!=0
lop5:
push ecx
dec cl
invoke GetLine,ecx
mov bl,byte2
mov bh,byte3
mov al,byte1
cmp ax,xyp
jz exit3
mov bl,byte4
mov bh,byte5
mov al,byte1
cmp bx,xyp
jz exit3
pop ecx
loop lop5
xor al,al
exit3:
mov el1,al
.ENDIF
mov al,1
mov data,al
.ENDIF
.ENDIF
.ELSEIF al==8
xor ecx,ecx
mov cl,numelement
.IF cl!=0
;invoke GetDC,hwnd
;mov hdc,eax

lopbutton:
push ecx
dec cl
invoke GetElement,ecx
mov al,byte1
.IF al>=5
invoke GetPos,lparam
shr ax,2
shr bx,2

sub al,byte5
jnc next3
mov al,8
next3:
sub bl,byte6
jnc next4
mov bl,8
next4:
.IF al<=7
.IF bl<=7
xor eax,eax
mov al,byte1
xor al,3
mov byte1,al
pop ecx
push ecx
dec cl
invoke SetElement,ecx
.ENDIF
.ENDIF
.ENDIF
pop ecx
loop lopbutton

invoke RedrawElement
;invoke ReleaseDC,hwnd,hdc
.ENDIF

.ENDIF

.ELSEIF umsg==WM_RBUTTONDOWN
xor ecx,ecx
mov cl,numelement
.IF cl!=0
lopdelete:
push ecx
dec cl
invoke GetElement,ecx
invoke GetPos,lparam
shr ax,2
shr bx,2

sub al,byte5
jnc next5
mov al,8
next5:
sub bl,byte6
jnc next6
mov bl,8
next6:
.IF al<=7
.IF bl<=7
xor eax,eax
dec numelement
mov al,numelement
invoke GetElement,eax

pop ecx
push ecx
dec cl
invoke SetElement,ecx
.ENDIF
.ENDIF
pop ecx
loop lopdelete
.IF al==8
mov ecx,16
mov ebx,offset levelline
xor al,al
lop15:
mov [ebx],al
inc ebx
loop lop15
invoke CmpElement
.ENDIF
invoke GetDC,hwnd
mov hdc,eax
invoke PatBlt,memdc,0,0,1023,1023,White
invoke DrawLine,0,4
invoke RedrawElement
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ENDIF

.ELSEIF umsg==WM_LBUTTONUP
mov al,data
.IF al==1

invoke GetPos,lparam
shr ax,2
shr bx,2
mov ah,bl
mov xyp,ax

mov al,el1
.IF al==0
mov ecx,0
mov cl,numline
.IF ecx==0
inc maxline
mov al,maxline
mov byte1,al
.ELSE
lop6:
push ecx
dec cl
invoke GetLine,ecx
mov bl,byte2
mov bh,byte3
mov al,byte1
cmp bx,xyp
jz exit4
mov bl,byte4
mov bh,byte5
mov al,byte1
cmp bx,xyp
jz exit4
pop ecx
loop lop6
inc maxline
mov al,maxline
exit4:
mov byte1,al
.ENDIF
.ELSE
mov byte1,al
.ENDIF
mov al,el2
mov byte2,al
mov al,el3
mov byte3,al

mov ax,xyp
mov byte4,al
mov byte5,ah
xor eax,eax
mov data,al
mov al,numline
invoke SetLine,eax
inc numline

invoke GetDC,hwnd
mov hdc,eax
xor eax,eax
mov al,byte1
invoke DrawLine,eax,1
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ENDIF

.ELSEIF umsg==WM_MOUSEMOVE

mov al,data
.IF al==1
;mov al,setupline
;.IF al!=0
invoke GetDC,hwnd
mov hdc,eax
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
xor eax,eax
mov al,el2
xor ebx,ebx
mov bl,el3
shl ax,2
shl bx,2
invoke MoveToEx,hdc,eax,ebx,0
invoke GetPos,lparam
invoke LineTo,hdc,eax,ebx
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke ReleaseDC,hwnd,hdc
;.ENDIF
.ELSE
;mov al,setupelement
;.IF al!=0
mov al,element
.IF al>=1
.IF al<=6
invoke GetDC,hwnd
mov hdc,eax
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke GetPos,lparam
invoke DrawIcon,hdc,eax,ebx,hicon
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke ReleaseDC,hwnd,hdc;.ENDIF
.ENDIF
.ENDIF

.ENDIF
.ELSEIF umsg==WM_NCMOUSEMOVE

;mov al,setupelement
;.IF al!=0

mov al,element
.IF al!=8
mov al,data
.IF al==0
invoke GetDC,hwnd
mov hdc,eax
;invoke BitBlt,hdc2,0,0,1023,1023,memdc,0,0,SRCCOPY
;invoke RedrawWindow,hwnd,0,0,RDW_INVALIDATE
invoke BitBlt,hdc,0,0,1023,1023,memdc,0,0,SRCCOPY
invoke ReleaseDC,hwnd,hdc
.ENDIF
.ENDIF

;.ENDIF

.ELSEIF umsg==WM_CLOSE
exitprog:
mov al,exit
.IF al==0
mov al,1
mov exit,al
invoke MessageBox,hwnd,addr close1,addr close2,MB_YESNO
cmp eax,6
jnz next
invoke DestroyWindow,hwnd
next:
xor al,al
mov exit,al
.ENDIF
.ELSEIF umsg==WM_DESTROY
invoke PostQuitMessage,0
.ELSE
invoke DefWindowProc,hwnd,umsg,wparam,lparam
ret
.ENDIF
xor eax,eax
ret
WndProc endp

WndProc2 proc hwnd:dword,umsg:dword,wparam:dword,lparam:dword
.IF umsg==WM_INITDIALOG
mov eax,hwnd
mov hwnd2,eax

invoke LoadIcon,hinstance,10
invoke SendMessageA,hwnd,WM_SETICON,0,eax
invoke CreateWindowExA,0,addr static,addr ecursor,WS_CHILD,88,0,100,20,hwnd,0,0,0
mov hstatic,eax
invoke ShowWindow,hstatic,1

invoke IconButton,hwnd,2,1
invoke IconButton,hwnd,38,2
invoke IconButton,hwnd,74,3
invoke IconButton,hwnd,110,4
invoke IconButton,hwnd,146,5
invoke IconButton,hwnd,182,6
invoke IconButton,hwnd,218,7
invoke IconButton,hwnd,254,8

.ELSEIF umsg==WM_COMMAND
xor al,al
mov data,al
mov eax,wparam
push eax
add eax,99
invoke LoadIconArray,eax
mov hicon,eax
pop eax
mov element,al
dec eax
mov edx,offset eor
mov bl,10
mul bl
add eax,edx
invoke SetWindowTextA,hstatic,eax
.IF wparam==8
invoke CmpElement
.ENDIF
.ELSEIF umsg==WM_CLOSE
mov al,exit
.IF al==0
mov al,1
mov exit,al
invoke MessageBox,hwnd,addr close1,addr close2,MB_YESNO
cmp eax,6
jnz next
invoke DestroyWindow,hwnd3
invoke EndDialog,hwnd,0
next:
xor al,al
mov exit,al
.ENDIF
.ENDIF
xor eax,eax
ret
WndProc2 endp

IconButton proc hParent:DWORD,a:DWORD,ID:DWORD
invoke CreateWindowEx,0,ADDR butn,ADDR empty,WS_CHILD or WS_VISIBLE or BS_ICON,a,20,36,36,hParent,ID,hinstance,NULL
mov hbut,eax
mov eax,99
add eax,ID
invoke LoadIcon,hinstance,eax
mov edx,eax
mov ebx,ID
dec bl
mov eax,4
mul bl
mov bl,al
add ebx,offset arrayicon
mov [ebx],edx
invoke SendMessage,hbut,BM_SETIMAGE,1,edx
ret
IconButton endp

GetPos proc lparam:DWORD
xor eax,eax
mov ebx,lparam
mov ax,bx
and ax,1020
shr ebx,16
and bx,1020
ret
GetPos endp

SetLine proc enumber:DWORD
mov eax,enumber
mov bx,5
mul bx
add eax,offset cline
mov ebx,eax
mov esi,offset byte1

mov al,[esi]
mov [ebx],al
inc ebx
inc esi
mov eax,[esi]
mov [ebx],eax

ret
SetLine endp

GetLine proc lnnumber:DWORD
mov eax,lnnumber
mov bx,5
mul bx
add eax,offset cline
mov ebx,eax
mov esi,offset byte1

xor eax,eax
mov al,[ebx]
mov [esi],al
inc ebx
inc esi
mov edx,[ebx]
mov [esi],edx
ret
GetLine endp

SetElement proc elnumber:DWORD
mov eax,elnumber
mov bx,6
mul bx
add eax,offset celement
mov ebx,eax
mov esi,offset byte1
mov ax,[esi]
mov [ebx],ax
add ebx,2
add esi,2
mov eax,[esi]
mov [ebx],eax
ret
SetElement endp

GetElement proc number:DWORD
mov eax,number
mov bx,6
mul bx
add eax,offset celement
mov ebx,eax
mov esi,offset byte1
mov ecx,6
lop2:
mov al,[ebx]
mov [esi],al
inc ebx
inc esi
loop lop2

xor eax,eax
mov al,byte1
ret
GetElement endp

CmpLine proc
;mov bl,byte1
sub al,xp
jnc next
xor al,al
next:
sub ah,yp
jnc next2
xor ah,ah
next2:
mov bh,el4
.IF bh>=4
.IF ax==0401h
mov el1,bl
xor bh,bh
mov el2,bh
;mov el3,bh
.ELSEIF ax==0407h
mov el3,bl
xor bh,bh
mov el2,bh
.ENDIF
.ELSE
.IF ax==0201h
mov el1,bl
.ELSEIF ax==0601h
mov el2,bl
.ELSEIF ax==0407h
mov el3,bl
.ENDIF
.ENDIF
ret
CmpLine endp

DrawLine proc aline:DWORD,color:DWORD
xor cx,cx
mov cl,numline
.IF cl!=0
push cx
mov ebx,color
and bl,3
.IF bl==1
invoke DeleteObject,hpen
invoke CreatePen,0,1,Green
mov hpen,eax
invoke SelectObject,memdc,hpen
.ELSE
invoke DeleteObject,hpen
invoke CreatePen,0,1,White
mov hpen,eax
invoke SelectObject,memdc,hpen
.ENDIF
pop cx
lop3:
push cx
and ecx,255
dec cl
invoke GetLine,ecx
mov ebx,color
and bl,4
.IF bl==0
cmp eax,aline
jnz breake
.ENDIF
mov ebx,color
and bl,3
.IF bl==0
invoke GetLevelLine,eax
.IF al==1
mov eax,04080FFh
.ELSE
xor eax,eax
.ENDIF
push eax
invoke DeleteObject,hpen
pop eax
invoke CreatePen,0,1,eax
mov hpen,eax
invoke SelectObject,memdc,hpen
.ENDIF
xor eax,eax
mov al,byte2
xor ebx,ebx
mov bl,byte3
shl ax,2
shl bx,2
invoke MoveToEx,memdc,eax,ebx,0
xor eax,eax
mov al,byte4
xor ebx,ebx
mov bl,byte5
shl ax,2
shl bx,2
invoke LineTo,memdc,eax,ebx
breake:
pop cx
dec cl
jnz lop3
.ENDIF
ret
DrawLine endp

CmpElement proc
mov ecx,0
mov cl,numelement
.IF cl!=0
lop10:
push ecx
dec cl
invoke GetElement,ecx
xor ecx,ecx
mov cl,numline
.IF cl!=0
mov al,byte5
mov xp,al
mov al,byte6
mov yp,al
mov al,byte1
mov el4,al

xor al,al
mov el1,al
mov el2,al
mov el3,al
lop4:
push ecx
dec cl
invoke GetLine,ecx
mov bl,byte1
mov al,byte2
mov ah,byte3
invoke CmpLine
mov al,byte4
mov ah,byte5
invoke CmpLine
pop ecx
loop lop4

mov al,el1
mov byte2,al
mov al,el2
mov byte3,al
mov al,el3
mov byte4,al

mov al,el4
mov byte1,al
mov al,xp
mov byte5,al
mov al,yp
mov byte6,al

.ENDIF
pop ecx
push ecx
dec cl
invoke SetElement,ecx
pop ecx
dec cl
jnz lop10
.ENDIF
ret
CmpElement endp

GetLevelLine proc aline:DWORD
mov ecx,aline
xor ebx,ebx
mov bl,cl
shr bl,3
add ebx,offset levelline
mov al,[ebx]
and cl,7
shr al,cl
and eax,1
ret
GetLevelLine endp

SetLevelLine proc aline:DWORD,level:DWORD
mov ecx,aline
xor ebx,ebx
mov bl,cl
shr bl,3
add ebx,offset levelline
mov eax,level
.IF al==1
and cl,7
shl al,cl
or [ebx],al
.ELSE
mov al,1
and cl,7
shl al,cl
not al
and [ebx],al
.ENDIF
ret
SetLevelLine endp

RedrawElement proc
mov ecx,0
mov cl,numelement
.IF cl!=0
lop10:
push ecx
dec cl
invoke GetElement,ecx
mov eax,99
add al,byte1
invoke LoadIconArray,eax
mov ecx,0
mov cl,byte5
xor ebx,ebx
mov bl,byte6
shl cx,2
shl bx,2
invoke DrawIcon,memdc,ecx,ebx,eax
pop ecx
loop lop10
.ENDIF
ret
RedrawElement endp

LoadIconArray proc desicon:DWORD
mov eax,4
mov ebx,desicon
sub ebx,100
mul bl
mov ebx,eax
add ebx,offset arrayicon
mov eax,[ebx]
ret
LoadIconArray endp
end begin