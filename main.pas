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
    f05_peminjaman,
    f06_KembalikanBuku,
    f07_laporhilang,
    f08_lihatlaporan,
    f09_tambahbaru,
    f10_tambahjumlah,
    f11_riwayatPeminjaman,
    f12_statistik,
    f15_cariAnggota,
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
    c : char;
	
procedure end_of_submenu(var inp : Char);
    begin
    writeln;
    writeln('Press Any Key to Proceed');
    inp := readkey;
    clrscr();
    end;

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
            data_peminjaman := peminjaman_Handler.tambah(temp);
        write('Masukkan nama File Pengembalian: '); readln(filename);
            temp := baca_csv(filename);
             data_pengembalian := pengembalian_handler.tambah(temp);
         write('Masukkan nama File Buku Hilang: '); readln(filename);
          temp := baca_csv(filename);
            data_kehilangan := kehilangan_handler.tambah(temp);
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

procedure load_menu_admin();
	begin
	writeln('Menu: ');
	writeln('1. register : registrasi akun');
	writeln('2. cari : mencari buku berdasarkan kategori');
	writeln('3. caritahunterbit : mencari buku berdasarkan tahun terbit.');
	writeln('4. lihat_laporan : melihat laporan buku yang hilang');
	writeln('5. tambah_buku : menambahkan buku baru');
	writeln('6. tambah_jumlah_buku : menambahkan sejumlah buku lama');
	writeln('7. statistik : meliat statistik user dan buku perkategori');
	writeln('8. save : menyimpan perubahan data');
	writeln('9. cari_anggota : mencari data nama dan alamat anggota');
	writeln('10. riwayat : melihat riwayat peminjaman buku oleh seorang pengunjung');
	writeln('11. exit : keluar dari program');
	writeln('Masukkan pilihan Anda: ');
	end;
	
procedure load_menu_pengunjung();
	begin
	writeln('Menu: ');
	writeln('1. cari : mencari buku berdasarkan kategori');
	writeln('2. save : menyimpan perubahan data');
	writeln('3. caritahunterbit : mencari buku berdasarkan tahun terbit.');
	writeln('4. pinjam_buku : meminjam satu buku');
	writeln('5. lapor_hilang : melaporkan buku yang hilang');
	writeln('6. kembalikan_buku : mengembalikan buku');
	writeln('7. exit : keluar dari program');
	writeln('Masukkan pilihan Anda: ');
	end;					

begin
	// loading files
    writeln('Load file by writing "load"'); 
    write('$ '); 
    repeat
		begin
			readln(inp);
			if (inp <> 'load') then write('$ ');
		end;
	until(inp = 'load');
	load();
	end_of_submenu(c);
    
    // login
    writeln('Silahkan Login dengan mengetik "login" terlebih dahulu'); write('$ ');
    repeat
		begin
			readln(inp);
			if (inp <> 'login') then write('$ ');
		end;
	until(inp = 'login');
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
    writeln;
    writeln('Press Any Key to Proceed');
    inp := readkey;
    clrscr();
    
    // algoritma utama
    if (who_login.Role = 'Admin') then load_menu_admin() else load_menu_pengunjung();
	write('$ '); readln(inp);
    if(inp='exit') then 
    begin
		writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?');
		readln(inp);
		if (inp = 'Y') then save();
	end else
    begin
        while(inp <> 'exit') do
			begin
				if (who_login.Role = 'Admin') then
					begin
						case inp of 
							'register'           : begin registrasi(data_user);              end;
							'cari'               : begin cari_kategori(data_buku);           end;
                            'caritahunterbit'    : begin cari_tahun(data_buku);              end;    
                            'lihat_laporan'      : begin lihat_hilang(data_buku,data_kehilangan); end;
                            'tambah_buku'        : begin tambah_baru(data_buku);             end;
                            'tambah_jumlah_buku' : begin tambah_jumlah(data_buku);           end;
                            'statistik'          : begin getStatistik(data_user, data_buku); end;
                            'save'               : begin save();                             end;
                            'cari_anggota'       : begin lihatUser(data_user); end;
                            'riwayat'            : begin lihathistory(data_buku,data_peminjaman); end;
                       end;
                    end_of_submenu(c);
                    load_menu_admin();
                    write('$ '); readln(inp); 
                    if(inp='exit') then
                        begin
						    writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?');
							readln(c);
							if (c = 'Y') then save();
						end;
                    end else 
                if (who_login.Role = 'Pengunjung') then
				    begin
				    load_menu_pengunjung();
                       case inp of
                            'cari'               : begin cari_kategori(data_buku);           end;
                            'save'               : begin save();                             end;
                            'caritahunterbit'    : begin getStatistik(data_user, data_buku); end;
                            'pinjam_buku'        : begin cari_tahun(data_buku);              end;
                            'lapor_hilang'       : begin lapor(data_kehilangan, who_login.Username); end;
                            'kembalikan_buku'    : begin
														 b02_denda.kembalikan_buku(who_login,data_peminjaman,data_buku,data_pengembalian);
												   end;
					end;
                end_of_submenu(c);
                load_menu_pengunjung();
                write('$ '); readln(inp); 
                if(inp='exit') then
                    begin
						writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?');
						readln(c);
						if (c = 'Y') then save();
                    end;
             end;
    end;
end;
end.
