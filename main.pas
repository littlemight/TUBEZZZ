Program main;

uses
    csv_parser,
    crt,
    buku_handler,
    user_handler,
    peminjaman_Handler,
    pengembalian_Handler,
    kehilangan_handler,
    f01_registrasi,
    f02_Login,
    f03_findCategory,
    f04_findYear,
    f12_statistik,
    f13_load,
    f14_save,
    b02_denda,
    utilitas,
    tipe_data;

var
    data_buku : tabel_buku;
    data_user : tabel_user;
    data_peminjaman : tabel_peminjaman;
    data_pengembalian : tabel_pengembalian;
    data_kehilangan : tabel_kehilangan;
    who_login : user;
    have_login : Boolean;
    inp : string;
	
procedure end_of_submenu(var inp : Char);
    begin
    writeln('Press Any Key to Proceed');
    inp := readkey;
    clrscr();
    load_menu();
    write('$ ');
    end;

procedure load();
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := baca_csv(filename);
            data_buku := buku_handler.tambah(temp);
            writeln('');
        write('Masukkan nama File User: '); readln(filename);
            temp := baca_csv(filename);
            data_user := user_handler.tambah(temp);
            writeln('');
        write('Masukkan nama File Peminjaman: '); readln(filename);
             temp := baca_csv(filename);
            data_peminjaman := peminjaman_Handler.tambah(temp);
            writeln('');
        write('Masukkan nama File Pengembalian: '); readln(filename);
            temp := baca_csv(filename);
             data_pengembalian := pengembalian_handler.tambah(temp);
             writeln('');
         write('Masukkan nama File Buku Hilang: '); readln(filename);
          temp := baca_csv(filename);
            data_kehilangan := kehilangan_handler.tambah(temp);
            writeln('');
         WriteLn('File perpustakaan berhasil dimuat!')
    end;

procedure save();
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := baca_csv(filename);
            data_buku := buku_handler.tambah(temp);
            writeln('');
        write('Masukkan nama File User: '); readln(filename);
            temp := baca_csv(filename);
            data_user := user_handler.tambah(temp);
            writeln('');
        write('Masukkan nama File Peminjaman: '); readln(filename);
             temp := baca_csv(filename);
            data_peminjaman := peminjaman_Handler.tambah(temp);
            writeln('');
        write('Masukkan nama File Pengembalian: '); readln(filename);
            temp := baca_csv(filename);
             data_pengembalian := pengembalian_handler.tambah(temp);
             writeln('');
         write('Masukkan nama File Buku Hilang: '); readln(filename);
          temp := baca_csv(filename);
            data_kehilangan := kehilangan_handler.tambah(temp);
            writeln('');
         WriteLn('File perpustakaan berhasil dimuat!')
    end;

begin
    writeln('Load file by writing "load"'); write('$ '); 
    load();
    clrscr();
    writeln('Silahkan Login dengan mengetik "login" terlebih dahulu'); write('$ ');
    readln(inp);
    repeat
      begin
        who_login := login(data_user);
        have_login := isLogin(who_login);
        if (have_login = False) then
            begin
                write('$ ');readln(inp);
            end;
        end;
    until (have_login = True);
    end_of_submenu(inp);
    write('$ ');readln(inp);
    if(inp='exit') then writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?') else
    begin
        while(inp <> 'exit') do
        begin
            if (who_login.Role = 'Admin') then
            begin
            case inp of 
			'register' :
				begin
                    registrasi(data_user);
				end;
            'cari':
                begin
                    cari_kategori(data_buku);  
                end;
            'caritahunterbit':
                begin
                    cari_tahun(data_buku);  
                end;    
            'lihat_laporan':
                begin
                    cari_tahun(data_buku);
                end;
            'tambah_buku':
                begin
                  tambah_baru(data_buku);
                end;
            'tambah_jumlah_buku':
                begin
                  tambah_jumlah(data_buku);
                end;
            'statistik':
                begin
                  getStatistik(data_user, data_buku);
                end;
            'save':
                begin
                  save();
                end;
            'cari_anggota':
                begin
                  getStatistik(data_user, data_buku);
                end;
            end else if (who_login.Role = 'Pengunjung') then
            begin
            case inp of
            'cari':
                begin
                    cari_kategori(data_buku);
                end;
            'save':
                begin
                  save();
                end;
            'caritahunterbit':
                begin
                  getStatistik(data_user, data_buku);
                end;
            'pinjam_buku':
                begin
                    cari_tahun(data_buku);
                end;
            'lapor_hilang':
                begin
                  lapor(data_kehilangan, who_login.Username);
                end;
            'kembalikan_buku':
                begin
                  kembalikan_buku(who_login,data_peminjaman,data_buku,data_pengembalian);
                  cetak(data_buku);
                  writeln();
                  tulis(data_peminjaman);
                  writeln();
                  keluarkan(data_pengembalian);
                  writeln();
                end;
            end;
            end_of_submenu(inp);
            readln(inp); 
        end;
        if(inp='exit') then
        begin
            readln(inp);
            if (inp = 'Y') then
               begin 
                save();
                end;
        end;
    end;
end.
