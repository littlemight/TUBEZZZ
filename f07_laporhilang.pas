unit f07_laporhilang;

interface
uses
    kehilangan_handler,
    utilitas;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure lapor(var data_kehilangan: tabel_kehilangan; username: String);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure lapor(var data_kehilangan: tabel_kehilangan; username: String);
    { DESKRIPSI	: prosedur untuk melaporkan kehilangan buku }
	{ PARAMETER	: data kehilangan dan username pelapor }

    { KAMUS LOKAL }
    var
        judul: string;
        temp: kehilangan;
    { ALGORITMA }
    begin
      temp.username := username;
      write('Masukkan id buku: '); readln(temp.id_buku);
      write('Masukkan judul buku: '); readln(judul);
      write('Masukkan tanggal pelaporan: '); readln(temp.tanggal_laporan);
      writeln('');

      data_kehilangan.sz := data_kehilangan.sz+1;
      data_kehilangan.t[data_kehilangan.sz-1] := temp;
      
      writeln('Laporan berhasil diterima.');
    end;
end.