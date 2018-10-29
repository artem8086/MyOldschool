begin
asm
	mov	aH,02
	mov	dl,'>'
	int	$21
	mov	di,0
@inpt:	mov	ah,8
	int	$21
	cmp     al,13
	je	@done
	cmp	al,'9'
	ja	@inpt
	cmp	al,'0'
	jb	@inpt
	mov	ah,2
	mov	dl,al
	int	$21
	sub	al,'0'
	xor	ah,ah
	mov	cx,ax
	mov	ax,di
	mov	bx,10
	mul	bx
	add	ax,cx
	mov	di,ax
	jmp	@inpt
@done:	mov	ax,di
	lea	si,@string
	call	@wrd
	jmp	@exit
@wrd:   mov	bx,cs
	mov	es,bx
	mov	bx,$f000
	mov	dl,12
	mov	cx,4
@cccc:	push	cx
	push	ax
	and	ax,bx
	mov	cl,dl
	shr	ax,cl
	call	@bin
	mov	es:[si],al
	inc	si
	mov	cl,4
	shr	bx,cl
	sub	dl,4
	pop	ax
	pop	cx
	loop	@cccc
	ret
@bin:	cmp	al,9
	ja	@letter
	add	al,$30
	jmp	@ok
@letter:add	al,$37
@ok:	ret
@exit:  mov	ah,2
	mov	dl,'='
	int	$21
	mov	bx,cs
	mov	ds,bx
	lea	dx,@string
	mov	ah,9
	int	$21
	mov	ah,7
	int	$21
@string:db	'????h$'
end;
end.
