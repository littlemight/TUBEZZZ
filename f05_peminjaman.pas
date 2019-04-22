unit f05_peminjaman;

interface
uses
	csv_parser,
	buku_handler,
	utilitas,
	user_handler,
	peminjaman_handler,
	tipe_data;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure simpan_ke_array(temp: peminjaman; var data_peminjaman: tabel_peminjaman);
procedure pinjam(var data_peminjaman: tabel_peminjaman; data_buku: tabel_buku; username: string);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure simpan_ke_array(temp: peminjaman; var data_peminjaman: tabel_peminjaman);
    { DESKRIPSI	: prosedur untuk menyimpan peminjaman baru ke data peminjaman }
	{ PARAMETER	: temp bertipe peminjaman, data_peminjaman bertipe tabel_peminjaman }

	begin
		data_peminjaman.t[data_peminjaman.sz] := temp;
		data_peminjaman.sz := data_peminjaman.sz+1;
	end;

procedure pinjam(var data_peminjaman: tabel_peminjaman; data_buku: tabel_buku; username: string);
    { DESKRIPSI	: prosedur untuk meminjam buku }
	{ PARAMETER	: data_peminjaman bertipe tabel_peminjaman, data_buku bertipe tabel_peminjaman, dan username bertipe string }

	{ KAMUS LOKAL }
	var
		id, tanggal: string;
		i: integer;
		peminjaman_temp: peminjaman;
	{ ALGORITMA }
	begin
	    write('Masukkan id buku yang ingin dipinjam: ');
		readln(id);
		write('Masukkan tanggal hari ini: ');
		readln(tanggal);

		i := findID(data_buku, id);
		if(i <> -1) then // Jika buku tersebut ada di data perpustakaan
		begin
			writeln('a');
			if (StringToInt(data_buku.t[i].Jumlah_Buku) > 0) then
				begin
					writeln('b');
					peminjaman_temp.Username := username; 
					peminjaman_temp.ID_Buku := id; // asumsikan valid
					peminjaman_temp.Tanggal_Peminjaman := tanggal;
					peminjaman_temp.Tanggal_Batas_Pengembalian := TambahDenda(tanggal);
					peminjaman_temp.Status_Pengembalian := 'False';
					peminjaman_temp.Author := data_buku.t[i].Author;
					writeln('Buku ',data_buku.t[i].Judul_Buku ,' berhasil dipinjam!');
					writeln('Tersisa ', StringToInt(data_buku.t[i].Jumlah_Buku)-1 ,' buku ',data_buku.t[i].Judul_Buku);
					writeln('Terima kasih sudah meminjam');

					//update jumlah pada buku.csv -1
					data_buku.t[i].Jumlah_Buku := IntToString(StringToInt(data_buku.t[i].Jumlah_Buku)-1);
					simpan_ke_array(peminjaman_temp, data_peminjaman);
			
				end
			else //jumlah =0
				begin
					writeln('Buku ', data_buku.t[i].Judul_Buku ,' sedang habis!');
					writeln('Coba lain kali.');
				end;
		end else writeln('Buku dengan ID tersebut tidak ada di perpustakan kami.')
		
	end;
end.