unit utilitas;

interface
uses
  tipe_data;

// General integer utility
function StringToInt(str: String): integer;
function StringToInt64(str: String): int64;
function IntToString(angka: Integer): string;

// General date utility
function TanggalToString(date: tanggal): string;
function StringToTanggal(str: String): tanggal;
function CekKabisat(tahun: integer): boolean;
function TambahMinggu(tgl: string): string;
function HitungKabisat(tgl: tanggal): integer;
function BedaHari(awal, akhir: String): integer;

// General boolean utility
function StringToBool(str: String): boolean;
function BoolToString(bol: Boolean): string;

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

function CekKabisat(tahun: integer): boolean;
  begin
    CekKabisat := ((tahun mod 4=0) and (tahun mod 100<>0)) or (tahun mod 400=0);
  end;

function TambahMinggu(tgl: string): string;
  var
    hariUtkBulan: array [1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
    cur, ret: tanggal;
  begin
    cur := StringToTanggal(tgl);
    if(CekKabisat(cur.tahun)) then hariUtkBulan[2] := hariUtkBulan[2]+1;
    ret.hari := (cur.hari + 7) mod hariUtkBulan[cur.bulan];
    if(ret.hari = 0) then ret.hari := hariUtkBulan[cur.bulan];
    ret.bulan := (cur.bulan + (cur.hari + 7) div hariUtkBulan[cur.bulan]) mod 12;
    if(ret.bulan = 0) then ret.bulan := 12;
    ret.tahun := cur.tahun + (cur.bulan + (cur.hari + 7) div hariUtkBulan[cur.bulan]) div 12;

    writeln(TanggalToString(ret));

    TambahMinggu := TanggalToString(ret);
  end;

function HitungKabisat(tgl: tanggal): integer;
  var
    thn: integer;
  begin
    thn := tgl.tahun;
    if(tgl.bulan <= 2) then thn := thn-1;
    HitungKabisat := (thn div 4) - (thn div 100) + (thn div 400);
  end;

function BedaHari(awal, akhir: String): integer;
  var
    hariUtkBulan: array [1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
    tmp1, tmp2: tanggal;
    day1, day2 : Int64;
    i : integer;
  begin
    tmp1 := StringToTanggal(awal);
    tmp2 := StringToTanggal(akhir);

    day1 := tmp1.tahun*365 + tmp1.hari;
    for i := 1 to tmp1.bulan-1 do
    begin
      day1 := day1 + hariUtkBulan[i];
    end;

    day1 := day1 + HitungKabisat(tmp1);

    day2 := tmp2.tahun*365 + tmp2.hari;
    for i := 1 to tmp2.bulan-1 do
    begin
      day2 := day2 + hariUtkBulan[i];
    end;

    day2 := day2 + HitungKabisat(tmp2);

    BedaHari := day2-day1;
  end;

function StringToBool(str: String): boolean;
  begin
    if(str='True') then StringToBool := True else StringToBool := False;
  end;  
function BoolToString(bol: Boolean): string;
  begin
    if(bol=True) then BoolToString := 'True' else BoolToString := 'False';
  end;  
end.