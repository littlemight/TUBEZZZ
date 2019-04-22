unit f04_findYear;

interface
uses
    utilitas,
    buku_handler,
    f03_findCategory; // menggunakan prosedur urut dan cetak yang ada di unit f03_findCategory

{ KAMUS }
var
    tahun : integer;
    inp : string;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure filter_tahun(var data_bersih : tabel_buku; data_kotor : tabel_buku; tahun : integer; inp : string);
function cek_tahun(val: integer; tahun: integer;inp: string) : boolean;
procedure cari_tahun(data_input : tabel_buku);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
function cek_tahun(val: integer; tahun: integer; inp: string) : boolean;
    { DESKRIPSI	: fungsi untuk memeriksa apakah tahun val sesuai dengan kategori inp untuk tahun }
	{ PARAMETER	: val, tahun, berupa tipe integer, dan inp berupa tipe string }
    { RETURN    : boolean }

    { ALGORITMA }
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
    { DESKRIPSI	: prosedur untuk memfilter data_kotor sehingga menjadi data_bersih dengan isi data sesuai dengan kategori untuk tahun }
	{ PARAMETER	: data_bersih dan data_kotor dengan tipe bentukan tabel_buku, tahun bertipe integer, dan inp bertipe string }

    { KAMUS LOKAL }
    var 
        i : integer;
    
    { ALGORITMA }
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
    { DESKRIPSI	: prosedur untuk mencari buku sesuai dengan kategori tahun dan mencetaknya ke layar }
	{ PARAMETER	: data_buku berupa tipe bentukan tabel_buku }

    { KAMUS LOKAL }
    var
        data_bersih : tabel_buku;

    { ALGORITMA }
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