unit f13_load;

interface
uses
    csv_parser,
    buku_handler,
    user_handler,
    peminjaman_Handler,
    pengembalian_Handler,
    kehilangan_handler,
    tipe_data;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure load(var data_buku: tabel_buku; var data_user: tabel_user; var data_peminjaman: tabel_peminjaman; var data_pengembalian: tabel_pengembalian; var data_kehilangan: tabel_kehilangan);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure load(var data_buku: tabel_buku; var data_user: tabel_user; var data_peminjaman: tabel_peminjaman; var data_pengembalian: tabel_pengembalian; var data_kehilangan: tabel_kehilangan);
    { DESKRIPSI : Memasukkan data dari .csv ke data di dalam program }
    { PARAMETER : semua tabel data }

    { KAMUS LOKAL }
    var
        temp : arr_str;
        filename : string;
    { ALGORITMA }
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := baca_csv(filename);
            data_buku := buku_handler.tambah(temp);
        write('Masukkan nama File User: '); readln(filename);
            temp := baca_csv(filename);
            data_user := user_handler.tambah(temp);
        write('Masukkan nama File Peminjaman: '); readln(filename);
             temp := baca_csv(filename);
            data_peminjaman := peminjaman_Handler.tambah(temp);
        write('Masukkan nama File Pengembalian: '); readln(filename);
            temp := baca_csv(filename);
             data_pengembalian := pengembalian_handler.tambah(temp);
         write('Masukkan nama File Buku Hilang: '); readln(filename);
          temp := baca_csv(filename);
            data_kehilangan := kehilangan_handler.tambah(temp);
         WriteLn('File perpustakaan berhasil dimuat!')
    end;

end.