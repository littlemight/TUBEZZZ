unit f04_findYear;

interface
uses
    utilitas,
    buku_handler,
    f03_findCategory; // menggunakan prosedur urut

var
    tahun : integer;
    inp : string;

procedure filter_tahun(var data_bersih : tabel_buku; data_kotor : tabel_buku; tahun : integer; inp : string);
function cek_tahun(val: integer; tahun: integer;inp: string) : boolean;
procedure cari_tahun(data_input : tabel_buku);

implementation
function cek_tahun(val: integer; tahun: integer; inp: string) : boolean;
    begin
        case inp of 
            '<': cek_tahun := val < tahun;
            '<=': cek_tahun := val <= tahun;
            '>': cek_tahun := val > tahun;
            '>=': cek_tahun := val >= tahun;
            else cek_tahun := val = tahun;
        end;
    end;

procedure filter_tahun(var data_bersih : tabel_buku; data_kotor : tabel_buku; tahun : integer; inp : string);
    var 
        i : integer;
    begin
        data_bersih.t[0] := data_kotor.t[0];
        data_bersih.sz := data_bersih.sz+1;
        
        for i := 1 to data_kotor.sz-1 do
        begin
            if(cek_tahun(StringToInt(data_kotor.t[i].Tahun_Penerbit), tahun, inp)) then
            begin
                data_bersih.t[data_bersih.sz] := data_kotor.t[i];
                data_bersih.sz := data_bersih.sz+1;
            end;
        end;

    end;

procedure cari_tahun(data_input : tabel_buku);
    var
        data_bersih : tabel_buku;
    begin
        write('Masukkan tahun: ');
        readln(tahun);

        write('Masukkan kategori: ');
        readln(inp);
        writeln();

        writeln('Buku yang terbit ', inp, ' ', tahun, ':');
        filter_tahun(data_bersih, data_input, tahun, inp);
        if(data_bersih.sz=1) then writeln('Tidak ada buku dalam kategori ini.')
        else 
        begin
            urutkan(data_bersih);
            cetak(data_bersih);
        end;
       
    end;
end.