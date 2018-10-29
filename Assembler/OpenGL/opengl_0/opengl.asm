.386
.model flat,stdcall
option casemap:none 
include opengl.inc



; #########################################################################
.code

start:
invoke GetModuleHandle, NULL
mov hInstance, eax

invoke GetCommandLine
mov CommandLine, eax


invoke WinMain,hInstance,NULL,CommandLine,SW_SHOWDEFAULT
invoke ExitProcess,eax

; #########################################################################

WinMain proc hInst :DWORD,
hPrevInst :DWORD,
CmdLine :DWORD,
CmdShow :DWORD


LOCAL msg :MSG
LOCAL Wwd :DWORD
LOCAL Wht :DWORD
LOCAL Wtx :DWORD
LOCAL Wty :DWORD


invoke LoadIcon,hInst,500 
mov hIcon, eax
invoke LoadCursor,NULL,IDC_ARROW
mov hCursor, eax
invoke RegisterWinClass,ADDR WndProc,ADDR szClassName,
hIcon,hCursor,COLOR_BTNFACE+1


mov Wwd, 500
mov Wht, 500

invoke GetSystemMetrics,SM_CXSCREEN
invoke TopXY,Wwd,eax
mov Wtx, eax

invoke GetSystemMetrics,SM_CYSCREEN
invoke TopXY,Wht,eax
mov Wty, eax

invoke CreateWindowEx,WS_EX_LEFT,
ADDR szClassName,
ADDR szDisplayName,
WS_OVERLAPPEDWINDOW,
Wtx,Wty,Wwd,Wht,
NULL,NULL,
hInst,NULL
mov hWnd,eax

invoke LoadMenu,hInst,600 
invoke SetMenu,hWnd,eax



invoke ShowWindow,hWnd,SW_SHOWNORMAL
invoke UpdateWindow,hWnd



StartLoop:
invoke GetMessage,ADDR msg,NULL,0,0
cmp eax, 0
je ExitLoop
invoke DrawScene
invoke TranslateMessage, ADDR msg
invoke DispatchMessage, ADDR msg
jmp StartLoop
ExitLoop:

return msg.wParam

WinMain endp

; #########################################################################

WndProc PROC hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL rc:RECT
.if uMsg == WM_COMMAND


.if wParam == 1000
invoke SendMessage,hWin,WM_SYSCOMMAND,SC_CLOSE,NULL




.endif
.elseif uMsg == WM_CREATE

invoke Init,hWin

.elseif uMsg == WM_SIZE
invoke GetClientRect,hWin,ADDR rc



return 0

.elseif uMsg == WM_CLOSE
mov eax,OpenDC
cmp eax,0
jz outDC

invoke wglDeleteContext,OpenDC

outDC: 
invoke ReleaseDC,hWin,MainHDC
invoke DestroyWindow,hWin
return 0
.elseif uMsg == WM_DESTROY
invoke PostQuitMessage,NULL
return 0 
.endif


invoke DefWindowProc,hWin,uMsg,wParam,lParam
ret
WndProc ENDP

; ########################################################################

TopXY proc wDim:DWORD, sDim:DWORD


shr sDim, 1 ; divide screen dimension by 2
shr wDim, 1 ; divide window dimension by 2
mov eax, wDim ; copy window dimension into eax
sub sDim, eax ; sub half win dimension from half screen dimension

return sDim

TopXY endp

; #########################################################################

RegisterWinClass proc lpWndProc:DWORD, lpClassName:DWORD,
Icon:DWORD, Cursor:DWORD, bColor:DWORD

LOCAL wc:WNDCLASSEX

mov wc.cbSize, sizeof WNDCLASSEX
mov wc.style, CS_VREDRAW or \
CS_HREDRAW
m2m wc.lpfnWndProc, lpWndProc
mov wc.cbClsExtra, NULL
mov wc.cbWndExtra, NULL
m2m wc.hInstance, hInstance
m2m wc.hbrBackground, bColor
mov wc.lpszMenuName, NULL
m2m wc.lpszClassName, lpClassName
m2m wc.hIcon, Icon
m2m wc.hCursor, Cursor

m2m wc.hIconSm, Icon

invoke RegisterClassEx, ADDR wc

ret

RegisterWinClass endp

; ########################################################################


end start