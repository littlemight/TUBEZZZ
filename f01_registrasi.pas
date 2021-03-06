unit f01_registrasi;

interface
uses
    csv_parser,
    f02_login,
    b01_simpanpw,
    user_handler,
    utilitas;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure registrasi(var data_user : tabel_user);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure registrasi(var data_user : tabel_user);
    { DESKRIPSI	: menambahkan pengguna ke dalam array database }
	{ PARAMETER	: data_user dengan tipe bentukan tabel_user }

    { ALGORITMA }
    begin
        data_user.sz := data_user.sz+1;
        write('Masukkan nama pengunjung: '); readln(data_user.t[data_user.sz-1].nama);
        write('Masukkan alamat pengunjung: '); readln(data_user.t[data_user.sz-1].alamat);
        write('Masukkan username pengunjung: '); readln(data_user.t[data_user.sz-1].username);
        write('Masukkan password pengunjung: '); data_user.t[data_user.sz-1].password := rollHash(tutupinInput());
        data_user.t[data_user.sz-1].Role := 'Pengunjung';
        
        writeln('Pengunjung ', data_user.t[data_user.sz-1].nama, ' berhasil terdaftar sebagai user.');
    end;
end.