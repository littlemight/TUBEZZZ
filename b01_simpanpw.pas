unit b01_simpanpw;

interface
  uses
    utilitas;
  const
    p1 = 197;
    p2 = 233;
    m1 = 1000000009;
    m2 = 1000000007;

function getLength(password: String): Integer;
function hash1(password: String): Int64;
function hash2(password: String): Int64;
function rollHash(password: String): String;

implementation
function getLength(password: String): Integer;
  var
    c: char;
    panjang: integer = 0;
  begin
    for c in password do
    begin
      panjang := panjang+1;
    end;
    getLength := panjang;
  end;
  
function hash1(password: String): Int64;
  var
    hash_val, p_pow: Int64;
    c: char;
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
  var
    i: integer;
    hash_val, p_pow: Int64;
    panjang: integer;
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
    var
      angka: Int64;
    begin
      angka := (hash1(password) << 32) or hash2(password);
      rollHash := Int64ToString(angka);
    end;
end.
