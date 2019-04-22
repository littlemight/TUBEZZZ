unit f15_cariAnggota;

interface
uses 
    utilitas, f02_Login,
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
        found: boolean = false;
    begin
        i := 1;
        while (i < data_user.sz) and (found <> true) do
        begin
            if(inp <> data_user.t[i].Username) then i := i+1 else
            begin
              found := true;
              cek := data_user.t[i];
            end;
        end;
        if(found = false) then cek := data_user.t[0]; 
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
        who_user := data_user.t[data_user.sz+1];
        who_user := cek(data_user,inp);
        if (who_user.Role = data_user.t[0].Role) then writeln('User tidak ditemukan!') else
        cetak(who_user);
    end;
end.
