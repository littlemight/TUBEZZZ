unit f07_laporhilang;

interface
uses
    buku_handler,
    kehilangan_handler,
    peminjaman_handler,
    utilitas;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure lapor(var data_kehilangan: tabel_kehilangan; data_peminjaman : tabel_peminjaman; var data_buku: tabel_buku; username: String);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure lapor(var data_kehilangan: tabel_kehilangan; data_peminjaman : tabel_peminjaman; var data_buku: tabel_buku; username: String);
    { DESKRIPSI	: prosedur untuk melaporkan kehilangan buku }
	{ PARAMETER	: data kehilangan, data buku, dan username pelapor }

    { KAMUS LOKAL }
    var
        judul: string;
        temp: kehilangan;
        i : integer;
    { ALGORITMA }
    begin
      write('Masukkan id buku: '); readln(temp.id_buku);
      i := findID(data_buku, temp.ID_Buku);
      if(findID(data_buku, temp.ID_Buku)=-1) then writeln('Buku tersebut tidak ada di perpustakaan kami.') else
      begin
        temp.username := username;
        write('Masukkan judul buku: '); readln(judul);
        write('Masukkan tanggal pelaporan: '); readln(temp.tanggal_laporan);
        writeln('');

        data_kehilangan.sz := data_kehilangan.sz+1;
        data_kehilangan.t[data_kehilangan.sz-1] := temp;
        if (data_buku.t[i].Jumlah_Buku := '0') then writeln('Stok buku sudah habis sejak awal') else
        if ((findID2(data_peminjaman, temp.ID_Buku) = -1) or (data_peminjaman.t[findID2(data_peminjaman, temp.ID_Buku)].Status_Pengembalian = 'False')) then begin data_buku.t[i].Jumlah_Buku := IntToString(StringToInt(data_buku.t[i].Jumlah_Buku) - 1) end;
        writeln('Laporan berhasil diterima.');
      end;
    end;
end.
