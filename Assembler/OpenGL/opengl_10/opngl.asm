��; #E 

 .data
M ainHDC d d 0
Open
PixF rm PIXEL FORMATDE SCRIPTOR <>F $osi tion1C.0�,0 -5 2 .dFloa t0		dd		) 
11.q �dva >2O bjectRad�ius0.8 14�3
Rot�a>Angle+ ! 5�8Speed�Lig�htP_� -��\�?X45 �dq 4 j
Z3�3�V99 �q �.code�Desize�e PROTO �:DWORD, 
DrawScene
Init�
CreDat�s			Ellipso�ide��� �q�ut2�TBZe~   J��)X�
?�ƿ�+�TC P�arentWD&CHC
invo ke glVie@wport,��,��H�	MatrixM@o,GL_@ZJECTION��LoadId�ity�uPer�sp �ive,y  PTR B�45iO+4�1�3m3o9m9+4KMODELVIEW(+ret��.ENDP?;��&JG�L /C	gl	BJfvA2LIGHDT0�3OSIA3,�ADDR  b�z}SPECULARht�AMB IENT_AND _DIFFUSE1�			�O En0able��
�B+�{�A�+�+�+�+s�#�C	�`�f( 9�,1��C�,24A @eLINE_�LOO Ca�nj�%?FK*���C�glClearA3COLOR_ BUFFE� IT or @DEP<TH�F)7�	Pu�sh���%(�T*��`��ك,eb� �Pop��Swa�pBuff H,�}��%����cC	ListN umberD%ZYfX�
@1B m�ov	eax,(r�3Trans�lpof,[�]R �+4t 8]q�.nr��e�+1�2D16� 20� �4p	a8		� �<Cal�Hst,���-Pu��`X���x����$s'�&� r@ �q��ax+�a
Scal�2�q		HC
�"s�b"#F��fld�	Ww#R	�fa����bC�stp�߶VbP�,$�| >1&� �&ns���0�����6 ���7����RDR���7�~x����C�1��	�U
�#"?>�;>�($kc 		>�z�?;
wv��C��TwU<part%=XY� Fil lType�=LO�CAL	phi�%u jRx�Ry%� z� 
#thXeta�� 0� 1�� ���s� c� ���,�� �� ��xy� z� xeJy� z� x2d
ye� z� x3�� zÄ �_
fi��` ldpi` mul[`��&fidiv�[d� �st[��� ��ZR f����4v+Newqe�e�� er,GL_CO MPILE_AN D_EXECUT E 
	
m ov eax,0	(i, 0

 newcicle :
finit ld[phi]! mul[st�&0(cos 4  >c J"P	r%siZn%s%�j�lin� 8 �the�ta�j	 tu_e��2RadiuT  DWO RD PTR [� {+4�%y�#�{�.nf�r�,�+x�+��f+��!Q8%zQad�d[X��1�E�� W��G�E�×6��C��A�WA@�C�f ���BJ�B3���A� >�	��{���2�%�Rd�9x���R��Rs3f��k3�"+H�Bv�s�
�ul�~&jc 
invoke  glBegin, FillTypec@�Normal 3f,x0, y` z ��Vert|ex��a��13�` z1�1,�y1,a�'2`	` z2r2,y26,a43�` z3��3,y3,a��Endc	c j'�@cmp��XYpart��jle � ���!�i�@�rZ�nz��Υ	�gl�Lis Ц'�Disable�� TEXTURE_@2D
re�E llipsoid e	ENDP
8; # ?!
I�� proc hWn:��
L OCAL WIN Rect:RECBTePixF�DtE�)GetDC,��#"MainH ��� �SIZEOdF arm�c. nSize,ax���Fsion, I!ddwFlag s,PFD_DR@AW_TO_�
D@OW or QS UPPORT_O PENGLUDO UBLEBUFFERzdwLay@erMaskBM AIN_PLANjEji�e�3RT YPE_RGBAJcColorB its,8�DeHpth�16�Apccum�$��c�Stencil���"Choose���,�ADDR�G��Set�C~,0�z00j@z Fail6w glCreatehCon�At��O8pen � Ma keCurren��,��$Cli {�'!%,	�(�7M	��Obj`*s,�@.right� b�otto�&�7�6 COLOR_MA�TERIAL�:%DEPTH_TES0�LIG`HTING��N ORMAL0/		�`�jEabr =!@�	MessagPeBox�S�("�+����� �������� a�� �� � ������"),������ �� �������MB_OK�Q���Durn P&t?�endp�D�C�  �������� �� �� �� �� �� �� �� �� �� �� �� �� �� �   		mov	ebx,ZYXRotations
	    		fld	DWORD PTR [eax+4]
	    		fadd	DWORD PTR [ebx+4]
	    		fstp	DWORD PTR [eax+4]
	    		invoke	glRotatef,[eax+4], dFloat1,dFloat0,dFloat0

			mov	eax,ZYXAngles			
	    		mov	ebx,ZYXRotations
	    		fld	DWORD PTR [eax]
	    		fadd	DWORD PTR [ebx]
	    		fstp	DWORD PTR [eax]
	    		invoke	glRotatef,[eax],dFloat0,dFloat1,dFloat0	 

   		
			invoke	glCallList,ListNumber
			ret

Rotate		ENDP

;#################################################################
Ellipsoide PROC  ListNumber:DWORD,Radius:DWORD,Zparts:DWORD,XYparts:DWORD,FillType:DWORD
LOCAL	phi:DWORD,i:DWORD,j:DWORD
LOCAL	Rx:DWORD,Ry:DWORD,Rz:DWORD
LOCAL	theta:DWORD,theta0:DWORD,theta1:DWORD
LOCAL	phi0:DWORD,sphi0:DWORD,cphi0:DWORD
LOCAL	phi1:DWORD,sphi1:DWORD,cphi1:DWORD
LOCAL	x0:DWORD,y0:DWORD,z0:DWORD,x1:DWORD,y1:DWORD,z1:DWORD,x2:DWORD,y2:DWORD,z2:DWORD,x3:DWORD,y3:DWORD,z3:DWORD	

finit
fldpi
fmul[dva]
fidiv[XYparts]

fst[phi]

fldpi
fmul[dva]
fidiv[Zparts]
fst[theta]



invoke	glNewList,ListNumber,GL_COMPILE_AND_EXECUTE 
	
mov eax,0
mov i,eax

newcicle:
finit
fld[phi]
fimul[i]
fst[phi0]
fcos
fst[cphi0]

finit
fld[phi0]
fsin
fst[sphi0]

mov eax,0
mov j,eax

newline:
finit

fld[theta]
fimul[j]
fst[theta0]


fsin
fmul[cphi0]
mov eax,Radius
fmul DWORD PTR [eax+4]
fst[y0]

finit
fld[theta0]
fcos
fmul[cphi0]
mov eax,Radius
fmul DWORD PTR [eax]
fst[x0]

finit
fld[phi0]
fsin
mov eax,Radius
fmul DWORD PTR [eax+8]
fst[z0]

finit
fld[theta0]
fadd[theta]
fst[theta1]
fsin
fmul[cphi0]
mov eax,Radius
fmul DWORD PTR [eax+4]
fst[y1]

finit
fld[theta1]
fcos
fmul[cphi0]
mov eax,Radius
fmul DWORD PTR [eax]
fst[x1]

fld[phi0]
fsin
mov eax,Radius
fmul DWORD PTR [eax+8]
fst[z1]

fld[phi0]
fadd[phi]
fst[phi1]
fsin
fst[sphi1]
finit
fld[phi1]
fcos
fst[cphi1]



fld[theta1]
fsin
fmul[cphi1]
mov eax,Radius
fmul DWORD PTR [eax+4]
fst[y2]

finit
fld[theta1]
fcos
fmul[cphi1]
mov eax,Radius
fmul DWORD PTR [eax]
fst[x2]

fld[phi1]
fsin
mov eax,Radius
fmul DWORD PTR [eax+8]
fst[z2]

finit
fld[theta0]
fsin
fmul[cphi1]
mov eax,Radius
fmul DWORD PTR [eax+4]
fst[y3]

finit
fld[theta0]
fcos
fmul[cphi1]
mov eax,Radius
fmul DWORD PTR [eax]
fst[x3]

fld[phi1]
fsin
mov eax,Radius
fmul DWORD PTR [eax+8]
fst[z3]


invoke glBegin,FillType


invoke glNormal3f,x0, y0, z0
invoke glVertex3f,x0,y0,z0


invoke glNormal3f,x1, y1, z1
invoke glVertex3f,x1,y1,z1

invoke glNormal3f,x2, y2, z2
invoke glVertex3f,x2,y2,z2


invoke glNormal3f,x3, y3, z3
invoke glVertex3f,x3,y3,z3

invoke glEnd

inc j
mov eax,j
cmp eax,XYparts
jle newline



inc i
mov eax,i
cmp eax,Zparts
jnz newcicle
invoke	glEndList
invoke glDisable,GL_TEXTURE_2D
ret
Ellipsoide	ENDP
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
invoke	glEnable,GL_DEPTH_TEST
invoke	glEnable,GL_LIGHTING
invoke	glEnable,GL_NORMALIZE			
jmp abrt
Fail:
invoke MessageBox,hWn,SADD("OpenGL �������������a�� �� �������"),SADD("����� �� �������������"),MB_OK

abrt:

return 0

Init endp
; ########################################################