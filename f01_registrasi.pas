unit f01_registrasi;

interface
uses
    csv_parser,
    user_handler;

procedure registrasi(var data_user : tabel_user);

implementation
procedure registrasi(var data_user : tabel_user);
    begin
        data_user.sz := data_user.sz+1;
        write('Masukkan nama pengunjung: '); readln(data_user.t[data_user.sz-1].nama);
        write('Masukkan alamat pengunjung: '); readln(data_user.t[data_user.sz-1].alamat);
        write('Masukkan username pengunjung: '); readln(data_user.t[data_user.sz-1].username);
        write('Masukkan password pengunjung: '); readln(data_user.t[data_user.sz-1].password);
        data_user.t[data_user.sz-1].Role := 'Pengunjung';
        
        writeln('Pengunjung ', data_user.t[data_user.sz-1].nama, ' berhasil terdaftar sebagai user.');
    end;
end.