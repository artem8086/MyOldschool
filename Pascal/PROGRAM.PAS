var X,Y: Word;
begin
read(X);read(Y);
asm
	MOV     AX,X
	CMP     AX,Y
	JAE     @@1
	MOV     AX,Y
@@1:
end;
end.