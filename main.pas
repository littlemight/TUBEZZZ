Program main;

uses
    csv_parser,
    buku_handler,
    user_handler,
    f03_findCategory,
    f04_findYear,
    tipe_string;

var
    data_buku : tabel_buku;
    data_user : tabel_user;
    inp : string;

procedure load();
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := baca_csv(filename);
            data_buku := buku_handler.tambah(temp);
        write('Masukkan nama File User: '); readln(filename);
            temp := baca_csv(filename);
            data_user := user_handler.tambah(temp);
    end;

begin
    load();
    readln(inp);
    if(inp='exit') then writeln('keluar ya gan') else
    begin
        while(inp <> 'exit') do
        begin
            case inp of 
            'cari':
                begin
                    cari_kategori(data_buku);  
                end;
            'caritahunterbit':
                begin
                    cari_tahun(data_buku);
                end;
            end; 
            readln(inp); 
        end;

        if(inp='exit') then writeln('keluar ya gan');
    end;
end.