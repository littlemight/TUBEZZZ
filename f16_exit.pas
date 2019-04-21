unit f16_exit;

interface
procedure exit(data_buku : tabel_buku; data_user : tabel_user; data_peminjaman : tabel_peminjaman; data_pengembalian : tabel_pengembalian; data_kehilangan : tabel_kehilangan);


implementation

procedure exit(data_buku : tabel_buku; data_user : tabel_user; data_peminjaman : tabel_peminjaman; data_pengembalian : tabel_pengembalian; data_kehilangan : tabel_kehilangan);
    begin
	    writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?');
	    readln(c);
	    if (c = 'Y') then save(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan);
    end;
end.