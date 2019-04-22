unit f11_riwayatPeminjaman;

interface
uses 
    utilitas,
    buku_handler,
    peminjaman_handler;

var
    inp : string;

procedure filter(var data_bersih : tabel_peminjaman; data_kotor : tabel_peminjaman; inputan : string);
procedure urutkan(var data_input : tabel_peminjaman);
procedure cetak(var data_buku : tabel_buku; data_input : tabel_peminjaman);
procedure lihathistory(data_buku :tabel_buku; data_peminjaman : tabel_peminjaman);
function cek_judul(var data_buku : tabel_buku; inp : string) : string;

implementation
procedure filter(var data_bersih : tabel_peminjaman; data_kotor : tabel_peminjaman; inputan : string);
    var 
        i: integer;
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
    

procedure urutkan(var data_input : tabel_peminjaman);
    var
        i, j, rc : integer;
        temp : peminjaman;
    begin
        rc := data_input.sz;
        for i:=1 to rc do
        begin
            for j := 1 to rc-i-1 do
            begin
                if(data_input.t[j].tanggal_peminjaman > data_input.t[j+1].tanggal_peminjaman) then
                begin
                    temp := data_input.t[j];
                    data_input.t[j] := data_input.t[j+1];
                    data_input.t[j+1] := temp;
                end;
            end;
        end;
    end;

function cek_judul(var data_buku : tabel_buku; inp : string) : string; // oke
    var
        i : integer;
    begin
        for i:= 1 to data_buku.sz do
        begin
            if(inp = data_buku.t[i].ID_Buku) then cek_judul := data_buku.t[i].Judul_Buku
        end;
    end;
procedure cetak(var data_buku : tabel_buku; data_input : tabel_peminjaman);
    var
        i : integer;
    begin
        for i := 1 to data_input.sz-1 do
        begin
            writeln(data_input.t[i].tanggal_peminjaman, ' | ', data_input.t[i].ID_Buku, ' | ', cek_judul(data_buku,data_input.t[i].ID_Buku));
        end;
    end;

procedure lihathistory(data_buku :tabel_buku; data_peminjaman : tabel_peminjaman);
    var
        data_bersih : tabel_peminjaman;
    begin
        write('Masukkan username pengunjung: ');
        readln(inp);
        data_bersih.sz := 0;
        filter(data_bersih, data_peminjaman, inp);
        if(data_bersih.sz=1) then writeln('Tidak ada peminjaman oleh user ini.')
        else 
        begin
            // urutkan(data_bersih);
            cetak(data_buku,data_bersih);
        end;
    end;
end.
