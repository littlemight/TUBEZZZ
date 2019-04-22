unit f10_tambahjumlah;

interface
uses
    buku_handler,
    utilitas;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure tambah_jumlah(var data_buku: tabel_buku);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure tambah_jumlah(var data_buku: tabel_buku);
    { DESKRIPSI	: prosedur untuk menambahkan jumlah buku yang sudah ada ke tabel buku }
	  { PARAMETER	: data buku }

    { KAMUS LOKAL }
    var
      id: string;
      where, banyak: integer;
    { ALGORITMA }
    begin
      write('Masukkan ID Buku: '); readln(id);
      write('Masukkan jumlah buku yang ditambahkan: '); readln(banyak);
      
      where := findID(data_buku, id);
      data_buku.t[where].jumlah_buku := IntToString(StringToInt(data_buku.t[where].jumlah_buku) + banyak);
      
      writeln('Pembaharuan jumlah buku berhasil dilakukan, total buku ',
               data_buku.t[where].judul_buku,
               ' di perpustakaan menjadi ',
               data_buku.t[where].jumlah_buku);
    end;
end.