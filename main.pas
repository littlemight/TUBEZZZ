Program main;

uses
    csv_parser,
    buku_handler,
    tipe_string;

var
    data_buku : tabel_buku;
    inp : string;

procedure load();
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := baca_csv(filename);
            data_buku := buku_handler.tambah(temp);
    end;

begin
    load();
    // test kafir
    // readln(inp);
    // case inp of 
    //     'cari':
    //         begin
    //             cari_kategori(data_buku);  
    //         end;
    //     // 'caritahunterbit':
    //     //     begin
    //     //         cari_tahun(data_buku);
    //     //     end;
    // end;
    // goblok
end.