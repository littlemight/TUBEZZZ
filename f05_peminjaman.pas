program f05;

uses
	csv_parser,
	buku_handler,
	utilitas,
	user_handler,
	peminjaman_handler,
	tipe_data;
//login f02;


var
	id : string;
	tanggal : string;
	data_buku : tabel_buku;
	data_peminjaman : tabel_peminjaman;
	temp : arr_str;
	i : integer;
	peminjaman_temp : peminjaman;


//function cari buku berdasarkan ID , function mengembalikan indeksnya
function findID(tabel : tabel_buku; id:string): integer;
	var
	i : integer;
	begin
		for i := 1 to data_buku.sz do
		begin
			if (data_buku.t[i].ID_Buku=id) then
				begin
					findID := i;
				end;
		end;
	end;

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

begin
    //load csv
	temp := baca_csv('buku.csv');
	data_buku := buku_handler.tambah(temp);
    temp := baca_csv('peminjaman.csv');
	data_peminjaman := peminjaman_handler.tambah(temp);
	
	write('Masukkan id buku yang ingin dipinjam: ');
	readln(id);
	write('Masukkan tanggal hari ini: ');
	readln(tanggal);
	// writeln(data_buku.sz);

	peminjaman_temp.Username := 'littlemight'; 
	peminjaman_temp.ID_Buku := id; // asumsikan valid
	peminjaman_temp.Tanggal_Peminjaman := tanggal;
	peminjaman_temp.Tanggal_Batas_Pengembalian := 'belum tau';
	peminjaman_temp.Status_Pengembalian := 'False';
	
	
	i := findID(data_buku,id);
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

            // data peminjaman disimpan ke peminjaman.csv
            temp := peminjaman_handler.konversi_csv(data_peminjaman);
            simpan_csv('peminjaman.csv', temp);

			// same
			temp := buku_handler.konversi_csv(data_buku);
            simpan_csv('buku.csv', temp);
			// simpannya di akhir
		end
	else //jumlah =0
		begin
			writeln('Buku ', data_buku.t[i].Judul_Buku ,' sedang habis');
			writeln('Coba lain kali');
		end;
end.