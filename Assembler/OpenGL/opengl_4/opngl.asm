Z�; #E 

 .data
M ainHDC d d 0
Open
PixF rm PIXEL FORMATDE SCRIPTOR <>F $osi tion1C-1�.0,-5. O�P27
;>% 
R adius1  �dq  0.9� 
Float4Z54M3�3k�F99�hq�  X�code C esizeObj ect PROT O :DWORD,
Draw Scene
Ini�
Cr�eat#s		$	$SolidS�phere�   �
	Wire�
��F� FRLDC P�arentWD*CHC
invo ke glVie�wport,0@ �,�	MatrixM _,GL_ JJECTION��LoadId�ity�uPer�sp�iive,�h  PTR z45iO+4�1�3�3�9�9+4*�8MODELVIEWHK8ret�QENDPa1;?�s$qTC	�4Z;�V,�1,ADDR �wL,2�'V,2�1�6v#�?� �h� � � W� z�pC�^	�X	�glClearAS COLOR_BUFFE� IT or  VDEPTHG��xg 	
@ @
put2s��1b,��1		`'2&2�$Swap�Buff`],d��?� "$��#?#*
��C	ListN�umber�D�?gFtsc@		LO�CAL	h���,hNew!
,�
�-M PILE_AND _EXECUTE 3��u Quadricmov��,eaxb�$���tyle,$aFILL�Normals�SMOOTH�@�Col or3ub �25x5,0�:@! ,/�#,"&[ ],�Q +4]aRtsS �kEndqB���2"!*/!/ �
�h!�c�}!D��!!!g>l!!!�|!U_�LINEK	u$/!�_/!`C%!!B!�/!�Fu/!x/!rts��	/!xU%�"!)!��pro`c hWn�r �WINR0z:R`}�
3a��5t�a@GetDC,@:
� O�<ax ,SIZEOF G��c� .nS��,7�?�EV�SЫ,1��dwFlag06 FD_DRAW_�TO_�
DOWq]PPSUPPOR T_OPENGL�UDOUBLES`LayerMask,�MAIN�_PLAq$�i`	@elTypeRT YPE_RGBA��cEBi0@8��Depth�Qtx�cAccum�`��Stencil�0 Choos�e�F��e�z�����#0J�Set�<C,����� rm
�r�sjz �Fail�w�2ⲀContext��˓� Mak�eCurr@����f�$Cli �'!%���(є�	:�,�@.right� b0ottopgl�EnabPd �s���ERIApd
j�mp abr@�q:	MessageBo :Wn,S("Q�%��� �������� ��a�� ��  �������")������ �� ������MB_OKQ�
@?urn���9endp �/��=  ��� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �  Radius:DWORD,Parts:DWORD
			LOCAL	hSphere:DWORD
			invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
			invoke	gluNewQuadric
			mov	hSphere,eax
			invoke	gluQuadricDrawStyle,hSphere,GL_FILL
			invoke	gluQuadricNormals,hSphere,GL_SMOOTH
			invoke glColor3ub,0,255,0		
			mov	eax,Radius
			invoke	gluSphere,hSphere,[eax],[eax+4],Parts,Parts
			invoke	glEndList
			mov	eax,hSphere
			ret
SolidSphere		ENDP
; #########################################################################
WireSphere		PROC	ListNumber:DWORD,Radius:DWORD,Parts:DWORD
			LOCAL	hSphere:DWORD
			invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
			invoke	gluNewQuadric
			mov	hSphere,eax
			invoke	gluQuadricDrawStyle,hSphere,GLU_LINE
			invoke	gluQuadricNormals,hSphere,GL_SMOOTH
			invoke glColor3ub,255,255,0
			mov	eax,Radius
			invoke	gluSphere,hSphere,[eax],[eax+4],Parts,Parts
			invoke	glEndList
			mov	eax,hSphere
			ret
WireSphere		ENDP
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

invoke	CreateObjects,WINRect.right,WINRect.bottom
invoke glEnable,GL_COLOR_MATERIAL

jmp abrt
Fail:
invoke MessageBox,hWn,SADD("OpenGL �������������a�� �� �������"),SADD("����� �� �������������"),MB_OK

abrt:

return 0

Init endp
; ########################################################