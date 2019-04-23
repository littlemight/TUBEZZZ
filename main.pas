Program main;
{ DESKRIPSI : Program Manajemen Perpustakaan untuk Membantu Wan Shi Tong! }
{ ASUMSI    : Beberapa contoh di spesifikasi tidak perlu dilakukan validasi, namun kita menambahkan validasi opsional untuk beberapa contoh tersebut }

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
    // b01_simpanpw digunakan di f01_registrasi dan f02_login
    // b02_denda digunakan di f06_kembalikanbuku
    utilitas,
    tipe_data;

{ KAMUS GLOBAL }
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


{ ALGORITMA }
begin
    // welcome();
	{ LOAD DATA KE ARRAY }
    writeln('Load file by writing "load"'); 
    write('$ '); 
    repeat
    begin
        readln(inp);
        if (inp <> 'load') then write('$ ');
    end;
	until(inp = 'load');
	load(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan);
	end_of_submenu(c);
	clrscr();
	// loading();
    end_of_submenu(c);
    
    { LOGIN PENGGUNA ATAU EXIT PROGRAM }
    writeln('Silahkan Login dengan mengetik "login" terlebih atau keluar program dengan mengetik "exit"');
    write('$ ');
    repeat
		begin
			readln(inp);
			if ((inp <> 'login') and (inp <> 'exit')) then write('$ ');
		end;
	until((inp = 'login') or (inp = 'exit'));

    if(inp='exit') then writeln('Terima kasih telah berkunjung ke Wan Shi Tong''s Library!') else // inp = 'login'
    begin
        repeat
        begin
            who_login := login(data_user);
            have_login := isLogin(who_login);
            if (have_login = False) then
            begin
                repeat
                    who_login := login(data_user);
                    have_login := isLogin(who_login);
                until(have_login = true);
            end;
        end;
        until (have_login = True);
        writeln;
        writeln('Press Any Key to Proceed');
        inp := readkey;
        clrscr1();
        
        { MENU DAN I/O }
        if (who_login.Role = 'Admin') then load_menu_admin() else load_menu_pengunjung();
        write('$ '); readln(inp);
        if(inp='exit') then 
        begin
            exitprogram(data_buku,data_user,data_peminjaman,data_pengembalian,data_kehilangan);
        end else
        begin
            while(inp <> 'exit') do
                begin
                    { MENU ADMIN }
                    if (who_login.Role = 'Admin') then
                    begin
                        case inp of 
                            'register'           :  registrasi(data_user);              
                            'cari'               :  cari_kategori(data_buku);           
                            'caritahunterbit'    :  cari_tahun(data_buku);                  
                            'lihat_laporan'      :  lihat_hilang(data_buku,data_kehilangan); 
                            'tambah_buku'        :  tambah_baru(data_buku);             
                            'tambah_jumlah_buku' :  tambah_jumlah(data_buku);           
                            'statistik'          :  getStatistik(data_user, data_buku); 
                            'save'               :  save(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan); 
                            'cari_anggota'       :  lihatUser(data_user); 
                            'riwayat'            :  lihathistory(data_buku,data_peminjaman); 
                            else writeln('Masukan ', inp, ' tidak valid!');
                        end;
                        end_of_submenu(c);
                        load_menu_admin();
                        write('$ '); readln(inp); 
                        if(inp='exit') then exitprogram(data_buku,data_user,data_peminjaman,data_pengembalian,data_kehilangan);
                    end else
                    { MENU PENGUNJUNG }
                    if (who_login.Role = 'Pengunjung') then
                    begin
                        case inp of
                                'cari'               :  cari_kategori(data_buku);           
                                'save'               :  save(data_buku, data_user, data_peminjaman, data_pengembalian, data_kehilangan);                             
                                'caritahunterbit'    :  cari_tahun(data_buku); 
                                'pinjam_buku'        :  pinjam(data_peminjaman,data_buku,who_login.username);              
                                'lapor_hilang'       :  lapor(data_kehilangan, who_login.Username); 
                                'kembalikan_buku'    :  kembalikan_buku(who_login,data_peminjaman,data_buku,data_pengembalian);
                                else writeln('Masukan ', inp, ' tidak valid!');
                        end;
                        end_of_submenu(c);
                        load_menu_pengunjung();
                        write('$ '); readln(inp); 
                        if(inp='exit') then exitprogram(data_buku,data_user,data_peminjaman,data_pengembalian,data_kehilangan);
                    end;
                end;      
        end;

    end;
end.
