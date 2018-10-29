; #########################################################################



.data
MainHDC dd 0
OpenDC dd 0

PixFrm PIXELFORMATDESCRIPTOR <>


Position dd 0.0,0.0,-5.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Top1 dd -1.0,-1.0,0.0
Top2 dd 1.0,-1.0,0.0
Top3 dd 0.0,1.0,0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Float45 dq 45.0
Float3 dq 3.0
Float9 dq 9.0
Float1 dq 1.0

.code
ResizeObject PROTO :DWORD,:DWORD
DrawScene PROTO 
Init PROTO :DWORD

; ######################################################################### 

ResizeObject PROC ParentW:DWORD,ParentH:DWORD
invoke glViewport,0,0,ParentW,ParentH
invoke glMatrixMode,GL_PROJECTION
invoke glLoadIdentity
invoke gluPerspective,DWORD PTR Float45,DWORD PTR Float45+4,DWORD PTR Float1,DWORD PTR Float1+4,DWORD PTR Float3,DWORD PTR Float3+4,DWORD PTR Float9,DWORD PTR Float9+4
invoke glMatrixMode,GL_MODELVIEW
invoke glLoadIdentity
ret
ResizeObject ENDP

; #########################################################################

DrawScene PROC 


invoke glClear,GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT 

invoke glNewList,1,GL_COMPILE_AND_EXECUTE 

invoke glBegin,GL_TRIANGLES
lea eax,Top1
invoke glVertex3f,[eax],[eax+4],[eax+8]
lea eax,Top2
invoke glVertex3f,[eax],[eax+4],[eax+8]
lea eax,Top3
invoke glVertex3f,[eax],[eax+4],[eax+8]

invoke glEnd

invoke glEndList


invoke glPushMatrix
lea eax,Position

mov ecx,[eax]
mov ebx,[eax+4]
mov eax,[eax+8]
invoke glTranslatef,ecx,ebx,eax
invoke glCallList,1


invoke glPopMatrix
invoke SwapBuffers,MainHDC 
ret
DrawScene ENDP
; #########################################################################
Init proc hWn:DWORD
LOCAL WINRect:RECT
LOCAL PixFormat:DWORD



invoke GetDC,hWn
mov MainHDC,eax
mov ax,SIZEOF PixFrm
mov PixFrm.nSize,ax
mov PixFrm.nVersion,1
mov PixFrm.dwFlags,PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER
mov PixFrm.dwLayerMask,PFD_MAIN_PLANE
mov PixFrm.iPixelType,PFD_TYPE_RGBA
mov PixFrm.cColorBits,8
mov PixFrm.cDepthBits,16
mov PixFrm.cAccumBits,0
mov PixFrm.cStencilBits,0
invoke ChoosePixelFormat,MainHDC,ADDR PixFrm
mov PixFormat,eax
invoke SetPixelFormat,MainHDC,PixFormat,ADDR PixFrm
or eax,eax
jz Fail
invoke wglCreateContext,MainHDC
mov OpenDC,eax
invoke wglMakeCurrent,MainHDC,OpenDC
invoke GetClientRect,hWn,ADDR WINRect


invoke MessageBox,hWn,SADD("Устройство успешно инициализировано"),SADD("Отчет об инициализации"),MB_OK
jmp abrt
Fail:
invoke MessageBox,hWn,SADD("OpenGL инициализировть не удалось"),SADD("Отчет об инициализации"),MB_OK

abrt:

return 0

Init endp
; ########################################################