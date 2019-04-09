Program main;

uses
    csv_parser,
    buku_handler,
    f03_findCategory,
    f04_findYear,
    tipe_string;

var
    data_buku : tabel_buku;
    inp : string;

// f13 load, mungkin bakal dibikin unit sendiri, liat nanti
procedure load();
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := baca_csv(filename);
            data_buku := buku_handler.tambah(temp);
    end;

// f14 save, same with 13
procedure save();  
    var
        temp : arr_str;
        filename : string;
    begin
        write('Masukkan nama File Buku: '); readln(filename);
            temp := buku_handler.konversi_csv(data_buku);
            simpan_csv(filename, temp);
        
        writeln('Data berhasil disimpan!');
    end;
begin
    load();
    // save();
    readln(inp);
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
end.
