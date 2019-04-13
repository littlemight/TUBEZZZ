unit tipe_data;

interface
const
    nmax = 1000;
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