; #########################################################################



.data
MainHDC dd 0
OpenDC dd 0

PixFrm PIXELFORMATDESCRIPTOR <>

RotSpeed	dd	-1.0,0.1,-1.4
RotAngles	dd	0.0,0.0,0.0

Position dd 0.0,0.0,-5.0

DiskRadius		dq	1.0,1.5
CylinderRadius		dq	1.0,0.8,1.2

orange	dd 1.0,0.4,0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Top1 dd -1.0,-1.0,0.0
Top2 dd 1.0,-1.0,0.0
Top3 dd 1.0,1.0,0.0
Top4 dd -1.0,1.0,0.0

Top5 dd -1.0,-1.0,2.0
Top6 dd 1.0,-1.0,2.0
Top7 dd 1.0,1.0,2.0
Top8 dd -1.0,1.0,2.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
LightPosition	dd	-2.0,0.0,2.0,0.0

dFloat1   dd  1.0

Float45 dq 45.0
Float3 dq 3.0
Float9 dq 9.0
Float1 dq 1.0

.code
DrawScene PROTO 
Init PROTO :DWORD
Rotate			PROTO    :DWORD,:DWORD,:DWORD,:DWORD
CreateObjects		PROTO	:DWORD,:DWORD

SolidSphere		PROTO    :DWORD,:DWORD,:DWORD
SolidDisk		PROTO    :DWORD,:DWORD,:DWORD
SolidCylinder		PROTO    :DWORD,:DWORD,:DWORD
WireCylinder		PROTO    :DWORD,:DWORD,:DWORD,:DWORD
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

CreateObjects PROC ParentW:DWORD,ParentH:DWORD

invoke	glNewList,1,GL_COMPILE_AND_EXECUTE
invoke SolidCylinder,ADDR orange,ADDR CylinderRadius,24
invoke SolidDisk,ADDR orange,ADDR DiskRadius,24
invoke	glEndList

invoke glMatrixMode,GL_PROJECTION
ret
CreateObjects ENDP

CreateLight    PROC
invoke	glLightfv,GL_LIGHT0,GL_POSITION,ADDR  LightPosition
invoke	glEnable,GL_LIGHT0
ret
CreateLight    ENDP


DrawScene PROC 

invoke CreateLight
invoke glClear,GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT 

rotate 1,ADDR Position,ADDR RotSpeed,ADDR RotAngles
;put2scene 1,Position
invoke glColor3ub,255,255,255
invoke glBegin,GL_POLYGON

invoke glVertex3i,1,1,1
invoke glVertex3i,-1,1,1
invoke glVertex3i,-1,-1,1
invoke glVertex3i,1,-1,1

invoke glEnd

invoke SwapBuffers,MainHDC 
ret
DrawScene ENDP

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
invoke MessageBox,hWn,SADD("OpenGL инициализировть не удалось"),SADD("Отчет об инициализации"),MB_OK

abrt:

return 0

Init endp

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

SolidCylinder		PROC	Color:DWORD,Radius:DWORD,Parts:DWORD
LOCAL	hCylinder:DWORD
;invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
invoke	gluNewQuadric
mov	hCylinder,eax
invoke	gluQuadricDrawStyle,hCylinder,GLU_FILL
invoke	gluQuadricNormals,hCylinder,GL_SMOOTH
invoke glColor3fv,Color
mov	eax,Radius
invoke	gluCylinder,hCylinder,[eax],[eax+4],[eax+8],[eax+12],[eax+16],[eax+20],Parts,Parts

;invoke	glEndList
mov	eax,hCylinder
ret
SolidCylinder		ENDP

; #########################################################################

SolidSphere		PROC	Color:DWORD,Radius:DWORD,Parts:DWORD
LOCAL	hSphere:DWORD
;invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
invoke	gluNewQuadric
mov	hSphere,eax
invoke	gluQuadricDrawStyle,hSphere,GL_FILL
invoke	gluQuadricNormals,hSphere,GL_SMOOTH
invoke glColor3fv,Color			
mov	eax,Radius
invoke	gluSphere,hSphere,[eax],[eax+4],Parts,Parts
;invoke	glEndList
mov	eax,hSphere
ret
SolidSphere		ENDP
; #########################################################################

SolidDisk		PROC	Color:DWORD,Radius:DWORD,Parts:DWORD
LOCAL	hDisk:DWORD
;invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
invoke	gluNewQuadric
mov	hDisk,eax
invoke	gluQuadricDrawStyle,hDisk,GLU_FILL
invoke	gluQuadricNormals,hDisk,GL_SMOOTH
invoke glColor3fv,Color
mov	eax,Radius
invoke	gluDisk,hDisk,[eax],[eax+4],[eax+8],[eax+12],Parts,Parts
;invoke	glEndList
mov	eax,hDisk
ret
SolidDisk		ENDP
