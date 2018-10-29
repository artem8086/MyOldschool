uses graphics3d,graph,crt;
var gd,gm,xp,yp,x2,y2,z2:integer;ch:char;
begin
  gd:=detect;n:=20;a:=3;b:=3;
  assign(fil,'vector.3D');reset(fil);
  initgraph(gd,gm,'d:\tp7\bgi');wr:=true;
  repeat
    cleardevice;graph3d(xp+200,yp+200,sin3D);
    ch:=readkey;case ch of
      ',':conx:=conx-0.1;
      '.':conx:=conx+0.1;
      'w':b:=b-0.1;
      'x':b:=b+0.1;
      'd':a:=a+0.1;
      'a':a:=a-0.1;
      '4':xs:=xs-1;
      '6':xs:=xs+1;
      '8':ys:=ys-1;
      '2':ys:=ys+1;
      '7','1':begin xs:=xs-1;ys:=ys+1 end;
      '9','3':begin xs:=xs+1;ys:=ys-1 end;
      #0:case ord(readkey) of
	73:n:=n-1;
	81:n:=n+1;
	72:yp:=yp-5;
	80:yp:=yp+5;
	75:xp:=xp-5;
	77:xp:=xp+5;
      end;
    end;seek(fil,0)
  until ch=#27;close(fil)
end.