begin
asm
	mov	ah,9
	mov	ax,cs
	mov	DS,ax
	lea	dx,@text
	int	$21
	mov	ah,8
	int	$21
@text:	db	'begin!$'
end;
end.