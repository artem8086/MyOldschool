; #########################################################################

.data
MainHDC dd 0
OpenDC dd 0

PixFrm PIXELFORMATDESCRIPTOR <>

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SolarPosition 		dd 	0.0,0.0,-7.0,0.0
SolarRadius		dq	0.15
SolarSpeed		dd     	1.3
SolarAngles		dd      0.3

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MercuryPosition 	dd 	0.3,0.0,0.0,0.0
MercuryRadius		dq	0.01
MercurySpeed		dd      0.05
MercuryAngles		dd      0.05
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
VenusPosition 		dd 	0.5,0.0,0.0,0.0
VenusRadius		dq	0.03
VenusSpeed		dd      -0.5
VenusAngles		dd      -0.5
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EarthPosition 		dd 	0.8,0.0,0.0,0.0
EarthRadius		dq	0.04
EarthSpeed		dd      -0.7
EarthAngles		dd      -0.8
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MoonPosition 		dd 	0.1,0.0,0.0,0.0
MoonRadius		dq	0.01
MoonSpeed		dd      3.0
MoonAngles		dd      3.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MarsPosition 		dd 	1.1,0.0,0.0,0.0
MarsRadius		dq	0.02
MarsSpeed		dd      -0.9
MarsAngles		dd      -1.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
JupiterPosition 	dd 	1.7,0.0,0.0,0.0
JupiterRadius		dq	0.1
JupiterSpeed		dd      -1.0
JupiterAngles		dd      -1.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SaturnPosition 	dd 	2.1,0.0,0.0,0.0
SaturnRadius		dq	0.09
SaturnSpeed		dd      -1.1
SaturnAngles		dd      -1.1
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SaturnDiskPosition 	dd 	0.0,0.0,0.0,90.0
SaturnDiskRadius	dq	0.1,0.2
SaturnDiskSpeed		dd      -0.0
SaturnDiskAngles	dd      0.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UranPosition 	dd 	2.4,0.0,0.0,0.0
UranRadius	dq	0.07
UranSpeed	dd      -1.15
UranAngles	dd      -1.9
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
NeptunPosition 	dd 	2.8,0.0,0.0,0.0
NeptunRadius	dq	0.05
NeptunSpeed	dd      -1.2
NeptunAngles	dd      -2.5
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
IoPosition 	dd 	0.1,0.0,0.0,0.0
IoRadius	dq	0.01
IoSpeed		dd      -1.2
IoAngles	dd      2.5
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EuropePosition 	dd 	-0.05,-0.1,0.0,0.0
EuropeRadius	dq	0.01
EuropeSpeed	dd      3.2
EuropeAngles	dd      2.5
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
GanimedPosition 	dd 	0.05,-0.05,0.0,0.0
GanimedRadius	dq	0.01
GanimedSpeed	dd      1.2
GanimedAngles	dd      -4.5
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
KallistoPosition 	dd 	-0.05,0.05,0.0,0.0
KallistoRadius	dq	0.01
KallistoSpeed	dd      0.8
KallistoAngles	dd      5.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
LightPosition	dd	-2.0,0.0,0.0,1.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SolarColor	dd 1.0,1.0,0.5
MercuryColor	dd 0.7,0.7,0.6
VenusColor	dd 0.8,0.8,0.7
EarthColor	dd 0.5,0.7,0.9
MoonColor	dd 0.6,0.6,0.5
MarsColor	dd 0.9,0.4,0.2
JupiterColor	dd 0.9,0.5,0.1 
SaturnColor	dd 0.3,0.5,0.8
SaturnDiskColor	dd 0.9,0.8,0.3
UranColor	dd 0.3,0.5,0.3
NeptunColor	dd 0.5,0.7,0.7    
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
dFloat0   dd  0.0
dFloat1   dd  1.0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
RotSpeed	dd	0.0,0.0,0.0
RotAngles	dd	0.5,-0.5,0.5
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
invoke SolidSphere,1,ADDR SolarColor,ADDR SolarRadius,24
invoke SolidSphere,2,ADDR MercuryColor,ADDR MercuryRadius,12
invoke SolidSphere,3,ADDR VenusColor,ADDR VenusRadius,12
invoke SolidSphere,4,ADDR EarthColor,ADDR EarthRadius,12
invoke SolidSphere,5,ADDR MoonColor,ADDR MoonRadius,12
invoke SolidSphere,6,ADDR MarsColor,ADDR MarsRadius,12
invoke SolidSphere,7,ADDR JupiterColor,ADDR JupiterRadius,12
invoke SolidSphere,8,ADDR SaturnColor,ADDR SaturnRadius,12
invoke SolidDisk,9,ADDR SaturnDiskColor,ADDR SaturnDiskRadius,12
invoke SolidSphere,10,ADDR UranColor,ADDR UranRadius,12
invoke SolidSphere,11,ADDR NeptunColor,ADDR NeptunRadius,12

invoke SolidSphere,12,ADDR MoonColor,ADDR MoonRadius,12
invoke SolidSphere,13,ADDR MoonColor,ADDR MoonRadius,12
invoke SolidSphere,14,ADDR MoonColor,ADDR MoonRadius,12
invoke SolidSphere,15,ADDR MoonColor,ADDR MoonRadius,12

invoke glMatrixMode,GL_PROJECTION
ret
CreateObjects		ENDP
; #########################################################################

DrawScene		PROC 
invoke CreateLight
	invoke	glClear,GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT               	
	

invoke	glPushMatrix
invoke Rotate,1,ADDR SolarPosition,ADDR SolarSpeed,ADDR SolarAngles


invoke	glPushMatrix
invoke Rotate,2,ADDR MercuryPosition,ADDR MercurySpeed,ADDR MercuryAngles
invoke	glPopMatrix
invoke	glPushMatrix
invoke Rotate,3,ADDR VenusPosition,ADDR VenusSpeed,ADDR VenusAngles		
invoke	glPopMatrix
invoke	glPushMatrix
invoke Rotate,4,ADDR  EarthPosition,ADDR EarthSpeed,ADDR EarthAngles
invoke Rotate,5,ADDR  MoonPosition,ADDR MoonSpeed,ADDR MoonAngles
invoke	glPopMatrix
invoke	glPushMatrix
invoke Rotate,6,ADDR  MarsPosition,ADDR MarsSpeed,ADDR MarsAngles
invoke	glPopMatrix
invoke	glPushMatrix
invoke	glPushMatrix
invoke	glPushMatrix

invoke Rotate,7,ADDR  JupiterPosition,ADDR JupiterSpeed,ADDR JupiterAngles

invoke	glPushMatrix

invoke Rotate,12,ADDR  IoPosition,ADDR IoSpeed,ADDR IoAngles
invoke	glPopMatrix


invoke Rotate,13,ADDR  EuropePosition,ADDR EuropeSpeed,ADDR EuropeAngles


invoke Rotate,14,ADDR  GanimedPosition,ADDR GanimedSpeed,ADDR GanimedAngles

invoke Rotate,15,ADDR  KallistoPosition,ADDR KallistoSpeed,ADDR KallistoAngles
invoke	glPopMatrix
invoke	glPopMatrix

invoke	glPushMatrix
invoke Rotate,8,ADDR  SaturnPosition,ADDR SaturnSpeed,ADDR SaturnAngles
invoke Rotate,9,ADDR  SaturnDiskPosition,ADDR SaturnDiskSpeed,ADDR SaturnDiskAngles


invoke	glPopMatrix
invoke	glPushMatrix
invoke Rotate,10,ADDR  UranPosition,ADDR UranSpeed,ADDR UranAngles
invoke	glPopMatrix
invoke	glPushMatrix
invoke Rotate,11,ADDR  NeptunPosition,ADDR NeptunSpeed,ADDR NeptunAngles
invoke	glPopMatrix
invoke	glPopMatrix
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

	    		mov	eax,ZYXAngles			
	    		mov	ebx,ZYXRotations
	    		fld	DWORD PTR [eax]
	    		fadd	DWORD PTR [ebx]
	    		fstp	DWORD PTR [eax]
	    		invoke	glRotatef,[eax],dFloat0,dFloat0,dFloat1
			mov	eax,ZYXPosition
			invoke	glRotatef,[eax+12],dFloat0,dFloat1,dFloat1
	    		mov	eax,ZYXPosition
			invoke	glTranslatef,[eax],[eax+4],[eax+8]
			
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