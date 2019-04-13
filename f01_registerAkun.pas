unit f01_registrasiAkun;

interface

uses 
    user_handler;
    tipe_data;
var
    inp : string;

procedure minta_data(data_input : tabel_user);
procedure masukkan_data(data_input : tabel_user);

implementation

procedure minta_data(data_input : tabel_user);
    begin
        write('Masukkan nama pengunjung: '); readln(data_input.t[data_input.sz + 1].Nama);
        write('Masukkan alamat pengunjung: '); readln(data_input.t[data_input.sz + 1].Alamat);
        write('Masukkan username pengunjung: '); readln(data_input.t[data_input.sz + 1].Username);
        write('Masukkan password pengunjung: '); readln(data_input.t[data_input.sz + 1].Password);
        data_input.t[data_input.sz + 1].Role := 'Pengunjung';
        data_input.sz := data_input.sz + 1;
        writeln('Pengunjung ',data_input.t[data_input.sz + 1].Nama,' berhasil terdaftar sebagai user.');
    end;
end.

procedure masukkan_data(data_input : tabel_user);
    begin
        konversi_csv(data_input);
    end;
end.