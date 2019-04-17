unit f14_save;

interface
uses
    csv_parser,
    buku_handler,
    user_handler,
    peminjaman_Handler,
    pengembalian_Handler,
    kehilangan_handler,
    tipe_data;

procedure save(var data_buku: tabel_buku; var data_user: tabel_user; var data_peminjaman: tabel_peminjaman; var data_pengembalian: tabel_pengembalian; var data_kehilangan: tabel_kehilangan);
implementation
procedure save(var data_buku: tabel_buku; var data_user: tabel_user; var data_peminjaman: tabel_peminjaman; var data_pengembalian: tabel_pengembalian; var data_kehilangan: tabel_kehilangan);
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := buku_handler.konversi_csv(data_buku);
            simpan_csv(filename, temp);
        write('Masukkan nama File User: '); readln(filename);
            temp := user_handler.konversi_csv(data_user);
            simpan_csv(filename, temp);
        write('Masukkan nama File Peminjaman: '); readln(filename);
             temp := peminjaman_Handler.konversi_csv(data_peminjaman);
            simpan_csv(filename, temp);
        write('Masukkan nama File Pengembalian: '); readln(filename);
            temp := pengembalian_Handler.konversi_csv(data_pengembalian);
            simpan_csv(filename, temp);
         write('Masukkan nama File Buku Hilang: '); readln(filename);
          temp := kehilangan_handler.konversi_csv(data_kehilangan);
          simpan_csv(filename, temp);
          
         WriteLn('Data berhasil disimpan!');
    end;
end.