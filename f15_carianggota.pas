unit f15_carianggota;

interface
uses
    user_handler;

procedure cari_anggota(data_user: tabel_user);
implementation
procedure cari_anggota(data_user: tabel_user);
    var
        username: string;
        i : integer;
        temp: user;
    begin
      write('Masukkan username: '); readln(username);
      i := 1;
      while(data_user.t[i].Username <> username) do // dijamin pasti ketemu
      begin
        i := i+1;
      end;

      writeln('Nama Anggota: ', data_user.t[i].Nama);
      writeln('Alamat anggota: ', data_user.t[i].Alamat);
    end;
end.