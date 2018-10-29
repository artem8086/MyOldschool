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
LOCAL hDesktopWnd :DWORD
LOCAL hDesktopDC :DWORD


invoke GetDesktopWindow
mov hDesktopWnd,eax
	
invoke  GetDC,hDesktopWnd
mov hDesktopDC ,eax

invoke GetDeviceCaps,hDesktopDC, HORZRES
mov Wwd,eax

invoke GetDeviceCaps,hDesktopDC, VERTRES
mov Wht,eax

invoke LoadIcon,hInst,500 
mov hIcon, eax

invoke RegisterWinClass,ADDR WndProc,ADDR szClassName,
hIcon,hCursor,COLOR_BTNFACE+1

invoke CreateWindowEx,WS_EX_LEFT,
ADDR szClassName,
ADDR szDisplayName,
WS_POPUP or  WS_CLIPCHILDREN or WS_CLIPSIBLINGS,
0,0,Wwd,Wht,
NULL,NULL,
hInst,NULL
mov hWnd,eax

invoke ShowWindow,hWnd,SW_SHOWNORMAL
invoke UpdateWindow,hWnd

invoke ShowCursor,FALSE

 StartLoop:
invoke	PeekMessage,ADDR msg,0,0,0,PM_NOREMOVE
			or	eax,eax
			jz	NoMsg
			invoke	GetMessage,ADDR msg,NULL,0,0
			or	eax,eax
			jz	ExitLoop
			invoke	TranslateMessage,ADDR msg
			invoke	DispatchMessage,ADDR msg
			jmp	StartLoop
NoMsg:			
			invoke	DrawScene
			invoke Sleep,2
			jmp	StartLoop
ExitLoop:		

return msg.wParam

WinMain endp

; #########################################################################

WndProc PROC hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL rc:RECT
.if uMsg ==WM_KEYDOWN or WM_KEYUP
        .if wParam == 27
     invoke SendMessage,hWin,WM_SYSCOMMAND,SC_CLOSE,NULL
        .endif
.elseif uMsg == WM_CREATE

invoke Init,hWin

.elseif uMsg == WM_SIZE
invoke GetClientRect,hWin,ADDR rc
invoke	ResizeObject,rc.right,rc.bottom
				


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