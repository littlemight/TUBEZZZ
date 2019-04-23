unit f16_exitprogram;

interface

uses
    buku_handler,
    user_handler,
    peminjaman_Handler,
    pengembalian_Handler,
    kehilangan_handler,
    f14_save;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure exitprogram(var data_buku : tabel_buku; data_user : tabel_user; data_peminjaman : tabel_peminjaman; data_pengembalian : tabel_pengembalian; data_kehilangan : tabel_kehilangan);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure exitprogram(var data_buku : tabel_buku; data_user : tabel_user; data_peminjaman : tabel_peminjaman; data_pengembalian : tabel_pengembalian; data_kehilangan : tabel_kehilangan);
    { DESKRIPSI : Prosedur untuk keluar dari program utama }
    { PARAMETER : semua tabel data }

    { KAMUS LOKAL }
    var
        c : Char;
    { ALGORITMA }
    begin
	    writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?');
	    readln(c);
        while((c <> 'Y') and (c <> 'N')) do
        begin
            writeln('Masukan tidak valid! (Y/N)');
            readln(c);
        end; 
	    if (c = 'Y') then save(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan) else writeln('Terima kasih telah berkunjung ke Wan Shi Tong''s Library!');
    end;
end.
