uses graphics3d,graph,crt;
var gd,gm,x2,y2,z2,x3,y3:integer;ch:char;
begin
  gd:=detect;n:=10;a:=3;b:=3;
  assign(fil,'vector.3D');rewrite(fil);
  initgraph(gd,gm,'d:\tp7\bgi');
  wr:=true;graph3d(0,0,clear3D);close(fil);
  reset(fil);wr:=false;mouse:=true;
  repeat
    z2:=0;seek(fil,0);
    graph3d(x2,y2,read3D);ch:=readkey;
    cleardevice;case ch of
      ',':conx:=conx-0.1;
      '.':conx:=conx+0.1;
      '/','?':cony:=cony-0.1;
      '"',#39:cony:=cony+0.1;
      '+','=':z2:=z2+1;
      '-','_':z2:=z2-1;
      'W','w':yp:=yp-10;
      'X','x':yp:=yp+10;
      'A','a':xp:=xp-10;
      'd','D':xp:=xp+10;
      '4':xs:=xs-1;
      '6':xs:=xs+1;
      '8':ys:=ys-1;
      '2':ys:=ys+1;
      '7','1':begin xs:=xs-1;ys:=ys+1 end;
      '9','3':begin xs:=xs+1;ys:=ys-1 end;
      #0:case ord(readkey) of
	73:z2:=50;
	81:z2:=-50;
	75:y2:=y2-1;
	77:y2:=y2+1;
	72:x2:=x2-1;
	80:x2:=x2+1;
      end;
    end;seek(fil,0);readwrite3d(x2,y2,z2)
  until ch=#27;close(fil)
end.