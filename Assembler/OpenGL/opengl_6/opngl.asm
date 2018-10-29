; #########################################################################

.data
MainHDC dd 0
OpenDC dd 0

PixFrm PIXELFORMATDESCRIPTOR <>

Position1 dd 0.0,0.0,-5.0


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
LightPosition	dd	-2.0,0.0,2.0,0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
red 	dd 1.0,0.0,0.0
yellow	dd 1.0,1.0,0.0
green 	dd 0.0,1.0,0.0
blue 	dd 0.0,0.0,1.0
white	dd 1.0,1.0,1.0
orange	dd 1.0,0.4,0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
dFloat1   dd  1.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
RotSpeed	dd	-0.5,0.8,-0.4
RotAngles	dd	0.1,0.5,0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Float45 dq 45.0
Float3 dq 3.0
Float9 dq 9.0
Float1 dq 1.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Top1 dd 0.0,0.0,0.0
Top2 dd 1.0,0.0,0.0
Top3 dd 1.0,1.0,0.0
Top4 dd 0.0,1.0,0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
hPic    dd 0
ColorRGB   dd   0.1,0.5,0.5,0.5
xPic    dd 0
yPic    dd 0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
ResizeObject PROTO :DWORD,:DWORD
DrawScene PROTO 
Init PROTO :DWORD
CreateObjects		PROTO	:DWORD,:DWORD
SolidRect		PROTO    :DWORD
LoadTexture		PROTO
Load_Image		PROTO	
CreateLight		PROTO 
Rotate			PROTO    :DWORD,:DWORD,:DWORD,:DWORD
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
CreateObjects		PROC	ParentW:DWORD,ParentH:DWORD

invoke LoadTexture

invoke SolidRect,1

invoke glMatrixMode,GL_PROJECTION
ret
CreateObjects		ENDP
; #########################################################################

DrawScene		PROC 
invoke CreateLight
	invoke	glClear,GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT               	
lea eax,ColorRGB
                        invoke	glClearColor,[eax],[eax+4],[eax+8],[eax+12]	

rotate 1,ADDR Position1,ADDR RotSpeed,ADDR RotAngles

invoke	SwapBuffers,MainHDC			
			ret

DrawScene		ENDP
; #########################################################################
CreateLight    PROC
invoke	glLightfv,GL_LIGHT0,GL_POSITION,ADDR  LightPosition
			invoke	glEnable,GL_LIGHT0

ret
CreateLight    ENDP
; #########################################################################

SolidRect proc ListNumber:DWORD

invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 


	

invoke glEnable,GL_TEXTURE_2D	
invoke glBegin,GL_QUADS

top(Top1)
toptx(Top1)

top(Top2)
toptx(Top2)
                        
top(Top3)
toptx(Top3)
                     
top(Top4)
 toptx(Top4)

                       
		invoke glEnd
invoke	glEndList
invoke glDisable,GL_TEXTURE_2D			

	ret
SolidRect endp
; #########################################################################
LoadTexture    PROC
LOCAL hTxtr:DWORD

invoke Load_Image	
mov hPic,eax

invoke glGenTextures,1,ADDR hTxtr
invoke glBindTexture,GL_TEXTURE_2D,hTxtr
invoke glTexEnvi,GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE
invoke glTexParameteri,GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR 
invoke glTexParameteri,GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR
invoke glPixelStorei,GL_UNPACK_ALIGNMENT, 1


invoke gluBuild2DMipmaps,GL_TEXTURE_2D,3,xPic,yPic,GL_RGB,GL_UNSIGNED_BYTE,hPic    

ret
LoadTexture	ENDP


; #########################################################################
Load_Image	proc 

LOCAL	 dwFileSize:DWORD, dwHighSize:DWORD, dwBytesRead:DWORD, hFile:DWORD,bmpheader:DWORD,Memory:DWORD
LOCAL  pBits:DWORD

	invoke	CreateFile, ADDR szFileName, GENERIC_READ, FILE_SHARE_READ, 0, \
			    OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, 0
	mov	hFile,eax

	invoke GetFileSize, hFile, ADDR dwHighSize
	mov dwFileSize, eax

	invoke GlobalAlloc,GMEM_MOVEABLE or GMEM_ZEROINIT, dwFileSize	

        mov  Memory,eax			
	
        invoke GlobalLock,Memory
        mov  bmpheader,eax				
	
	mov  ebx,bmpheader

	invoke ReadFile, hFile, bmpheader, dwFileSize, ADDR dwBytesRead, 0
	
	invoke CloseHandle, hFile

	mov	eax, dwBytesRead
    	
	mov	edx,BITMAPFILEHEADER.bfSize[ebx]	
        

	mov	eax, sizeof BITMAPFILEHEADER	
	add	eax,bmpheader		
				
	mov	esi,eax				
	    
	mov     eax,BITMAPFILEHEADER.bfOffBits[ebx];
	add	eax,bmpheader

	mov	pBits,eax		
	
	m2m xPic, BITMAPINFO.bmiHeader.biWidth[esi]
	m2m yPic, BITMAPINFO.bmiHeader.biHeight[esi]

 	return pBits

Load_Image	endp
;#####################################################
Rotate		PROC	ListNumber:DWORD,ZYXPosition:DWORD,ZYXRotations:DWORD,ZYXAngles:DWORD
			
			mov	eax,ZYXPosition
			
			
			invoke	glTranslatef,[eax],[eax+4],[eax+8]

	    		mov	eax,ZYXAngles			
	    		mov	ebx,ZYXRotations
	    		fld	DWORD PTR [eax]
	    		fadd	DWORD PTR [ebx]
	    		fstp	DWORD PTR [eax]
	    		invoke	glRotatef,[eax],dFloat1,dFloat1,dFloat1
	    		
			invoke	glCallList,ListNumber
			ret
Rotate		ENDP


; ########################################################################
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

invoke	CreateObjects,WINRect.right,WINRect.bottom
invoke	glEnable,GL_DEPTH_TEST
			invoke	glEnable,GL_LIGHTING
					
			invoke	glShadeModel, GL_SMOOTH
			invoke	glEnable,GL_NORMALIZE
			invoke glEnable,GL_COLOR_MATERIAL
jmp abrt
Fail:
invoke MessageBox,hWn,SADD("OpenGL инициализировaть не удалось"),SADD("Отчет об инициализации"),MB_OK

abrt:

return 0

Init endp
; ########################################################