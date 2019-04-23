unit csv_parser;

interface
uses
    buku_handler,
    tipe_data;

{ DEKLARASI FUNGSI DAN PROSEDUR }
function baca_csv(filename: string): arr_str;
procedure simpan_csv(filename: string; stList: arr_str);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure simpan_csv(filename: string; stList: arr_str);
    { DESKRIPSI : Prosedur untuk menyimpan file csv dari array of string }
    { PARAMETER : Nama file yang disimpan dan array of string yang menjadi data tiap baris }

    { KAMUS LOKAL }
    var
        Userfile: text;
        i : integer;
    { ALGORITMA }
    begin
        Assign(Userfile, filename);
        Rewrite(Userfile); // write mode
        for i := 0 to stList.sz-1 do
        begin
            writeln(Userfile, stList.st[i]);
        end;
        close(userfile);
    end;

function baca_csv(filename: string): arr_str;
    { DESKRIPSI : Prosedur untuk membaca file csv dan memasukkan ke dalam array of string, yang akan di handle oleh masing-masing handler data seperti buku_handler, pengembalian_handler, dan lainnya }
    { PARAMETER : Nama file yang di baca }
    { RETURN    : array of string yang menjadi placeholder data }

    { KAMUS LOKAL }
    var
        input : string;
        userfile: text;
        ret: arr_str;

    { ALGORITMA }
    begin
        assign(userfile, filename);
        reset(userfile); // read only mode

        ret.sz := 0;
        repeat
            readln(userfile, input);
            ret.st[ret.sz] := input;
            ret.sz := ret.sz+1;
        until EOF(userfile);
        close(userfile);
        baca_csv := ret;
    end;

end.