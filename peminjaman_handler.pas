unit peminjaman_handler;

interface
uses
    tipe_string;
const
    nmax = 1000;
type
    peminjaman = record
            Username, ID_Buku, Author, Tanggal_Peminjaman, Tanggal_Batas_Pengembalian, Status_Pengembalian : string;
        end;
    tabel_peminjaman = record
               t: array [0..nmax] of peminjaman;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_peminjaman;
procedure tulis(data_temppeminjaman: tabel_peminjaman);
function konversi_csv(data_temppeminjaman: tabel_peminjaman): arr_str;

implementation
function tambah(s: arr_str): tabel_peminjaman;
{ fungsi tambah adalah suatu fungsi yang menerima inputan berupa s -- array of string yang berisikan kumpulan string yang merupakan hasil convert dari text pada csv--
 dan mengubahnya menjadi array yang berupa data terpisah -- username, id_buku,author,tanggal peminjaman, tanggal batas pengembalian dan status pengembalian-- masing masing user.}
    var
      col, row: integer; // col = data ke-N, row = baris ke-N dari file csv
      temp: string; // string temporer, berfungsi 
      c: char;
      data_temppeminjaman : tabel_peminjaman;
    begin
      data_temppeminjaman.sz := 0;      
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
                    0: data_temppeminjaman.t[data_temppeminjaman.sz].Username := temp;
                    1: data_temppeminjaman.t[data_temppeminjaman.sz].ID_Buku := temp;
                    2: data_temppeminjaman.t[data_temppeminjaman.sz].Tanggal_Peminjaman := temp;
                    3: data_temppeminjaman.t[data_temppeminjaman.sz].Tanggal_Batas_Pengembalian := temp;
                end;

                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_temppeminjaman.t[data_temppeminjaman.sz].Status_Pengembalian := temp;
        data_temppeminjaman.sz := data_temppeminjaman.sz+1;        
      end;
      tulis(data_temppeminjaman);
      tambah := data_temppeminjaman;
    end;

function konversi_csv(data_temppeminjaman: tabel_peminjaman): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_temppeminjaman.sz;
        for i:=0 to data_temppeminjaman.sz do
        begin
            ret.st[i] := data_temppeminjaman.t[i].Username + ',' +
                      data_temppeminjaman.t[i].ID_Buku + ',' +
                      data_temppeminjaman.t[i].Author + ',' +
                      data_temppeminjaman.t[i].Tanggal_Peminjaman + ','+
                      data_temppeminjaman.t[i].Tanggal_Batas_Pengembalian + ',' +
                      data_temppeminjaman.t[i].Status_Pengembalian;
        end;
        konversi_csv := ret;
    end;

procedure tulis(data_temppeminjaman: tabel_peminjaman); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_temppeminjaman.sz-1 do
        begin
            writeln(data_temppeminjaman.t[i].Username, ' | ', data_temppeminjaman.t[i].ID_Buku, ' | ',  data_temppeminjaman.t[i].Tanggal_Peminjaman, ' | ', data_temppeminjaman.t[i].Tanggal_Batas_Pengembalian, ' | ', data_temppeminjaman.t[i].Status_Pengembalian);
        end;
    end;
end.
// sample
