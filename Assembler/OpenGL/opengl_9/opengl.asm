ƶ .386
.m odel fla t,stdcal l
optio n casema p:none  
include  opengl.� 8
; #E  �c �Wstart:wvoke  GetModul eHandle,  NULL
m@ov hIn ,n"c eax;in!3Comm 0Li�ne,, 2 WinMain,�(�2,�SW_S HOWDEFAULT�ExitP�rocess,�*�J�
�M p�2y  :DWORD,�
hPrev��1	Cmdz
Show��
LO CAL msg :MSG�Wwd#F	CWhtMtxNyF�`LoadIco�T,500?��CmA�`�k�
Cu rsor,�]ID�C_ARROW�y��RegistDer�GCla@_A�DDR WndAc,szBName�JC#�COLO R_BTNFAC8E+1�E�' A, ?@+� @DF| �Sy@mMetric s,SM_CXS CREEN	ToppXY,��t.x�ǩ�Y�ht×�y�Create CdowEx ,WS_EX_L8EFT@>CDDi`splay$$�O VERLAPPE�DWINDOW�bW�Wty��!�
b4�  P�O�6d5 0Ca�;Menu�k,�6"AdS�{B��H3Wc,h!�pNORMA���UpdGf��9
SA�Loopˉ`uagecD``cN0,0
Hcmp�L, `je �{��:Dra0wScea�dTrHans��eM�
 B+�
��,atch�0j��
�� 
return�t.wParam��!� endp?��?�$��g P`ROC h�$�u�MsgDc�l���rc:REC! �.if  == W`dOMMA|ND���`#	�1�00 .$*S`E%A,`S�b�,SC�_CLOSEdN�	 
�if� lse�REATE$�Init�Dina�.eSIZ���}ClientRLec�Grc<	 ResizeObj!rc.rig��u botto�6�	  a�:�S!i���,O@�DC�R��jz out��K wglDelet eContext�� �A: FR���}DC�,�$H��Destroy?pPDd(��_D@ESTROY�P�ostQuit�wABGp.d�Ff��[Q#,�!,#&�B�p�)ENDP!��/�.##�B[!svwDim4. s�� A
shr2 , 1 ; diviБscreeBn� mensQ�b8y 2���wi�n���]Q � copy �in�to�psubtP��� half1��from r=
���1� #@�E_��-{�lp�]3��lpf{$
�{�|� bColLor� ALO��w c:WNDCLA0SSEXa�wc�.cbS�:, ;of 9styQ�CS_VRED RAW or \4
 H�92mB �lpfn�, f�;�ClsE�xtraI��P��� �hbrB ackground, s�lps�zAv�|5�e
���
����� Q 7�� s �Be
�Sm,��Eo#��@��pw�R�;�
. �&?$�
�
p ��  ������ �� �� �� �� �� �� �� �� �� �� �� �� �� �� �  ZE
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