unit kehilangan_handler;

interface
uses
    tipe_data;
const
    nmax = 1000;
type
    kehilangan = record
            Username, ID_Buku, Tanggal_Laporan: string;
        end;
    tabel_kehilangan = record
               t: array [0..nmax] of kehilangan;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_kehilangan;
procedure output(data_tempkehilangan: tabel_kehilangan);
function konversi_csv(data_tempkehilangan: tabel_kehilangan): arr_str;

implementation
function tambah(s: arr_str): tabel_kehilangan;
    { DESKRIPSI : Memasukkan data dari array of string kedalam tabel_kehilangan }
    { PARAMETER : array of string }
    { RETURN    : data kehilangan }

    var
      col, row: integer; // col = data ke-N, row = baris ke-N dari file csv
      temp: string; // string temporer, berfungsi 
      c: char;
      data_tempkehilangan : tabel_kehilangan;
    begin
      data_tempkehilangan.sz := 0;      
      for row:=0 to s.sz-1 do
      begin
        col := 0;
        temp := '';
        
        for c in s.st[row] do
        begin
            if(c=',') then
            begin
                // 0 based indexing
                case col of
                    0: data_tempkehilangan.t[data_tempkehilangan.sz].Username := temp;
                    1: data_tempkehilangan.t[data_tempkehilangan.sz].ID_Buku := temp;
                end;
                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_tempkehilangan.t[data_tempkehilangan.sz].Tanggal_Laporan := temp;
        data_tempkehilangan.sz := data_tempkehilangan.sz+1;        
      end;
      tambah := data_tempkehilangan;
    end;

function konversi_csv(data_tempkehilangan: tabel_kehilangan): arr_str;
    { DESKRIPSI : Fungsi untuk mengubah data kehilangan menjadi array of string }
    { PARAMETER : data kehilangan }
    { RETURN    : array of string }

    { KAMUS LOKAL }
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_tempkehilangan.sz;
        for i:=0 to data_tempkehilangan.sz do
        begin
            ret.st[i] := data_tempkehilangan.t[i].Username + ',' +
                      data_tempkehilangan.t[i].ID_Buku + ',' +
                      data_tempkehilangan.t[i].Tanggal_Laporan;
        end;
        konversi_csv := ret;
    end;

procedure output(data_tempkehilangan: tabel_kehilangan);
    { DESKRIPSI : Prosedur sederhana yang digunakan pada proses pembuatan program untuk debugging, prosedur ini mencetak data ke layar }
    { PARAMETER : Data yang akan dicetak }

    { KAMUS LOKAL }
    var
     i: integer;
    { ALGORITMA }
    begin
        for i:=0 to data_tempkehilangan.sz-1 do
        begin
            writeln(data_tempkehilangan.t[i].Username, ' | ', data_tempkehilangan.t[i].ID_Buku, ' | ', data_tempkehilangan.t[i].Tanggal_Laporan);
        end;
    end;

  
end.
