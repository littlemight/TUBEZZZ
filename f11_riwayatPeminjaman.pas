unit f11_riwayatPeminjaman;

interface
uses 
    utilitas,
    buku_handler,
    peminjaman_handler;

{ KAMUS }
var
    inp : string;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure filter(var data_bersih : tabel_peminjaman; data_kotor : tabel_peminjaman; inputan : string);
procedure cetak(var data_buku : tabel_buku; data_input : tabel_peminjaman);
procedure lihathistory(data_buku :tabel_buku; data_peminjaman : tabel_peminjaman);
function cek_judul(var data_buku : tabel_buku; inp : string) : string;

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure filter(var data_bersih : tabel_peminjaman; data_kotor : tabel_peminjaman; inputan : string);
    { DESKRIPSI : Membersihkan data kotor menjadi data bersih sesuai dengan inputan }
    { PARAMETER : data bersih, data kotor, dan inputan yang sesuai }

    { KAMUS LOKAL }
    var 
        i: integer;
    
    { ALGORITMA }
    begin
        data_bersih.t[0] := data_kotor.t[0];
        data_bersih.sz := data_bersih.sz+1;

        for i := 1 to data_kotor.sz-1 do
        begin
            if((data_kotor.t[i].Username = inputan)) then
            begin
                data_bersih.t[data_bersih.sz] := data_kotor.t[i];
                data_bersih.sz := data_bersih.sz+1;
            end;
        end;
    end;

function cek_judul(var data_buku : tabel_buku; inp : string) : string;
    { DESKRIPSI : Mencari data buku dengan id sesuai dengan inputan }
    { PARAMETER : data buku dan input }
    { RETURN    : judul buku }

    { KAMUS LOKAL }
    var
        i : integer;
    
    { ALGORITMA }
    begin
        for i:= 1 to data_buku.sz do
        begin
            if(inp = data_buku.t[i].ID_Buku) then cek_judul := data_buku.t[i].Judul_Buku
        end;
    end;

procedure cetak(var data_buku : tabel_buku; data_input : tabel_peminjaman);
    { DESKRIPSI : Mencetak data }
    { PARAMETER : data buku dan input }

    { KAMUS LOKAL }
    var
        i : integer;
    { ALGORITMA }
    begin
        for i := 1 to data_input.sz-1 do
        begin
            writeln(data_input.t[i].tanggal_peminjaman, ' | ', data_input.t[i].ID_Buku, ' | ', cek_judul(data_buku,data_input.t[i].ID_Buku));
        end;
    end;

procedure lihathistory(data_buku :tabel_buku; data_peminjaman : tabel_peminjaman);
    { DESKRIPSI : Melihat history peminjaman dari pengguna }
    { PARAMETER : data buku dan data peminjaman }

    { KAMUS LOKAL }
    var
        data_bersih : tabel_peminjaman;
    
    { ALGORITMA }
    begin
        write('Masukkan username pengunjung: ');
        readln(inp);
        data_bersih.sz := 0;
        filter(data_bersih, data_peminjaman, inp);
        if(data_bersih.sz=1) then writeln('Tidak ada peminjaman oleh user ini.')
        else cetak(data_buku, data_bersih);
    end;
end.
