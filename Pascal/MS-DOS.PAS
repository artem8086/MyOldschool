{$M 1024, 0, 0}
uses dos;
var s:string[79];
begin
  swapvectors;
  Exec(getenv('COMSPEC'),'/c AUTOEXEC.BAT>NUL');
  swapvectors;
  writeln('MS-DOS');
  repeat
    writeln;getdir(0,s);
    write(s,'>');readln(s);
    swapvectors;
    Exec(getenv('COMSPEC'),'/c '+s);
    swapvectors;
  until s='exit'
end.