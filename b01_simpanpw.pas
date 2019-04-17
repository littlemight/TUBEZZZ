unit b01_simpanpw;

interface
uses
    utilitas;
function rollHash(password: String): String;

implementation
function rollHash(password: String): String;
    const
        p = 53;
        m = 1000000009;
    var
        hash_val, p_pow: Int64;
        c: char;
    begin
      hash_val := 0;
      p_pow := 1;

      for c in password do
      begin
        hash_val := (hash_val + ord(c)*p_pow) mod m;
        p_pow := (p_pow*p) mod m; 
      end;

      rollHash := Int64ToString(hash_val);
    end;
end.