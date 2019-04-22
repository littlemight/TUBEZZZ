unit f02_login;

interface
uses
    csv_parser,
    crt,
    user_handler,
    b01_simpanpw,
    utilitas;

{ DEKLARASI FUNGSI DAN PROSEDUR }
function login(var data_user : tabel_user) : user;
function isLogin(var who_login : User) : Boolean;

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
function login(var data_user : tabel_user) : user;
    { DESKRIPSI	: fungsi untuk login pengguna dan memeriksa apakah username/password sudah benar }
	{ PARAMETER	: data_user dengan tipe bentukan tabel_user }
    { RETURN    : data user dengan tipe bentukan user }

    { KAMUS LOKAL }
    var
        username,password : string;
        have_login : Boolean;
        i : integer;
    { ALGORITMA }
    begin
        write('Masukkan username: '); readln(username);
        write('Masukkan password: '); password := rollHash(tutupinInput());
        
        have_login := False; i := 1;// Inisialisasi
        while((i < data_user.sz)  and (have_login <> true))do
        begin
            if (username = data_user.t[i].Username) and (password = data_user.t[i].Password) then
            begin
                login := data_user.t[i];
                Writeln('Selamat datang ',login.Nama,'!');
                have_login := True;
            end else i := i+1;
        end;
        if(have_login = False) then writeln('Username / password salah! Silakan coba lagi.');
    end;

function isLogin(var who_login : User) : Boolean;
    { DESKRIPSI	: fungsi untuk memeriksa apakah who_login merupakan user yang valid }
	{ PARAMETER	: data user dengan tipe bentukan user }
    { RETURN    : boolean }

    { ALGORITMA }
    begin
        isLogin := False; // Inisialisasi
        if (who_login.Role = 'Admin') or (who_login.Role = 'Pengunjung') then isLogin := true;
    end;
end.
