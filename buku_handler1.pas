unit buku_handler1;

interface
uses
    tipe_string;
const
    nmax = 1000;
type
    buku = record
            ID_Buku, Judul_Buku, Author, Jumlah_Buku, Tahun_Penerbit, Kategori : string;
        end;
    tabel_buku = record
               t: array [0..nmax] of buku;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_buku;
procedure cetak(data_tempbuku: tabel_buku);
function konversi_csv(data_tempbuku: tabel_buku): arr_str;

implementation
function tambah(s: arr_str): tabel_buku;
    var
      col, row, len, i: integer;
      temp, cur: string;
      data_tempbuku : tabel_buku;
    begin
      data_tempbuku.sz := 0;      
      for row:=0 to s.sz-1 do
      begin
        col := 0;
        temp := '';
        
        cur := s.st[row];
        len := length(cur);

        for i:=1 to len do
        begin
            if(cur[i]=',') then
            begin
                if( (cur[i+1]<>' ') and (i<len) ) then
                begin
                    // 0 based indexing
                    case col of
                        0: data_tempbuku.t[data_tempbuku.sz].ID_Buku := temp;
                        1: data_tempbuku.t[data_tempbuku.sz].Judul_Buku := temp;
                        2: data_tempbuku.t[data_tempbuku.sz].Author := temp;
                        3: data_tempbuku.t[data_tempbuku.sz].Jumlah_Buku := temp;
                        4: data_tempbuku.t[data_tempbuku.sz].Tahun_Penerbit := temp;
                    end;

                    col := col+1;
                    temp := '';
                end; 
            end else temp := temp+cur[i];
        end;  
        data_tempbuku.t[data_tempbuku.sz].Kategori := temp;
        data_tempbuku.sz := data_tempbuku.sz+1;        
      end;
      cetak(data_tempbuku);
      tambah := data_tempbuku;
    end;

function konversi_csv(data_tempbuku: tabel_buku): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_tempbuku.sz;
        for i:=0 to data_tempbuku.sz do
        begin
            ret.st[i] := data_tempbuku.t[i].ID_Buku + ',' +
                      data_tempbuku.t[i].Judul_Buku + ',' +
                      data_tempbuku.t[i].Author + ',' +
                      data_tempbuku.t[i].Jumlah_Buku + ','+
                      data_tempbuku.t[i].Tahun_Penerbit + ',' +
                      data_tempbuku.t[i].Kategori;
        end;
        konversi_csv := ret;
    end;

procedure cetak(data_tempbuku: tabel_buku); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_tempbuku.sz-1 do
        begin
            writeln(data_tempbuku.t[i].ID_Buku, ' | ', data_tempbuku.t[i].Judul_Buku, ' | ', data_tempbuku.t[i].Author, ' | ', data_tempbuku.t[i].Jumlah_Buku, ' | ', data_tempbuku.t[i].Tahun_Penerbit, ' | ', data_tempbuku.t[i].Kategori);
        end;
    end;

  
end.
// sample
