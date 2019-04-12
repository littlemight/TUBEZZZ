unit f02_login;

interface
uses
    csv_parser,
    user_handler;

function login(var data_user : tabel_user): user;

implementation
function login(var data_user : tabel_user): user;
    var
        username,password : string;
        have_login : Boolean;
        i : integer;
    begin
        write('Masukkan username: '); readln(username);
        write('Masukkan password: '); readln(password);
        have_login := False;
        for i:= 1 to data_user.sz do
            begin
                if (username = data_user.t[i].Username) and (password = data_user.t[i].Password) then
                    begin
                        login := data_user.t[i];
                        Writeln('Selamat datang ',login.Username,' !');
                        have_login := True;
                    end;
            end;
        if (have_login = False) then
            begin
                login := data_user.t[data_user.sz+1];
                writeln('Username / password salah! Silakan coba lagi.');
            end;
    end;
end.
