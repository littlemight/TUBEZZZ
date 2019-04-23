unit user_handler;

interface
uses
    tipe_data;

{ KONSTANTA }
const
    nmax = 1000; // Asumsi bahwa size terbesar dari database adalah 1000

{ DEKLARASI TIPE }
type
    user = record
            Nama, Alamat, Username, Password, Role : string;
        end;
    tabel_user = record
               t: array [0..nmax] of user;
               sz: integer; // effective size
            end;

{ DEKLARASI FUNGSI DAN PROSEDUR }
function tambah(s: arr_str): tabel_user;
procedure print(data_tempuser: tabel_user);
function konversi_csv(data_tempuser: tabel_user): arr_str;

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
function tambah(s: arr_str): tabel_user;
    { DESKRIPSI : Memasukkan data dari array of string kedalam tabel_user }
    { PARAMETER : array of string }
    { RETURN    : data user }

    { KAMUS LOKAL }
    var
      row: integer;
      temp: string;
      c: char;
      data_tempuser : tabel_user;
      countcomma, amountcomma : integer;
    { ALGORITMA }
    begin
      data_tempuser.sz := 0;      
      for row:=0 to s.sz-1 do
      begin
        temp := '';
        countcomma := 0;
        for c in s.st[row] do
        begin
            if (c=',') then countcomma := countcomma + 1;
        end;
        amountcomma := countcomma;
        for c in s.st[row] do
        begin
            if (c=',') then
            begin
                if (amountcomma = countcomma) then
                    begin
                    data_tempuser.t[data_tempuser.sz].Nama := temp;
                    countcomma := countcomma - 1;
                    temp := '';
                    end else
                if (countcomma > 3) then
                    begin
                    temp := temp+c;
                    countcomma := countcomma - 1;
                    end else
                if (countcomma = 3) then
                    begin
                    data_tempuser.t[data_tempuser.sz].Alamat := temp;
                    countcomma := countcomma - 1;
                    temp := '';
                    end else
                if (countcomma = 2) then
                    begin
                    data_tempuser.t[data_tempuser.sz].Username := temp;
                    countcomma := countcomma - 1;
                    temp := '';
                    end else
                if (countcomma = 1) then
                    begin
                    data_tempuser.t[data_tempuser.sz].Password := temp;
                    countcomma := countcomma - 1;
                    temp := '';
                    end else
            end else temp := temp+c;
        end;  
        data_tempuser.t[data_tempuser.sz].Role := temp;
        data_tempuser.sz := data_tempuser.sz+1;        
      end;
      tambah := data_tempuser;
    end;

function konversi_csv(data_tempuser: tabel_user): arr_str;
    { DESKRIPSI : Fungsi untuk mengubah data user menjadi array of string }
    { PARAMETER : data user }
    { RETURN    : array of string }

    { KAMUS LOKAL }
    var
        i : integer;
        ret : arr_str;
    { ALGORITMA }
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

procedure print(data_tempuser: tabel_user);
    { DESKRIPSI : Prosedur sederhana yang digunakan pada proses pembuatan program untuk debugging, prosedur ini mencetak data ke layar }
    { PARAMETER : Data yang akan dicetak }
    var
     i: integer;
    begin
        for i:=0 to data_tempuser.sz-1 do
        begin
            writeln(data_tempuser.t[i].Nama, ' | ', data_tempuser.t[i].Alamat, ' | ', data_tempuser.t[i].Username, ' | ', data_tempuser.t[i].Password, ' | ', data_tempuser.t[i].Role);
        end;
    end;

  
end.
