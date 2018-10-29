begin
asm
	mov	cx,255
@inpt:  mov	dx,cx
	in	al,dx
	mov	ah,al
	mov	ah,2
	int	$21
	mov	ah,7
	int	$21
	loop	@inpt
end;
end.