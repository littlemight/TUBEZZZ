unit f02_login;

interface
uses csvdocument;
var
    username, password: string;
    user_data : tcsvdocument;
    rc, i, login_row: integer;
    login_feedback: boolean;

procedure login;
function grantadminaccess(var row:integer):boolean;

implementation

procedure login;
begin
    write('Masukkan username: ');
    readln(username);
    write('Masukkan password pengunjung: ');
    readln(password);

    login_feedback:=false;

    //----- Read the CSV -----
    
    user_data:=tcsvdocument.create();
    user_data.loadfromfile('user.csv');
    rc:=user_data.rowcount;

    for i:=0 to rc do
    begin
        if(user_data.cells[2,i]=username) and (user_data.cells[3,i]=password) then
        begin
            login_feedback:=true;
            login_row:=i;
            break;
        end;
    end;

    if(login_feedback) then writeln('LOGIN SUCCESSFUL!')
    else writeln('LOGIN FAILED');
end;

end.