unit user_handler;

interface
uses
    tipe_string;
const
    nmax = 1000;
type
    user = record
            Nama, Alamat, Username, Password, Role : string;
        end;
    tabel_user = record
               t: array [0..nmax] of user;
               sz: integer; // effective size
            end;


function tambah(s: arr_str): tabel_user;
procedure print(data_tempuser: tabel_user);
function konversi_csv(data_tempuser: tabel_user): arr_str;

implementation
function tambah(s: arr_str): tabel_user;
    var
      col, row: integer;
      temp: string;
      c: char;
      data_tempuser : tabel_user;
    begin
      data_tempuser.sz := 0;      
      for row:=0 to s.sz-1 do
      begin
        col := 0;
        temp := '';
        
        for c in s.st[row] do
        begin
            if(c=',') then
            begin
                // 0 based indexing
                case col of
                    0: data_tempuser.t[data_tempuser.sz].Nama := temp;
                    1: data_tempuser.t[data_tempuser.sz].Alamat := temp;
                    2: data_tempuser.t[data_tempuser.sz].Username := temp;
                    3: data_tempuser.t[data_tempuser.sz].Password := temp;
                end;

                col := col+1;
                temp := '';
            end else temp := temp+c;
        end;  
        data_tempuser.t[data_tempuser.sz].Role := temp;
        data_tempuser.sz := data_tempuser.sz+1;        
      end;
      print(data_tempuser);
      tambah := data_tempuser;
    end;

function konversi_csv(data_tempuser: tabel_user): arr_str;
    var
        i : integer;
        ret : arr_str;
    begin
        ret.sz := data_tempuser.sz;
        for i:=0 to data_tempuser.sz do
        begin
            ret.st[i] := data_tempuser.t[i].Nama + ',' +
                      data_tempuser.t[i].Alamat + ',' +
                      data_tempuser.t[i].Username + ',' +
                      data_tempuser.t[i].Password + ','+
                      data_tempuser.t[i].Role;
        end;
        konversi_csv := ret;
    end;

procedure print(data_tempuser: tabel_user); // for debugging
    var
     i: integer;
    begin
        for i:=0 to data_tempuser.sz-1 do
        begin
            writeln(data_tempuser.t[i].Nama, ' | ', data_tempuser.t[i].Alamat, ' | ', data_tempuser.t[i].Username, ' | ', data_tempuser.t[i].Password, ' | ', data_tempuser.t[i].Role);
        end;
    end;

  
end.