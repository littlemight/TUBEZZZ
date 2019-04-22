unit utilitas;

interface
uses
  crt,
  intro,
  buku_handler,
  tipe_data;

const
  waktu_denda = 7;

// General integer utility
function StringToInt(str: String): integer;
function StringToInt64(str: String): int64;
function IntToString(angka: Integer): string;
function Int64ToString(angka: Int64): string;

// General date utility
function TanggalToString(date: tanggal): string;
function StringToTanggal(str: String): tanggal;
function CekKabisat(tahun: integer): boolean;
function TambahDenda(tgl: string): string;
function HitungKabisat(tgl: tanggal): integer;
function BedaHari(awal, akhir: String): integer;

// General boolean utility
function StringToBool(str: String): boolean;
function BoolToString(bol: Boolean): string;

// General Search Utility
function findID(tabel : tabel_buku; id: string): integer;

// Password Masking Utility
function tutupinInput : string;

// Menu utility
procedure clrscr1();
procedure end_of_submenu(var inp : Char);
procedure load_menu_admin();
procedure load_menu_pengunjung();

implementation
function StringToInt(str: String): integer;
    var
        temp, ref, i : integer;
    begin
      ref := ord('0');
      temp := 0;
      for i:=1 to length(str) do 
      begin
        if(i<>1) then temp := temp*10;
        temp := temp + ord(str[i])-ref;
      end;

      StringToInt := temp;
    end;

function StringToInt64(str: String): int64;
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

function Int64ToString(angka: Int64): string;
  var
    temp : string;
  begin
    str(angka, temp);
    Int64ToString := temp;
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
    TanggalToString := ret;
  end;

function CekKabisat(tahun: integer): boolean;
  begin
    CekKabisat := ((tahun mod 4=0) and (tahun mod 100<>0)) or (tahun mod 400=0);
  end;

function TambahDenda(tgl: string): string;
  var
    hariUtkBulan: array [1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
    cur, ret: tanggal;
  begin
    cur := StringToTanggal(tgl);
    if(CekKabisat(cur.tahun)) then hariUtkBulan[2] := hariUtkBulan[2]+1;

    ret.hari := (cur.hari + waktu_denda) mod hariUtkBulan[cur.bulan];
    if(ret.hari = 0) then ret.hari := hariUtkBulan[cur.bulan];
    ret.bulan := (cur.bulan + (cur.hari + waktu_denda) div hariUtkBulan[cur.bulan]) mod 12;
    if(ret.bulan = 0) then ret.bulan := 12;
    ret.tahun := cur.tahun;
    if((cur.bulan + (cur.hari + waktu_denda) div hariUtkBulan[cur.bulan]) <> 12) then
      ret.tahun := ret.tahun + (cur.bulan + (cur.hari + waktu_denda) div hariUtkBulan[cur.bulan]) div 12;

    TambahDenda := TanggalToString(ret);
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

// function cari buku berdasarkan ID , function mengembalikan indeksnya
function findID(tabel : tabel_buku; id: string): integer;
	var
		i : integer;
    found: boolean = false;
	begin
    i := 1;
		while((i < tabel.sz) and (found <> true)) do
		begin
			if (tabel.t[i].ID_Buku=id) then
      begin
        findID := i;
        found := true;
      end else i := i+1;
		end;
    if(found = False) then findID := -1;
	end;

// function findID(tabel : tabel_buku; id: string): integer;
// 	var
// 		i : integer;
// 	begin
// 		for i := 1 to tabel.sz do
// 		begin
// 			if (tabel.t[i].ID_Buku=id) then
// 				begin
// 					findID := i;
// 				end;
// 		end;
//     writeln('h ',findID);
	// end;
  
function tutupinInput : string;
    var
    inp : Char;
    temp : string;

    begin
      temp := '';

      repeat
        begin
          inp :=ReadKey;
          
          if (inp<>#13) then
          begin
            if (inp=#8) then
            begin
              if (length(temp)<>0) then
              begin
                Delete(temp,Length(temp),1);
                write(inp);
                ClrEol;
              end;
            end else
            begin
              temp := temp + inp;
              write('*') 
            end;
          end;
        end;
      until (inp=#13);
      writeln();
      tutupinInput := temp;
    end;

procedure clrscr1();
    begin
      clrscr();
      printOwl();
    end;

procedure end_of_submenu(var inp : Char);
    begin
    writeln;
    writeln('Press Any Key to Proceed');
    inp := readkey;
    clrscr1();
    end;
  
procedure load_menu_admin();
	begin
	writeln('Menu: ');
	writeln('1. register : registrasi akun');
	writeln('2. cari : mencari buku berdasarkan kategori');
	writeln('3. caritahunterbit : mencari buku berdasarkan tahun terbit.');
	writeln('4. lihat_laporan : melihat laporan buku yang hilang');
	writeln('5. tambah_buku : menambahkan buku baru');
	writeln('6. tambah_jumlah_buku : menambahkan sejumlah buku lama');
	writeln('7. statistik : meliat statistik user dan buku perkategori');
	writeln('8. save : menyimpan perubahan data');
	writeln('9. cari_anggota : mencari data nama dan alamat anggota');
	writeln('10. riwayat : melihat riwayat peminjaman buku oleh seorang pengunjung');
	writeln('11. exit : keluar dari program');
	writeln('Masukkan pilihan Anda: ');
	end;

procedure load_menu_pengunjung();
	begin
	writeln('Menu: ');
	writeln('1. cari : mencari buku berdasarkan kategori');
	writeln('2. save : menyimpan perubahan data');
	writeln('3. caritahunterbit : mencari buku berdasarkan tahun terbit.');
	writeln('4. pinjam_buku : meminjam satu buku');
	writeln('5. lapor_hilang : melaporkan buku yang hilang');
	writeln('6. kembalikan_buku : mengembalikan buku');
	writeln('7. exit : keluar dari program');
	writeln('Masukkan pilihan Anda: ');
	end;

end.