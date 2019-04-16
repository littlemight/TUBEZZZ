unit f15_cariAnggota;

interface
uses 
    utilitas,
    user_handler;

var
    inp : string;

function cek(var data_user : tabel_user; inp : string) : User;
procedure cetak(var data : user);
procedure lihatUser(data_user : tabel_user);

implementation

function cek(var data_user : tabel_user; inp : string) : User; // oke
    var
        i : integer;
    begin
        for i:= 1 to data_user.sz do
        begin
            if(inp = data_user.t[i].Username) then cek := data_user.t[i]
        end;
    end;

procedure cetak(var data : user);
    begin
            writeln('Nama Anggota: ', data.Nama);
            writeln('Alamat anggota: ',data.Alamat);
    end;

procedure lihatUser(data_user : tabel_user);
    var
        inp : string;
        who_user : user;
    begin
        write('Masukkan username: ');
        readln(inp);
        who_user := cek(data_user,inp);
        cetak(who_user);
    end;
end.
