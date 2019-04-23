unit buku_handler;

interface
uses
    tipe_data;

{ KONSTANTA }
const
    nmax = 1000; // Asumsi bahwa size terbesar dari database adalah 1000

{ DEKLARASI TIPE }
type
    buku = record
            ID_Buku, Judul_Buku, Author, Jumlah_Buku, Tahun_Penerbit, Kategori : string;
        end;
    tabel_buku = record
               t: array [0..nmax] of buku;
               sz: integer; // effective size
            end;

{ DEKLARASI FUNGSI DAN PROSEDUR }
function tambah(s: arr_str): tabel_buku;
procedure cetak(data_tempbuku: tabel_buku);
function konversi_csv(data_tempbuku: tabel_buku): arr_str;

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
function tambah(s: arr_str): tabel_buku;
    { DESKRIPSI : Memasukkan data dari array of string kedalam tabel_buku }
    { PARAMETER : array of string }
    { RETURN    : data buku }

    { KAMUS LOKAL }
    var
      col, row: integer;
      temp: string;
      c: char;
      data_tempbuku : tabel_buku;
    { ALGORITMA }
    begin
      data_tempbuku.sz := 0;      
      for row:=0 to s.sz-1 do
      begin
        col := 0;
        temp := '';
        
        // Membaca baris dan memisahkan tiap kolom setiap kali mendapatkan karakter ','
        // data di indeks ke-0 merupakan header
        for c in s.st[row] do
        begin
            if(c=',') then // Jika ketemu koma, maka masukkan data ke kolom
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
            end else temp := temp+c; // Jika belum ketemu koma, maka tambahkan tambahkan karakter ke string untuk data di kolom selanjutnya
        end;
        // Kolom terakhir
        data_tempbuku.t[data_tempbuku.sz].Kategori := temp;
        data_tempbuku.sz := data_tempbuku.sz+1;        
      end;
      tambah := data_tempbuku;
    end;

function konversi_csv(data_tempbuku: tabel_buku): arr_str;
    { DESKRIPSI : Fungsi untuk mengubah data buku menjadi array of string }
    { PARAMETER : data buku }
    { RETURN    : array of string }

    { KAMUS LOKAL }
    var
        i : integer;
        ret : arr_str;
    { ALGORITMA }
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
    { DESKRIPSI : Prosedur sederhana yang digunakan pada proses pembuatan program untuk debugging, prosedur ini mencetak data ke layar }
    { PARAMETER : Data yang akan dicetak }

    { KAMUS LOKAL }
    var
     i: integer;
    { ALGORITMA }
    begin
        for i:=0 to data_tempbuku.sz-1 do
        begin
            writeln(data_tempbuku.t[i].ID_Buku, ' | ', data_tempbuku.t[i].Judul_Buku, ' | ', data_tempbuku.t[i].Author, ' | ', data_tempbuku.t[i].Jumlah_Buku, ' | ', data_tempbuku.t[i].Tahun_Penerbit, ' | ', data_tempbuku.t[i].Kategori);
        end;
    end;

end.
