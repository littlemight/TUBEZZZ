program Project1;
uses crt;

var
  temp : String;
  inp   : char;

begin
  write('Password : ');
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
  writeln('Password anda : ',temp);

end.