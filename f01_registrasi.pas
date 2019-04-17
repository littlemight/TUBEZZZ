unit f01_registrasi;

interface
uses
    csv_parser,
    f02_login,
    b01_simpanpw,
    user_handler;

procedure registrasi(var data_user : tabel_user);

implementation
procedure registrasi(var data_user : tabel_user);
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