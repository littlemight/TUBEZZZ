unit f04_findYear;

interface
uses
    csvdocument,
    sysutils,
    f03_findCategory;

var
    tahun : integer;
    inp : string;

procedure filter_tahun(var data_bersih : TCSVDocument; data_kotor : TCSVDocument; tahun : integer; inp : string; rc : integer);
function cek_tahun(val: integer; tahun: integer;inp: string) : boolean;
procedure cari_tahun(data_input : TCSVDocument);

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
procedure filter_tahun(var data_bersih : TCSVDocument; data_kotor : TCSVDocument; tahun : integer; inp : string; rc : integer);
    var 
        i, j, k: integer;
    begin
        data_bersih := TCSVDocument.create();
        data_bersih.AddRow(data_kotor.cells[0,0]);
        
        for j := 1 to 5 do
        begin
            data_bersih.InsertCell(j, 0, data_kotor.cells[j,0]);
        end;

        k := 1;
        for i := 1 to rc-1 do
        begin
            if(cek_tahun(StrToInt(data_kotor.cells[4,i]), tahun, inp)) then
            begin
                data_bersih.InsertRow(k, data_kotor.cells[0,i]);
                for j := 1 to 5 do
                begin
                    data_bersih.InsertCell(j, k, data_kotor.cells[j,i]);
                end;
                k := k+1;
            end;
        end;
    end;

procedure cari_tahun(data_input : TCSVDocument);
    var
        rc : integer;
        data_bersih : TCSVDocument;
    begin
        write('Masukkan tahun: ');
        readln(tahun);

        write('Masukkan kategori: ');
        readln(inp);
        writeln();

        writeln('Buku yang terbit ', inp, ' ', tahun, ':');
        rc := data_input.RowCount;
        filter_tahun(data_bersih, data_input, tahun, inp, rc);
        rc := data_bersih.RowCount;
        if(rc <> 0) then
        begin
            urutkan(data_bersih);
            cetak(data_bersih);
        end else writeln('Tidak ada buku dalam kategori ini.')
       
    end;
end.