unit History_Pengembalian_Handler;

interface
uses
    tipe_string;
const
    nmax = 1000;
type
    History_Pengembalian = record
            Username, ID_Buku, Tanggal_Peminjaman: string;
        end;
    tabel_History_Pengembalian = record
               t: array [0..nmax] of History_Pengembalian;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_History_Pengembalian;
procedure print(data_tempHistory_Pengembalian: tabel_History_Pengembalian);
function konversi_csv(data_tempHistory_Pengembalian: tabel_History_Pengembalian): arr_str;

implementation
function tambah(s: arr_str): tabel_History_Pengembalian;
{ fungsi tambah adalah suatu fungsi yang menerima inputan berupa s -- array of string yang berisikan kumpulan string yang merupakan hasil convert dari text pada csv--
 dan mengubahnya menjadi array yang berupa data terpisah -- username, id_buku,author,tanggal peminjaman, tanggal batas pengembalian dan status pengembalian-- masing masing user.}
    var
      col, row: integer; // col = data ke-N, row = baris ke-N dari file csv
      temp: string; // string temporer, berfungsi 
      c: char;
      data_tempHistory_Pengembalian : tabel_History_Pengembalian;
    begin
      data_tempHistory_Pengembalian.sz := 0;      
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
                    0: data_tempHistory_Pengembalian.t[data_tempHistory_Pengembalian.sz].Username := temp;
                    1: data_tempHistory_Pengembalian.t[data_tempHistory_Pengembalian.sz].ID_Buku := temp;
                end;
                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_tempHistory_Pengembalian.t[data_tempHistory_Pengembalian.sz].Tanggal_Pengembalian := temp;
        data_tempHistory_Pengembalian.sz := data_tempHistory_Pengembalian.sz+1;        
      end;
      print(data_tempHistory_Pengembalian);
      tambah := data_tempHistory_Pengembalian;
    end;

function konversi_csv(data_tempHistory_Pengembalian: tabel_History_Pengembalian): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_tempHistory_Pengembalian.sz;
        for i:=0 to data_tempHistory_Pengembalian.sz do
        begin
            ret.st[i] := data_tempHistory_Pengembalian.t[i].Username + ',' +
                      data_tempHistory_Pengembalian.t[i].ID_Buku + ',' +
                      data_tempHistory_Pengembalian.t[i].Tanggal_Peminjaman;
        end;
        konversi_csv := ret;
    end;

procedure print(data_tempHistory_Pengembalian: tabel_History_Pengembalian); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_tempHistory_Pengembalian.sz-1 do
        begin
            writeln(data_tempHistory_Pengembalian.t[data_tempHistory_Pengembalian.sz].Username, ' | ', data_tempHistory_Pengembalian.t[i].ID_Buku, ' | ', data_tempHistory_Pengembalian.t[i].Tanggal_Pengembalian);
        end;
    end;

  
end.
// sample