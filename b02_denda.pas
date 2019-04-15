unit b02_denda;

interface
uses
    csv_parser,
    user_handler,
    peminjaman_handler,
    pengembalian_handler,
    utilitas,
    tipe_data,
    buku_handler;
procedure kembalikan_buku(who_login : user; data_peminjaman : tabel_peminjaman; data_buku : tabel_buku; data_pengembalian : tabel_pengembalian);

implementation
procedure kembalikan_buku(who_login : user; data_peminjaman : tabel_peminjaman; data_buku : tabel_buku; data_pengembalian : tabel_pengembalian);
    var
    ID_Buku,todayTanggal : String;
    buku_pinjam : peminjaman;
    judul_buku_pinjam : string;
    deltaHari,i,amount_buku : integer;

    begin
      write('Masukkan id buku yang dikembalikan: '); Readln(ID_Buku);
      for i := 1 to (data_peminjaman.sz - 1) do
			begin
            if ID_Buku = data_peminjaman.t[i].ID_Buku then
              buku_pinjam := data_peminjaman.t[i];
			end;
      for i := 1 to (data_buku.sz - 1) do
			begin
            if ID_Buku = data_buku.t[i].ID_Buku then
              judul_buku_pinjam := data_buku.t[i].Judul_Buku;
			end;
      writeln('Data peminjaman: ');
      writeln('Username: ', buku_pinjam.Username);
      writeln('Judul Buku: ', judul_buku_pinjam);
      writeln('Tanggal peminjaman: ',buku_pinjam.Tanggal_Peminjaman);
      writeln('Tanggal batas pengembalian: ',buku_pinjam.Tanggal_Batas_Pengembalian);
      if (who_login.Username <> buku_pinjam.Username) or (buku_pinjam.Status_Pengembalian = 'True') then
        begin
            writeln('Anda tidak sedang meminjam buku ini.');
        end else
        begin
            write('Masukkan Tanggal Hari ini: '); Readln(todayTanggal);
            deltaHari := BedaHari(buku_pinjam.Tanggal_Batas_Pengembalian,todayTanggal);
            if (deltaHari <= 0) then
                begin
                    writeln('Terima kasih sudah meminjam');
                end else
            // if (deltaHari > 0) then
                begin
                    writeln('Anda terlambat mengembalikan buku.');
                    writeln('Anda terkena denda ', deltaHari * 2000 , '.');
                end;
            for i := 1 to (data_peminjaman.sz - 1) do
			begin
            if ID_Buku = data_peminjaman.t[i].ID_Buku then
              data_peminjaman.t[i].Status_Pengembalian := 'True';
			end;
            for i := 1 to (data_buku.sz - 1) do
			begin
            if ID_Buku = data_buku.t[i].ID_Buku then
              amount_buku := (StringToInt(data_buku.t[i].Jumlah_Buku) + 1) ;
              data_buku.t[i].Jumlah_Buku := IntToString(amount_buku);
			end;
            data_pengembalian.sz := data_pengembalian.sz + 1;
            data_pengembalian.t[data_pengembalian.sz-1].Username := buku_pinjam.Username;
            data_pengembalian.t[data_pengembalian.sz-1].ID_buku := buku_pinjam.ID_Buku;
            data_pengembalian.t[data_pengembalian.sz-1].Tanggal_Pengembalian := todayTanggal;
		end;
	end;
end.
