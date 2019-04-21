Program main;

uses
    csv_parser,
    buku_handler,
    user_handler,
    peminjaman_Handler,
    pengembalian_Handler,
    kehilangan_handler,
    crt,
    intro,
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
    f13_load,
    f14_save,
    f15_carianggota,
    f16_exitprogram,
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


// Algoritma utama
begin
    //welcome();
	// loading files
    writeln('Load file by writing "load"'); 
    write('$ '); 
    repeat
		begin
			readln(inp);
			if (inp <> 'load') then write('$ ');
		end;
	until(inp = 'load');
	load(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan);
	clrscr();
	loading();
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
                repeat
					begin
						if (inp <> 'login') then begin write('$ '); readln(inp); end;
					end;
				until(inp = 'login');
            end;
      end;
    until (have_login = True);
    writeln;
    writeln('Press Any Key to Proceed');
    inp := readkey;
    clrscr1();
    
    // algoritma utama
    if (who_login.Role = 'Admin') then load_menu_admin() else load_menu_pengunjung();
	write('$ '); readln(inp);
    if(inp='exit') then 
    begin
		writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?');
		readln(inp);
		if (inp = 'Y') then save(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan);
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
                            'save'               : begin save(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan);                             end;
                            'cari_anggota'       : begin lihatUser(data_user); end;
                            'riwayat'            : begin lihathistory(data_buku,data_peminjaman); end;
                       end;
                    end_of_submenu(c);
                    load_menu_admin();
                    write('$ '); readln(inp); 
                    if(inp='exit') then
                        exitprogram(data_buku,data_user,data_peminjaman,data_pengembalian,data_kehilangan);
                    end else 
                if (who_login.Role = 'Pengunjung') then
				    begin
                       case inp of
                            'cari'               : begin cari_kategori(data_buku);           end;
                            'save'               : begin save(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan);                             end;
                            'caritahunterbit'    : begin cari_tahun(data_buku); end;
                            'pinjam_buku'        : begin pinjam(data_peminjaman,data_buku,who_login.username);              end;
                            'lapor_hilang'       : begin lapor(data_kehilangan, who_login.Username); end;
                            'kembalikan_buku'    : begin
														 b02_denda.kembalikan_buku(who_login,data_peminjaman,data_buku,data_pengembalian);
												   end;
					end;
                end_of_submenu(c);
                load_menu_pengunjung();
                write('$ '); readln(inp); 
                if(inp='exit') then
                    exitprogram(data_buku,data_user,data_peminjaman,data_pengembalian,data_kehilangan);
             end;
    end;
end;
end.
