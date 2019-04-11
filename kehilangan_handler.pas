unit kehilangan_handler;

interface
uses
    tipe_string;
const
    nmax = 1000;
type
    kehilangan = record
            Username, ID_Buku_Hilang, Tanggal_Laporan: string;
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
{ fungsi tambah adalah suatu fungsi yang menerima inputan berupa s -- array of string yang berisikan kumpulan string yang merupakan hasil convert dari text pada csv--
 dan mengubahnya menjadi array yang berupa data terpisah -- username, _Hilang,author,tanggal peminjaman, tanggal batas pengembalian dan status pengembalian-- masing masing user.}
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
                    1: data_tempkehilangan.t[data_tempkehilangan.sz].ID_Buku_Hilang := temp;
                end;
                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_tempkehilangan.t[data_tempkehilangan.sz].Tanggal_Laporan := temp;
        data_tempkehilangan.sz := data_tempkehilangan.sz+1;        
      end;
      output(data_tempkehilangan);
      tambah := data_tempkehilangan;
    end;

function konversi_csv(data_tempkehilangan: tabel_kehilangan): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_tempkehilangan.sz;
        for i:=0 to data_tempkehilangan.sz do
        begin
            ret.st[i] := data_tempkehilangan.t[i].Username + ',' +
                      data_tempkehilangan.t[i].ID_Buku_Hilang + ',' +
                      data_tempkehilangan.t[i].Tanggal_Laporan;
        end;
        konversi_csv := ret;
    end;

procedure output(data_tempkehilangan: tabel_kehilangan); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_tempkehilangan.sz-1 do
        begin
            writeln(data_tempkehilangan.t[i].Username, ' | ', data_tempkehilangan.t[i].ID_Buku_Hilang, ' | ', data_tempkehilangan.t[i].Tanggal_Laporan);
        end;
    end;

  
end.
// sample
