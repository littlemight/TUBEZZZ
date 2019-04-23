unit f07_laporhilang;

interface
uses
    buku_handler,
    kehilangan_handler,
    utilitas;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure lapor(var data_kehilangan: tabel_kehilangan; data_buku: tabel_buku; username: String);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure lapor(var data_kehilangan: tabel_kehilangan; data_buku: tabel_buku; username: String);
    { DESKRIPSI	: prosedur untuk melaporkan kehilangan buku }
	{ PARAMETER	: data kehilangan dan username pelapor }

    { KAMUS LOKAL }
    var
        judul: string;
        temp: kehilangan;
    { ALGORITMA }
    begin
      write('Masukkan id buku: '); readln(temp.id_buku);
      if(findID(data_buku, temp.ID_Buku)=-1) then writeln('Buku tersebut tidak ada di perpustakaan kami.') else
      begin
        temp.username := username;
        write('Masukkan judul buku: '); readln(judul);
        write('Masukkan tanggal pelaporan: '); readln(temp.tanggal_laporan);
        writeln('');

        data_kehilangan.sz := data_kehilangan.sz+1;
        data_kehilangan.t[data_kehilangan.sz-1] := temp;
        
        writeln('Laporan berhasil diterima.');
      end;
    end;
end.