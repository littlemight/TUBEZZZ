Program main;

uses
    csv_parser,
    buku_handler,
    user_handler,
    History_Peminjaman_Handler,
    History_Pengembalian_Handler,
    Laporan_Buku_Hilang_handler,
    f03_findCategory,
    f04_findYear,
    f01_registrasiAkun,
    tipe_string;

var
    data_buku : tabel_buku;
    data_user : tabel_user;
    data_peminjaman : tabel_History_Peminjaman;
    data_pengembalian : tabel_History_Pengembalian;
    data_kehilangan : tabel_Laporan_Buku_Hilang;
    inp : string;

procedure load();
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := baca_csv(filename);
            data_buku := buku_handler.tambah(temp);
        write('Masukkan nama File User: '); readln(filename);
            temp := baca_csv(filename);
            data_user := user_handler.tambah(temp);
        write('Masukkan nama File Peminjaman: '); readln(filename);
            temp := baca_csv(filename);
            data_peminjaman := History_Peminjaman_Handler.tambah(temp);
        write('Masukkan nama File Pengembalian: '); readln(filename);
            temp := baca_csv(filename);
            data_pengembalian := History_Pengembalian_handler.tambah(temp);
        write('Masukkan nama File Buku Hilang: '); readln(filename);
            temp := baca_csv(filename);
            data_kehilangan := Laporan_Buku_Hilang_handler.tambah(temp);
        WriteLn('File perpustakaan berhasil dimuat!')
    end;

begin
    load();
    readln(inp);
    if(inp='exit') then writeln('keluar ya gan') else
    begin
        while(inp <> 'exit') do
        begin
            case inp of 
            'cari':
                begin
                    cari_kategori(data_buku);  
                end;
            'caritahunterbit':
                begin
                    cari_tahun(data_buku);
                end;
            end; 
            readln(inp); 
        end;

        if(inp='exit') then writeln('keluar ya gan');
    end;
end.
