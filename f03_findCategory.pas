unit f03_findCategory;

interface
uses 
    utilitas,
    buku_handler;

var
    inp : string;
    kategori : array [1..5] of string = ('sastra','sains','manga','sejarah','programming');

procedure filter_kategori(var data_bersih : tabel_buku; data_kotor : tabel_buku; kategori_valid : string);
function cek_kategori(inp : string) : boolean;
procedure urutkan(var data_input : tabel_buku);
procedure cetak(data_input : tabel_buku);
procedure cari_kategori(data_buku : tabel_buku);

implementation
procedure filter_kategori(var data_bersih : tabel_buku; data_kotor : tabel_buku; kategori_valid : string);
    var 
        i: integer;
    begin
        data_bersih.t[0] := data_kotor.t[0];
        data_bersih.sz := data_bersih.sz+1;

        for i := 1 to data_kotor.sz-1 do
        begin
            if((data_kotor.t[i].Kategori = kategori_valid)) then
            begin
                // writeln('ok');
                data_bersih.t[data_bersih.sz] := data_kotor.t[i];
                data_bersih.sz := data_bersih.sz+1;
            end;
        end;
    end;
    
function cek_kategori(inp : string) : boolean; // oke
    var
        i : integer;
        found : boolean;
    begin
        found := false;
        i := 1;

        while((found <> true) and (i <= 5)) do
        begin
            if(inp = kategori[i]) then found := true else i := i + 1;
        end;

        cek_kategori := found;
    end;

procedure urutkan(var data_input : tabel_buku);
    var
        i, j, rc : integer;
        temp : buku;
    begin
        rc := data_input.sz;
        for i:=1 to rc do
        begin
            for j := 1 to rc-i-1 do
            begin
                if(data_input.t[j].Judul_Buku > data_input.t[j+1].Judul_Buku) then
                begin
                    temp := data_input.t[j];
                    data_input.t[j] := data_input.t[j+1];
                    data_input.t[j+1] := temp;
                end;
            end;
        end;
    end;
procedure cetak(data_input : tabel_buku);
    var
        i : integer;
    begin
        writeln(data_input.sz);
        for i := 1 to data_input.sz-1 do
        begin
            writeln(data_input.t[i].ID_Buku, ' | ', data_input.t[i].Judul_Buku, ' | ', data_input.t[i].Author);
        end;
    end;

procedure cari_kategori(data_buku : tabel_buku);
    var
        data_bersih : tabel_buku;
    begin
        write('Masukkan kategori: ');
        readln(inp);
        while(cek_kategori(inp)<>true) do
        begin
            writeln('Kategori ', inp, ' tidak valid.');
            write('Masukkan kategori: ');
            readln(inp);
        end;

        data_bersih.sz := 0;
        filter_kategori(data_bersih, data_buku, inp);
        if(data_bersih.sz=1) then writeln('Tidak ada buku dalam kategori ini.')
        else 
        begin
            urutkan(data_bersih);
            cetak(data_bersih);
        end;
    end;
end.