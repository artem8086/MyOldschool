; #########################################################################



.data
MainHDC dd 0
OpenDC dd 0
PixFrm PIXELFORMATDESCRIPTOR <>

.code

DrawScene PROTO 
Init PROTO :DWORD


; #########################################################################

DrawScene PROC 
invoke glClear,GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT

invoke glBegin,GL_POLYGON

invoke glVertex3i,1,1,0
invoke glVertex3i,-1,1,0
invoke glVertex3i,1,-1,0

invoke glEnd

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


invoke MessageBox,hWn,SADD("OpenGl успешно инициализированa"),SADD("Отчет об инициализации"),MB_OK
jmp abort
Fail:
invoke MessageBox,hWn,SADD("OpenGl инициализировать не удалось"),SADD("Отчет об инициализации"),MB_OK

abort:

return 0

Init endp
; #######################################################################