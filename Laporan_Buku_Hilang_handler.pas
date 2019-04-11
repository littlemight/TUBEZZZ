unit Laporan_Buku_Hilang_Handler;

interface
uses
    tipe_string;
const
    nmax = 1000;
type
    Laporan_Buku_Hilang = record
            Username, ID_Buku_Hilang, Tanggal_Laporan: string;
        end;
    tabel_Laporan_Buku_Hilang = record
               t: array [0..nmax] of Laporan_Buku_Hilang;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_Laporan_Buku_Hilang;
procedure print(data_tempLaporan_Buku_Hilang: tabel_Laporan_Buku_Hilang);
function konversi_csv(data_tempLaporan_Buku_Hilang: tabel_Laporan_Buku_Hilang): arr_str;

implementation
function tambah(s: arr_str): tabel_Laporan_Buku_Hilang;
{ fungsi tambah adalah suatu fungsi yang menerima inputan berupa s -- array of string yang berisikan kumpulan string yang merupakan hasil convert dari text pada csv--
 dan mengubahnya menjadi array yang berupa data terpisah -- username, _Hilang,author,tanggal peminjaman, tanggal batas pengembalian dan status pengembalian-- masing masing user.}
    var
      col, row: integer; // col = data ke-N, row = baris ke-N dari file csv
      temp: string; // string temporer, berfungsi 
      c: char;
      data_tempLaporan_Buku_Hilang : tabel_Laporan_Buku_Hilang;
    begin
      data_tempLaporan_Buku_Hilang.sz := 0;      
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
                    0: data_tempLaporan_Buku_Hilang.t[data_tempLaporan_Buku_Hilang.sz].Username := temp;
                    1: data_tempLaporan_Buku_Hilang.t[data_tempLaporan_Buku_Hilang.sz].ID_Buku_Hilang := temp;
                end;
                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_tempLaporan_Buku_Hilang.t[data_tempLaporan_Buku_Hilang.sz].Tanggal_Laporan := temp;
        data_tempLaporan_Buku_Hilang.sz := data_tempLaporan_Buku_Hilang.sz+1;        
      end;
      print(data_tempLaporan_Buku_Hilang);
      tambah := data_tempLaporan_Buku_Hilang;
    end;

function konversi_csv(data_tempLaporan_Buku_Hilang: tabel_Laporan_Buku_Hilang): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_tempLaporan_Buku_Hilang.sz;
        for i:=0 to data_tempLaporan_Buku_Hilang.sz do
        begin
            ret.st[i] := data_tempLaporan_Buku_Hilang.t[i].Username + ',' +
                      data_tempLaporan_Buku_Hilang.t[i].ID_Buku_Hilang + ',' +
                      data_tempLaporan_Buku_Hilang.t[i].Tanggal_Laporan;
        end;
        konversi_csv := ret;
    end;

procedure print(data_tempLaporan_Buku_Hilang: tabel_Laporan_Buku_Hilang); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_tempLaporan_Buku_Hilang.sz-1 do
        begin
            writeln(data_tempLaporan_Buku_Hilang.t[i].Username, ' | ', data_tempLaporan_Buku_Hilang.t[i].ID_Buku_Hilang, ' | ', data_tempLaporan_Buku_Hilang.t[i].Tanggal_Laporan);
        end;
    end;

  
end.
// sample
