unit pengembalian_handler;

interface
uses
    tipe_data;
const
    nmax = 1000;
type
    pengembalian = record
            Username, ID_Buku, Tanggal_Pengembalian: string;
        end;
    tabel_pengembalian = record
               t: array [0..nmax] of pengembalian;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_pengembalian;
procedure keluarkan(data_temppengembalian: tabel_pengembalian);
function konversi_csv(data_temppengembalian: tabel_pengembalian): arr_str;

implementation
function tambah(s: arr_str): tabel_pengembalian;
{ fungsi tambah adalah suatu fungsi yang menerima inputan berupa s -- array of string yang berisikan kumpulan string yang merupakan hasil convert dari text pada csv--
 dan mengubahnya menjadi array yang berupa data terpisah -- username, id_buku,author,tanggal peminjaman, tanggal batas pengembalian dan status pengembalian-- masing masing user.}
    var
      col, row: integer; // col = data ke-N, row = baris ke-N dari file csv
      temp: string; // string temporer, berfungsi 
      c: char;
      data_temppengembalian : tabel_pengembalian;
    begin
      data_temppengembalian.sz := 0;      
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
                    0: data_temppengembalian.t[data_temppengembalian.sz].Username := temp;
                    1: data_temppengembalian.t[data_temppengembalian.sz].ID_Buku := temp;
                end;
                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_temppengembalian.t[data_temppengembalian.sz].Tanggal_Pengembalian := temp;
        data_temppengembalian.sz := data_temppengembalian.sz+1;        
      end;
    //   keluarkan(data_temppengembalian);
      tambah := data_temppengembalian;
    end;

function konversi_csv(data_temppengembalian: tabel_pengembalian): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_temppengembalian.sz;
        for i:=0 to data_temppengembalian.sz do
        begin
            ret.st[i] := data_temppengembalian.t[i].Username + ',' +
                      data_temppengembalian.t[i].ID_Buku + ',' +
                      data_temppengembalian.t[i].Tanggal_Pengembalian;
        end;
        konversi_csv := ret;
    end;

procedure keluarkan(data_temppengembalian: tabel_pengembalian); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_temppengembalian.sz-1 do
        begin
            writeln(data_temppengembalian.t[i].Username, ' | ', data_temppengembalian.t[i].ID_Buku, ' | ', data_temppengembalian.t[i].Tanggal_Pengembalian);
        end;
    end;

  
end.
// sample
