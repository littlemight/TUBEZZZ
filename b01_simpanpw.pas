unit b01_simpanpw;

interface
  uses
    utilitas;
  const
    p1 = 197; // angka prima untuk hash1
    p2 = 233; // angka prima untuk hash2
    m1 = 1000000009; // modulo untuk hash1
    m2 = 1000000007; // modulo untuk hash2

{ DEKLARASI FUNGSI DAN PROSEDUR }
function getLength(password: String): Integer;
function hash1(password: String): Int64;
function hash2(password: String): Int64;
function rollHash(password: String): String;

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
function getLength(password: String): Integer;
  { DESKRIPSI : Fungsi untuk mencari panjang dari suatu string }
  { PARAMETER : String yang akan dicari panjangnya }
  { RETURN    : Panjang string }

  { KAMUS LOKAL }
  var
    c: char;
    panjang: integer = 0;
  { ALGORITMA }
  begin
    for c in password do
    begin
      panjang := panjang+1;
    end;
    getLength := panjang;
  end;
  
function hash1(password: String): Int64;
  { DESKRIPSI : Fungsi hash pertama untuk hash keseluruhan }
  { PARAMETER : String yang akan di hash }
  { RETURN    : Hasil hash dalam integer 64-bit }

  { KAMUS LOKAL }
  var
    hash_val, p_pow: Int64;
    c: char;
  { ALGORTIMA }
  begin
    hash_val := 0;
    p_pow := 1;

    for c in password do
    begin
      hash_val := (hash_val + (ord(c)-1)*p_pow) mod m1;
      p_pow := (p_pow*p1) mod m1; 
    end;

    hash1 := hash_val;
  end;

function hash2(password: String): Int64;
  { DESKRIPSI : Fungsi hash kedua untuk hash keseluruhan }
  { PARAMETER : String yang akan di hash }
  { RETURN    : Hasil hash dalam integer 64-bit }

  { KAMUS LOKAL }
  var
    i: integer;
    hash_val, p_pow: Int64;
    panjang: integer;
  { ALGORITMA }
  begin
    hash_val := 0;
    p_pow := 1;
    panjang := getLength(password);

    for i := panjang downto 1 do
    begin
      hash_val := (hash_val + (ord(password[i]) + 1)*p_pow) mod m2;
      p_pow := (p_pow*p2) mod m2;
    end;

    hash2 := hash_val;
  end;

function rollHash(password: String): String;
    { DESKRIPSI : Fungsi rollHash menerima sebuah string dan menggunakan dua hash yang di "konkat" untuk mengurangi kemungkinan collision.
                  Hasil hash tersebut diubah ke tipe string agar bisa di simpan di array user }
    { PARAMETER : password yang akan di hash }
    { RETURN    : hasil hash yang sudah dikonversi ke string untuk disimpan}
    var
      angka: Int64;
    begin

      angka := (hash1(password) << 32) or hash2(password); // Hasil dari hash pertama di shift bitwise ke kiri sebanyak 32, dengan 32 bit terakhir digunakan untuk hash kedua
      rollHash := Int64ToString(angka); 
    end;
end.
