Program test;

uses
  utilitas,
  tipe_data;

var
  tgl1, tgl2: string;

begin
  readln(tgl1);
  readln(tgl2);
  writeln(BedaHari(tgl1, tgl2));
end.