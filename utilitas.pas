unit utilitas;

interface

function StringToInt(str: String): integer;
function StringToInt64(str: String): int64;


implementation
function StringToInt(str: String): integer;
    var
        temp : Int64;
    begin
      val(str, temp);
      StringToInt := temp;
    end;

function StringToInt64(str: String): int64;
    var
        temp : Int64;
    begin
      val(str, temp);
      StringToInt64 := temp;
    end;
end.