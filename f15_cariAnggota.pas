unit f15_cariAnggota;

interface
uses 
    utilitas, f02_Login,
    user_handler;
{ KAMUS }
var
    inp : string;

{ DEKLARASI FUNGSI DAN PROSEDUR }
function cek(data_user : tabel_user; inp : string) : User;
procedure cetak(data : user);
procedure lihatUser(data_user : tabel_user);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
function cek(data_user : tabel_user; inp : string) : User;
    { DESKRIPSI : Mencari user di tabel user }
    { PARAMETER : tabel user }
    { RETURN    : data user yang valid jika benar, dan header array jika salah }
    
    { KAMUS LOKAL }
    var
        i : integer;
        found: boolean = false;
    { ALGORITMA }
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
	
procedure cetak(data : user);
    { DESKRIPSI : Mencetak nama dan alamat user }
    { PARAMETER : data user }
    begin
        writeln('Nama Anggota: ', data.Nama);
        writeln('Alamat anggota: ',data.Alamat);
    end;

procedure lihatUser(data_user : tabel_user);
    { DESKRIPSI : Melihat user di tabel user }
    { PARAMETER : tabel user }

    { KAMUS LOKAL }
    var
        inp : string;
        who_user : user;
    { ALGORITMA }
    begin
        write('Masukkan username: ');
        readln(inp);
        who_user := data_user.t[data_user.sz+1];
        who_user := cek(data_user,inp);
        if (who_user.Role = data_user.t[0].Role) then writeln('User tidak ditemukan!') else
        cetak(who_user);
    end;
end.
