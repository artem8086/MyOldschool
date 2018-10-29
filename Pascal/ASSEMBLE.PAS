uses Crt;
label 1;
var X:word;
begin
  asm
	mov	dx,0h
  end;
  1:asm
	inc	dx
	in	ax,dx
	mov	X,ax
  end;
  writeln(X);repeat until KeyPressed;goto 1;
  repeat until KeyPressed;
end.