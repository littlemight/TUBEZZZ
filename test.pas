Program test;

uses
  b01_simpanpw,
  utilitas;

var
  coba: string;
begin
  readln(coba);
  writeln(rollHash(coba));
end.