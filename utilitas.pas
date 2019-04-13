unit utilitas;

interface
uses
  tipe_data;

function StringToInt(str: String): integer;
function StringToInt64(str: String): int64;
function IntToString(angka: Integer): string;
function TanggalToString(date: tanggal): string;
function StringToTanggal(str: String): tanggal;
function cekKabisat(tahun: integer): boolean;
function TambahMinggu(tgl: string): string;
function BedaHari(tgl1, tgl2: String): integer;

implementation
function StringToInt(str: String): integer;
    var
        temp, ref, i : integer;
    begin
      // val(str, temp);
      // StringToInt := temp;
      ref := ord('0');
      temp := 0;
      for i:=1 to length(str) do 
      begin
        if(i<>1) then temp := temp*10;
        temp := temp + ord(str[i])-ref;
      end;

      StringToInt := temp;
    end;

function StringToInt64(str: String): int64; // longer range, viable for hashing(?)
    var
        temp : Int64;
    begin
      val(str, temp);
      StringToInt64 := temp;
    end;
  
function IntToString(angka: Integer): string;
  var
    temp : string;
  begin
    str(angka, temp);
    IntToString := temp;
  end;

function StringToTanggal(str: String): tanggal;
  var
    temp: tanggal;
    tempstr: string;
    c: char;
    col: integer;
  begin
    tempstr := '';
    col := 0;
    for c in str do
    begin
      if(c<>'/') then tempstr := tempstr + c else
      begin
        case col of
          0: temp.hari := StringToInt(tempstr);
          1: temp.bulan := StringToInt(tempstr);
        end;
        tempstr := '';
        col := col+1;
      end;
    end;
    temp.tahun := StringToInt(tempstr);
    writeln(temp.hari,'/',temp.bulan,'/',temp.tahun);

    StringToTanggal := temp;
  end;

function TanggalToString(date: tanggal): string;
  var
    ret, tempstr: string;
    i: integer;

  begin
    ret := '';
    tempstr := IntToString(date.hari);
    if(length(tempstr)=1) then tempstr := '0'+tempstr;
    ret := ret+tempstr+'/';

    tempstr := IntToString(date.bulan);
    if(length(tempstr)=1) then tempstr := '0'+tempstr;
    ret := ret+tempstr+'/';

    tempstr := IntToString(date.tahun);
    if(length(tempstr)<4) then
    begin
      for i:=1 to 4-length(tempstr) do
      begin
        tempstr := '0'+tempstr;
      end;
    end;
    ret := ret+tempstr;

    writeln(ret);
    TanggalToString := ret;
  end;

function cekKabisat(tahun: integer): boolean;
  begin
    cekKabisat := ((tahun mod 4=0) and (tahun mod 100<>0)) or (tahun mod 400=0);
  end;

function TambahMinggu(tgl: string): string;
  var
    hariUtkBulan: array [1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
    cur, ret: tanggal;
  begin
    cur := StringToTanggal(tgl);
    if(cekKabisat(cur.tahun)) then hariUtkBulan[2] := hariUtkBulan[2]+1;
    ret.hari := (cur.hari + 7) mod hariUtkBulan[cur.bulan];
    if(ret.hari = 0) then ret.hari := hariUtkBulan[cur.bulan];
    ret.bulan := (cur.bulan + (cur.hari + 7) div hariUtkBulan[cur.bulan]) mod 12;
    if(ret.bulan = 0) then ret.bulan := 12;
    ret.tahun := cur.tahun + (cur.bulan + (cur.hari + 7) div hariUtkBulan[cur.bulan]) div 12;

    writeln(TanggalToString(ret));

    TambahMinggu := TanggalToString(ret);
  end;

function BedaHari(tgl1, tgl2: String): integer;
  var:
    con1, con2: tanggal;
    
end.