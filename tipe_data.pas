unit tipe_data;

interface
{ KONSTANTA }
const
    nmax = 1000; // Asumsi size terbesar adalah 1000

{ DEKLARASI TIPE }
type
  arr_str = record
                st : array [0..nmax] of string;
                sz : integer; //effective size
            end;
  tanggal = record
                hari, bulan, tahun: integer;
            end;

implementation
end.