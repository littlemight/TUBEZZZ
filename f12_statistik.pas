unit f12_statistik;

interface
uses
    user_handler,
    buku_handler;

{ DEKLARASI FUNGSI DAN PROSEDUR }
procedure getStatistik(data_user: tabel_user; data_buku: tabel_buku);

{ IMPLEMENTASI FUNGSI DAN PROSEDUR }
implementation
procedure getStatistik(data_user: tabel_user; data_buku: tabel_buku);
    { DESKRIPSI : Mencetak statistik dari data yang ada }
    { PARAMETER : data user dan data buku }

    { KAMUS LOKAL }
    var
        cnt_admin,
        cnt_pengunjung,
        total_user,
        i,
        cnt_sastra,
        cnt_sains,
        cnt_manga,
        cnt_sejarah,
        cnt_programming,
        total_buku: integer;
    { ALGORITMA }
    begin
      cnt_admin := 0;
      cnt_pengunjung := 0;

      for i:=1 to data_user.sz-1 do
      begin
        if(data_user.t[i].Role='Admin') then cnt_admin := cnt_admin+1 else cnt_pengunjung := cnt_pengunjung+1;
      end;
      total_user := cnt_admin + cnt_pengunjung;
      
      cnt_sastra := 0;
      cnt_sains := 0;
      cnt_manga := 0;
      cnt_sejarah := 0;
      cnt_programming := 0;
      for i:=1 to data_buku.sz-1 do
      begin
        case data_buku.t[i].Kategori of 
            'sastra': cnt_sastra := cnt_sastra+1;
            'sains': cnt_sains := cnt_sains+1;
            'manga': cnt_manga := cnt_manga+1;
            'sejarah': cnt_sejarah := cnt_sejarah+1;
            else cnt_programming := cnt_programming+1;
        end;
      end;
      total_buku := cnt_sastra + cnt_sains + cnt_manga + cnt_sejarah + cnt_programming;

      writeln('Pengguna:');
      writeln('Admin | ', cnt_admin);
      writeln('Pengunjung | ', cnt_pengunjung);
      writeln('Total | ', total_user);

      writeln('Buku:');
      writeln('sastra | ', cnt_sastra);
      writeln('sains | ', cnt_sains);
      writeln('manga | ', cnt_manga);
      writeln('sejarah | ', cnt_sejarah);
      writeln('programming | ', cnt_programming);
      writeln('Total | ', total_buku);
    end;  
end.