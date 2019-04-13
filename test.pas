Program test;

uses
  utilitas,
  tipe_data;

var
  tgl1, tgl2: string;

begin
  tgl1 := '28/02/2004';
  tgl2 := '24/03/2004';
  writeln(BedaHari(tgl1, tgl2));
end.