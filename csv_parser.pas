unit csv_parser;

interface
uses
    buku_handler,
    tipe_string;

function baca_csv(filename: string): arr_str;
function simpan_csv(tabel_konversi: arr_str, filename: string): Text;

implementation

// procedure simpan_csv(var data_buku: tabel_buku);
//     begin
//         case filename of 
//             'buku.csv': buku_handler.konversi_csv(data_buku);
//             // 'user.csv': user_handler.tambah(data_user, row);
//             // 'peminjaman.csv': peminjaman_handler.tambah(data_peminjaman, row);
//             // 'pengembalian.csv': pengembalian_handler.tambah(data_pengembalian, row);
//             // 'kehilangan.csv': kehilangan_handler.tambah(data_kehilangan, row);
//             end;
//     end;
function baca_csv(filename: string): arr_str;
    var
        input : string;
        userfile: text;
        ret: arr_str;
    begin
        assign(userfile, filename);
        reset(userfile);

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