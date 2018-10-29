uses crt;
var m:array[0..$BFFF]of byte;r:array[0..7]of byte;
sp,pc,hl:word;psw,d,e,f,b:byte;dp:longint;b2:word;
procedure jmp;
begin
  pc:=m[pc+1]+m[pc+2]*256-1
end;
procedure call;
begin
  m[sp-1]:=pc shr 8;sp:=sp-2;
  m[sp]:=pc and 255;
  pc:=m[pc+1]+m[pc+2]*256-1
end;
procedure ret;
begin
  pc:=m[sp]+m[sp+1]*256+2;
  sp:=sp+2
end;
function partdp:boolean;
begin
  d:=0;
  for b:=0 to 7 do d:=d+((dp shr b)and 1);
  if d mod 2=1 then partdp:=false
  else partdp:=true
end;
procedure step;
begin
  b:=m[pc];d:=b shr 6;
  e:=(b shr 3)and 7;f:=b and 7;
  hl:=256*r[5]+r[4];
  if hl<$C000 then r[6]:=m[hl];
  case b of
    $C3:jmp;
    $CD:call;
    $C9:ret;
    $E9:pc:=hl;
    $37:dp:=dp or 256;
    $2F:r[7]:=255-r[7];
    $31:begin sp:=m[pc+1]+m[pc+2]*256;pc:=pc+2 end;
    $33:inc(sp);
    $3B:dec(sp);
    $39:begin dp:=r[4]+r[5]*256+sp;r[4]:=dp and 255;
      r[5]:=(dp shr 8)and 255 end;
    $3F:if psw and 2=0 then dp:=dp or 256
    else dp:=dp and $FF;
    else case d of
      0:if f=6 then begin
	pc:=pc+1;r[e]:=m[pc]
      end else if f=4 then begin
	dp:=r[e]+1;r[e]:=dp
      end else if f=5 then begin
	dp:=r[e]-1;r[e]:=dp
      end else if f=3 then begin
	if e and 1=0 then begin end
      end else if f=3 then begin
	if e and 1=0 then begin
	  e:=e and 6;b2:=r[e]+r[e+1]*256+1;
	  r[e]:=b2 and 255;r[e+1]:=b2 shr 8
	end else begin
	  e:=e and 6;b2:=r[e-1]+r[e]*256-1;
	  r[e-1]:=b2 and 255;r[e]:=b2 shr 8
	end
      end else if f=1 then begin
      if e and 1=0 then begin
	e:=e and 6;inc(pc);r[e]:=m[pc];
	inc(pc);r[e+1]:=m[pc]
      end else begin
	e:=e and 6;dp:=r[e-1]+r[e]*256+sp;
	r[e-1]:=dp and 255;r[e]:=(dp shr 8)and 255
      end
      end;
      1:r[e]:=r[f];
      2:begin
	case e of
	  0:dp:=r[7]+r[f];
	  1:dp:=r[7]+r[f]+(psw shr 1)and 1;
	  2:dp:=r[7]-r[f];
	  3:dp:=r[7]-r[f]-(psw shr 1)and 1;
	  4:dp:=r[7] and r[f];
	  5:dp:=r[7] xor r[f];
	  6:dp:=r[7] or r[f];
	  7:dp:=r[7]-r[f];
	end;if e<>7 then r[7]:=dp end;
      3:if f=2 then begin
	if (e and 1)-((psw shr(e shr 1))and 1)=0 then
	jmp else pc:=pc+2
      end else if f=4 then begin
	if (e and 1)-((psw shr(e shr 1))and 1)=0 then
	call else pc:=pc+2
      end else if f=0 then begin
	if (e and 1)-((psw shr(e shr 1))and 1)=0 then
	ret
      end else if f=6 then begin
	pc:=pc+1;b:=m[pc];
	case e of
	  0:dp:=r[7]+b;
	  1:dp:=r[7]+b+(psw shr 1)and 1;
	  2:dp:=r[7]-b;
	  3:dp:=r[7]-b-(psw shr 1)and 1;
	  4:dp:=r[7] and b;
	  5:dp:=r[7] xor b;
	  6:dp:=r[7] or b;
	  7:dp:=r[7]-b;
	end;if e<>7 then r[7]:=dp;
      end;
  end end;inc(pc);psw:=0;
  if (dp>$FF)or(dp<0) then psw:=2;
  if dp and $FF=0 then psw:=psw+1;
  if dp<0 then psw:=psw+8;
  if partdp then psw:=psw+4;
  if hl<$C000 then m[hl]:=r[6];
end;
begin
  m[0]:=$37;m[1]:=$3F;m[2]:=$3F;
  m[3]:=$26;m[4]:=45;m[5]:=$E9;
  sp:=$8EFF;pc:=0;
  repeat
    step;b:=ord(readkey);
    writeln('PC=',pc);
    writeln('SP=',sp);
    writeln('PSW=',psw);
    writeln('A= ',r[7]);
    writeln('B= ',r[0]);
    writeln('C= ',r[1]);
    writeln('D= ',r[2]);
    writeln('E= ',r[3]);
    writeln('H= ',r[4]);
    writeln('L= ',r[5])
  until b=27
end.