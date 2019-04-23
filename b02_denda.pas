unit b02_denda;

interface
uses
    csv_parser,
    user_handler,
    peminjaman_handler,
    pengembalian_handler,
    utilitas,
    tipe_data,
    buku_handler;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure denda(awal, akhir: string);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure denda(awal, akhir: string);
    { DESKRIPSI : Prosedur untuk menangani denda pengguna berdasarkan tanggal awal dan akhir }
    { PARAMETER : tanggal awal dan akhir }
    
    { KAMUS LOKAL }
    var
        deltaHari : int64;
    { ALGORITMA }
    begin
        deltaHari := BedaHari(awal, akhir);
        if (deltaHari <= 0) then // Jika pengembalian dilakukan setelah tanggal peminjaman dan sebelum tenggat waktu
        begin
            writeln('Terima kasih sudah meminjam');
        end else  if (deltaHari > 0)// deltaHari > 0
        then begin
            writeln('Anda terlambat mengembalikan buku.');
            writeln('Anda terkena denda Rp', deltaHari * 2000 , '.');
        end;
    end;
end.
