; #########################################################################

.data
MainHDC dd 0
OpenDC dd 0

PixFrm PIXELFORMATDESCRIPTOR <>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CentrePosition		dd	0.0,-1.0,-5.0
CentreAngles	dd       0.0,0.0,0.0
CentreSpeed	dd	-0.5,0.0,0.0


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SpherePosition1 	dd 	1.0,1.0,0.0
SphereRadius1		dq	0.6


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SpherePosition2 	dd 	0.0,0.7,0.0;
SphereRadius2		dq	0.4


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SpherePosition3 	dd 	0.0,0.5,0.0
SphereRadius3		dq	0.3

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SpherePosition4 	dd 	-0.2,0.05,0.0,0.0
SphereRadius4		dq	0.04
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SpherePosition5 	dd 	0.4,-0.0,0.0,0.0
SphereRadius5		dq	0.04
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
CylinderPosition 	dd 	0.0,0.0,0.0,0.0,1.0,0.0,0.0
CylinderRadius		dq	0.25,0.15,0.4

CylinderPosition1 	dd 	0.0,-0.2,-0.15,90.0
CylinderRadius1		dq	0.08,0.0,0.6

DiskPosition 	dd 	0.0,0.2,0.0,-90.0,1.0,0.0,0.0
DiskRadius		dq	0.2,0.5

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
LightPosition	dd	-2.0,0.0,2.0,0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
green	dd 0.0,1.0,0.4
orange	dd 1.0,0.4,0.0
blue	dd 0.0,0.4,1.0
white	dd 0.9,0.9,1.0
black	dd 0.2,0.2,0.2  
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
dFloat0   dd  0.0
dFloat1   dd  1.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
RotSpeed	dd	0.0,0.0,0.0
RotAngles	dd	0.5,0.5,0.5
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Float45 dq 45.0
Float3 dq 3.0
Float9 dq 18.0
Float1 dq 1.0

.code
ResizeObject PROTO :DWORD,:DWORD
DrawScene PROTO 
Init PROTO :DWORD
CreateObjects		PROTO	:DWORD,:DWORD
SolidCylinder		PROTO    :DWORD,:DWORD,:DWORD,:DWORD
WireCylinder		PROTO    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CreateLight		PROTO 
Rotate			PROTO    :DWORD,:DWORD,:DWORD,:DWORD
SolidSphere		PROTO    :DWORD,:DWORD,:DWORD,:DWORD
SolidDisk		PROTO    :DWORD,:DWORD,:DWORD,:DWORD

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
invoke SolidSphere,1,ADDR white,ADDR SphereRadius1,24
invoke SolidSphere,2,ADDR white,ADDR SphereRadius2,24
invoke SolidSphere,3,ADDR white,ADDR SphereRadius3,24

invoke SolidDisk,4,ADDR blue,ADDR DiskRadius,24
invoke SolidCylinder,5,ADDR blue,ADDR CylinderRadius,24

invoke SolidCylinder,6,ADDR orange,ADDR CylinderRadius1,12
invoke SolidSphere,7,ADDR black,ADDR SphereRadius4,24
invoke SolidSphere,8,ADDR black,ADDR SphereRadius4,24

invoke glMatrixMode,GL_PROJECTION
ret
CreateObjects		ENDP
; #########################################################################

DrawScene		PROC 
invoke CreateLight
	invoke	glClear,GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT               	
	

invoke	glPushMatrix
invoke Rotate,1,ADDR CentrePosition,ADDR CentreSpeed,ADDR CentreAngles

invoke Rotate,2,ADDR SpherePosition2,ADDR RotSpeed,ADDR RotAngles

invoke Rotate,3,ADDR SpherePosition3,ADDR RotSpeed,ADDR RotAngles

invoke Rotate,4,ADDR DiskPosition,ADDR RotSpeed,ADDR RotAngles

invoke Rotate,5,ADDR CylinderPosition,ADDR RotSpeed,ADDR RotAngles

invoke Rotate,6,ADDR CylinderPosition1,ADDR RotSpeed,ADDR RotAngles

invoke Rotate,7,ADDR SpherePosition4,ADDR RotSpeed,ADDR RotAngles

invoke Rotate,8,ADDR SpherePosition5,ADDR RotSpeed,ADDR RotAngles




invoke	glPopMatrix
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

SolidCylinder		PROC	ListNumber:DWORD,Color:DWORD,Radius:DWORD,Parts:DWORD
			LOCAL	hCylinder:DWORD
			invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
			invoke	gluNewQuadric
			mov	hCylinder,eax
			invoke	gluQuadricDrawStyle,hCylinder,GLU_FILL
			invoke	gluQuadricNormals,hCylinder,GL_SMOOTH
			invoke glColor3fv,Color
			mov	eax,Radius
			invoke	gluCylinder,hCylinder,[eax],[eax+4],[eax+8],[eax+12],[eax+16],[eax+20],Parts,Parts

			invoke	glEndList
			mov	eax,hCylinder
			ret
SolidCylinder		ENDP

; #########################################################################

SolidSphere		PROC	ListNumber:DWORD,Color:DWORD,Radius:DWORD,Parts:DWORD
			LOCAL	hSphere:DWORD
			invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
			invoke	gluNewQuadric
			mov	hSphere,eax
			invoke	gluQuadricDrawStyle,hSphere,GL_FILL
			invoke	gluQuadricNormals,hSphere,GL_SMOOTH
			invoke glColor3fv,Color			
			mov	eax,Radius
			invoke	gluSphere,hSphere,[eax],[eax+4],Parts,Parts
			invoke	glEndList
			mov	eax,hSphere
			ret
SolidSphere		ENDP
; #########################################################################

SolidDisk		PROC	ListNumber:DWORD,Color:DWORD,Radius:DWORD,Parts:DWORD
			LOCAL	hDisk:DWORD
			invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
			invoke	gluNewQuadric
			 mov	hDisk,eax
			invoke	gluQuadricDrawStyle,hDisk,GLU_FILL
			invoke	gluQuadricNormals,hDisk,GL_SMOOTH
			invoke glColor3fv,Color
			mov	eax,Radius
			invoke	gluDisk,hDisk,[eax],[eax+4],[eax+8],[eax+12],Parts,Parts
			invoke	glEndList
			mov	eax,hDisk
			ret
SolidDisk		ENDP

; #########################################################################
Rotate		PROC	ListNumber:DWORD,ZYXPosition:DWORD,ZYXRotations:DWORD,ZYXAngles:DWORD
			
			mov	eax,ZYXPosition
			invoke	glTranslatef,[eax],[eax+4],[eax+8]

			mov	eax,ZYXPosition
			
invoke	glRotatef,[eax+12],[eax+16],[eax+20],[eax+24]
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