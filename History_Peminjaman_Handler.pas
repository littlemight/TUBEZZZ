unit History_Peminjaman_handler;

interface
uses
    tipe_string;
const
    nmax = 1000;
type
    History_Peminjaman = record
            Username, ID_Buku, Author, Tanggal_Peminjaman, Tanggal_Batas_Pengembalian, Status_Pengembalian : string;
        end;
    tabel_History_Peminjaman = record
               t: array [0..nmax] of History_Peminjaman;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_History_Peminjaman;
procedure print(data_tempHistory_Peminjaman: tabel_History_Peminjaman);
function konversi_csv(data_tempHistory_Peminjaman: tabel_History_Peminjaman): arr_str;

implementation
function tambah(s: arr_str): tabel_History_Peminjaman;
{ fungsi tambah adalah suatu fungsi yang menerima inputan berupa s -- array of string yang berisikan kumpulan string yang merupakan hasil convert dari text pada csv--
 dan mengubahnya menjadi array yang berupa data terpisah -- username, id_buku,author,tanggal peminjaman, tanggal batas pengembalian dan status pengembalian-- masing masing user.}
    var
      col, row: integer; // col = data ke-N, row = baris ke-N dari file csv
      temp: string; // string temporer, berfungsi 
      c: char;
      data_tempHistory_Peminjaman : tabel_History_Peminjaman;
    begin
      data_tempHistory_Peminjaman.sz := 0;      
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
                    0: data_tempHistory_Peminjaman.t[data_tempHistory_Peminjaman.sz].Username := temp;
                    1: data_tempHistory_Peminjaman.t[data_tempHistory_Peminjaman.sz].ID_Buku := temp;
                    2: data_tempHistory_Peminjaman.t[data_tempHistory_Peminjaman.sz].Tanggal_Peminjaman := temp;
                    3: data_tempHistory_Peminjaman.t[data_tempHistory_Peminjaman.sz].Tanggal_Batas_Pengembalian := temp;
                end;

                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_tempHistory_Peminjaman.t[data_tempHistory_Peminjaman.sz].Status_Pengembalian := temp;
        data_tempHistory_Peminjaman.sz := data_tempHistory_Peminjaman.sz+1;        
      end;
      print(data_tempHistory_Peminjaman);
      tambah := data_tempHistory_Peminjaman;
    end;

function konversi_csv(data_tempHistory_Peminjaman: tabel_History_Peminjaman): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_tempHistory_Peminjaman.sz;
        for i:=0 to data_tempHistory_Peminjaman.sz do
        begin
            ret.st[i] := data_tempHistory_Peminjaman.t[i].Username + ',' +
                      data_tempHistory_Peminjaman.t[i].ID_Buku + ',' +
                      data_tempHistory_Peminjaman.t[i].Author + ',' +
                      data_tempHistory_Peminjaman.t[i].Tanggal_Peminjaman + ','+
                      data_tempHistory_Peminjaman.t[i].Tanggal_Batas_Pengembalian + ',' +
                      data_tempHistory_Peminjaman.t[i].Status_Pengembalian;
        end;
        konversi_csv := ret;
    end;

procedure print(data_tempHistory_Peminjaman: tabel_History_Peminjaman); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_tempHistory_Peminjaman.sz-1 do
        begin
            writeln(data_tempHistory_Peminjaman.t[i].Username, ' | ', data_tempHistory_Peminjaman.t[i].ID_Buku, ' | ',  data_tempHistory_Peminjaman.t[i].Tanggal_Peminjaman, ' | ', data_tempHistory_Peminjaman.t[i].Tanggal_Batas_Pengembalian, ' | ', data_tempHistory_Peminjaman.t[i].Status_Pengembalian);
        end;
    end;
end.
// sample
