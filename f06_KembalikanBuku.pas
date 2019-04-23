unit f06_KembalikanBuku;

interface
uses
    csv_parser,
    user_handler,
    peminjaman_handler,
    pengembalian_handler,
    utilitas,
    tipe_data,
    b02_denda,
    buku_handler;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure kembalikan_buku(who_login : user; var data_peminjaman : tabel_peminjaman; var data_buku : tabel_buku; var data_pengembalian : tabel_pengembalian);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure kembalikan_buku(who_login : user; var data_peminjaman : tabel_peminjaman; var data_buku : tabel_buku; var data_pengembalian : tabel_pengembalian);
    { DESKRIPSI	: prosedur untuk mengembalikan buku }
	{ PARAMETER	: data pengguna, data peminjaman, data buku, dan data pengembalian }

    { KAMUS LOKAL }
    var
        ID_Buku,todayTanggal : String;
        buku_pinjam : peminjaman;
        judul_buku_pinjam : string;
        i,amount_buku : integer;
        found: boolean;

    { ALGORITMA }
    begin
      write('Masukkan id buku yang dikembalikan: '); Readln(ID_Buku);
      i := 1; found := false;
      while ((i < data_peminjaman.sz) and (found <> true)) do
      begin
        if ((ID_Buku = data_peminjaman.t[i].ID_Buku) and (who_login.Username = data_peminjaman.t[i].Username)) then 
        { Jika buku yang dipinjam ada di riwayat peminjaman dengan username yang sama dengan pengguna }
        begin
           buku_pinjam := data_peminjaman.t[i];
           found := true;
        end else i := i+1;
      end;

      if(not found) then writeln('Anda tidak sedang meminjam buku ini.') else // Jika pengguna meminjam buku tersebut
      begin
        for i := 1 to (data_buku.sz - 1) do
        begin
            if ID_Buku = data_buku.t[i].ID_Buku then judul_buku_pinjam := data_buku.t[i].Judul_Buku;
        end;

        if (buku_pinjam.Status_Pengembalian = 'True') then writeln('Anda tidak sedang meminjam buku ini.') else
        begin
            writeln('Data peminjaman: ');
            writeln('Username: ', buku_pinjam.Username);
            writeln('Judul Buku: ', judul_buku_pinjam); 
            writeln('Tanggal peminjaman: ', buku_pinjam.Tanggal_Peminjaman);
            writeln('Tanggal batas pengembalian: ',buku_pinjam.Tanggal_Batas_Pengembalian);
            write('Masukkan Tanggal Hari ini: '); Readln(todayTanggal);
            
            if(BedaHari(buku_pinjam.Tanggal_Peminjaman, todayTanggal) < 0) then writeln('Tanggal yang dimasukkan sebelum tanggal peminjaman.') // Jika pengguna memasukkan tanggal sebelum tanggal peminjaman
            else denda(buku_pinjam.Tanggal_Batas_Pengembalian, todayTanggal);

            for i := 1 to (data_peminjaman.sz - 1) do
            begin
                if ID_Buku = data_peminjaman.t[i].ID_Buku then
                data_peminjaman.t[i].Status_Pengembalian := 'True';
            end;
            for i := 1 to (data_buku.sz - 1) do
            begin
                if ID_Buku = data_buku.t[i].ID_Buku then
                begin
                    amount_buku := (StringToInt(data_buku.t[i].Jumlah_Buku) + 1) ;
                    data_buku.t[i].Jumlah_Buku := IntToString(amount_buku);
                end;
            end;
            data_pengembalian.sz := data_pengembalian.sz + 1;
            data_pengembalian.t[data_pengembalian.sz-1].Username := buku_pinjam.Username;
            data_pengembalian.t[data_pengembalian.sz-1].ID_buku := buku_pinjam.ID_Buku;
            data_pengembalian.t[data_pengembalian.sz-1].Tanggal_Pengembalian := todayTanggal;
        end;
      end;
	end;
end.
