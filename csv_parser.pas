unit csv_parser;

interface
uses
    buku_handler,
    tipe_string;

function baca_csv(filename: string): arr_str;
procedure simpan_csv(filename: string; stList: arr_str);

implementation

procedure simpan_csv(filename: string; stList: arr_str);
    var
        Userfile: text;
        i : integer;
    begin
        Assign(Userfile, filename);
        Rewrite(Userfile); // write mode
        for i := 0 to stList.sz-1 do
        begin
            writeln(Userfile, stList.st[i]);
        end;
        Close(userfile);
    end;

function baca_csv(filename: string): arr_str;
    var
        input : string;
        userfile: text;
        ret: arr_str;
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