unit f09_tambahbaru;

interface
uses
    buku_handler;

procedure tambah_baru(var data_buku: tabel_buku);

implementation
procedure tambah_baru(var data_buku: tabel_buku);
    var
        temp: buku;
    begin
      writeln('Masukkan Informasi buku yang ditambahkan:');
      write('Masukkan id buku: '); readln(temp.id_buku);
      write('Masukkan judul buku: '); readln(temp.judul_buku);
      write('Masukkan pengarang buku: '); readln(temp.author);
      write('Masukkan jumlah buku: '); readln(temp.jumlah_buku);
      write('Masukkan tahun terbit buku: '); readln(temp.tahun_penerbit);
      write('Masukkan kategori buku: '); readln(temp.kategori);

      data_buku.sz := data_buku.sz+1;
      data_buku.t[data_buku.sz-1] := temp;
      
      writeln();
      writeln('Buku berhasil ditambahkan ke dalam sistem!');
    end;
end.