var f:file of byte;
  rsi,rflags,rsp,n,segm,ofst:word;ram:^pointer;b,r1,r2:byte;reg:^byte;
begin
  assign(f,'åéçàíéê.ROM');
  getmem(ram,32768);
  segm:=seg(ram^);ofst:=ofs(ram^);
  getmem(ram,32768);
  reset(f);
  for n:=0 to 32767 do begin
    read(f,b);reg:=ptr(seg(ram^),ofs(ram^)+n);reg^:=b
  end;
  asm
	mov	rflags,0
	mov	bp,ofst
	mov	es,segm
@start:	mov	ax,es:[bp+rsi]
	mov	b,ah
	and	ah,$07
	mov	r1,ah
	mov	ah,b
	and	ah,$38
	ror	ah,1
	ror	ah,1
	ror	ah,1
	mov	r2,ah
	mov	ah,b
	and	ah,$C0
	cmp	b,$2a{LHLD @}
	jnz	@n7
	lea	cx,@r
	add	cx,8
	call	@adres
	mov	bx,dx
	mov     ax,[bx]
	mov	bx,cx
	mov     [bx],ax
	jmp	@start
@n7:	cmp	b,$22{SHLD @}
	jnz	@n8
	lea	cx,@r
	add	cx,8
	call	@adres
	mov	bx,cx
	mov     ax,[bx]
	mov	bx,dx
	mov     [bx],ax
	jmp	@start
@n8:	cmp	b,$CD{CALL @}
	jnz	@n4
	call	@adres
	push	rsi
	mov	rsi,dx
	jmp	@start
	pop	rsi
	jmp	@start
@n4:	cmp	b,$C9{RET}
	jnz	@n10
	pop	rsi
	jmp	@start
@n10:	cmp	b,$C3{JMP  @}
	jnz	@n2
	call	@adres
	mov	rsi,dx
	jmp	@start
@n2:	cmp	ah,0
	jnz	@AX1
	cmp	r1,3{INX  r2}
	jnz	@n9
	lea	di,r2
	call	@reg
	mov	ax,[bx][di]
	push	rflags
	popf
	inc	ax
	pushf
	pop	rflags
	mov	[bx][di],ax
	inc	rsi
	jmp	@start
@n9:	cmp	r1,1{LXI  r2,@}
	jnz	@n1
	lea	di,r2
	call	@reg
	inc	rsi
	mov	dx,es:[bp+rsi]
	MOV	[bx][di],dx
	inc	rsi
	jmp	@start
@n1:
@AX1:	cmp	ah,$40{MOV  r1,r2}
	jnz	@AX2
	lea	di,r1
	call	@reg
	MOV	dx,[bx][di]
	lea	di,r2
	call	reg
	MOV	[bx][di],dx
	INC	RSI
	JMP	@start
@ax2:
@AX3:	cmp	ah,$C0
	jnz	@n5
	cmp	r1,5{PUSH r2}
	lea     di,r2
	call    @reg
	mov	ax,[bx][di]
	mov	es:[bp+rsp],ax
	add	rsp,2
	jmp	@start
@n5:	cmp	r1,1{POP  r2}
	jnz	@n6
	lea     di,r2
	call    @reg
	mov	ax,es:[bp+rsp]
	mov     [bx][di],ax
	sub	rsp,2
	jmp	@start
@n6:
@exit:	ret
@reg:   mov	bx,0
	mov	bl,[di]
	add	bl,[di]
	lea	di,@r
	ret
@adres:	inc	rsi
	mov	ax,es:[bp+rsi]
	inc	rsi
	inc	rsi
	mov	dl,ah
	mov	dh,al
	ret
@exit2:
@r:	dw	0,0,0,0,0,0,0,0
  end;
end.