unit f05_peminjaman;

interface
uses
	csv_parser,
	buku_handler,
	utilitas,
	user_handler,
	peminjaman_handler,
	tipe_data;

procedure simpan_ke_array(temp: peminjaman; var data_peminjaman: tabel_peminjaman);
procedure pinjam(var data_peminjaman: tabel_peminjaman; data_buku: tabel_buku; username: string);

implementation
//procedure untuk menyimpan data ke array
procedure simpan_ke_array(temp: peminjaman; var data_peminjaman: tabel_peminjaman);
	begin
		data_peminjaman.t[data_peminjaman.sz].Username := temp.Username;
		data_peminjaman.t[data_peminjaman.sz].ID_Buku := temp.ID_Buku;
		data_peminjaman.t[data_peminjaman.sz].Author := temp.Author;
		data_peminjaman.t[data_peminjaman.sz].Tanggal_Peminjaman := temp.Tanggal_Peminjaman;
		data_peminjaman.t[data_peminjaman.sz].Tanggal_Batas_Pengembalian := temp.Tanggal_Batas_Pengembalian;
		data_peminjaman.t[data_peminjaman.sz].Status_Pengembalian := temp.Status_Pengembalian;
		data_peminjaman.sz := data_peminjaman.sz+1;
	end;

procedure pinjam(var data_peminjaman: tabel_peminjaman; data_buku: tabel_buku; username: string);
	var
		id, tanggal: string;
		i: integer;
		temp: arr_str;
		peminjaman_temp: peminjaman;
	begin
	    write('Masukkan id buku yang ingin dipinjam: ');
		readln(id);
		write('Masukkan tanggal hari ini: ');
		readln(tanggal);

		peminjaman_temp.Username := username; 
		peminjaman_temp.ID_Buku := id; // asumsikan valid
		peminjaman_temp.Tanggal_Peminjaman := tanggal;
		peminjaman_temp.Tanggal_Batas_Pengembalian := TambahDenda(tanggal);
		peminjaman_temp.Status_Pengembalian := 'False';

		i := findID(data_buku, id); // asumsi id pasti ketemu
		if (StringToInt(data_buku.t[i].Jumlah_Buku) > 0) then
			begin
				peminjaman_temp.Author := data_buku.t[i].Author;
				writeln('Buku',data_buku.t[i].Judul_Buku ,'berhasil dipinjam!');
				writeln('Tersisa', StringToInt(data_buku.t[i].Jumlah_Buku)-1 ,'buku','judul buku');
				writeln('Terima kasih sudah meminjam');

				//update jumlah pda buku.csv -1
				data_buku.t[i].Jumlah_Buku := IntToString(StringToInt(data_buku.t[i].Jumlah_Buku)-1);
				simpan_ke_array(peminjaman_temp, data_peminjaman);
				peminjaman_handler.tulis(data_peminjaman);			
			end
		else //jumlah =0
			begin
				writeln('Buku ', data_buku.t[i].Judul_Buku ,' sedang habis!');
				writeln('Coba lain kali.');
			end;
	end;
end.