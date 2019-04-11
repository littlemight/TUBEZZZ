unit f01_registrasiAkun;

interface

uses 
    user_handler,tipe_string;
    
var
    inp : string;


function minta_data(data_input : tabel_user): tabel_user;

implementation

function minta_data(data_input : tabel_user) : tabel_user;
    var
        data_bersih : tabel_user;
        Nama,Alamat,Username,Password,Role : string;
        i : integer;
    begin
        data_bersih := data_input;
        print(data_bersih);
        data_bersih.sz := data_bersih.sz + 1;
        write('Masukkan nama pengunjung: '); readln(Nama);
        data_bersih.t[data_bersih.sz-1].Nama := Nama;
        write('Masukkan alamat pengunjung: '); readln(Alamat);
        data_bersih.t[data_bersih.sz-1].Alamat:= Alamat;
        write('Masukkan username pengunjung: '); readln(Username);
        data_bersih.t[data_bersih.sz-1].Username := Username;
        write('Masukkan password pengunjung: '); readln(Password);
        data_bersih.t[data_bersih.sz-1].Password := Password;
        data_bersih.t[data_bersih.sz-1].Role := 'Pengunjung';
        minta_data := data_bersih;
        print(data_bersih);
        writeln('Pengunjung ',Data_bersih.t[data_bersih.sz-1].Nama,' berhasil terdaftar sebagai user.');
    end;
end.
