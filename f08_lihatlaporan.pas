unit f08_lihatlaporan;

interface
uses
    utilitas,
    buku_handler,
    kehilangan_handler;

procedure lihat_hilang(data_buku: tabel_buku; data_kehilangan: tabel_kehilangan);

implementation
procedure lihat_hilang(data_buku: tabel_buku; data_kehilangan: tabel_kehilangan);
    var
        i, book_idx: integer;
    begin
    if (data_kehilangan.sz = 1) then writeln('Tidak ada laporan buku yang hilang') else 
      begin 
      writeln('Buku yang hilang :');
      for i:=1 to data_kehilangan.sz-1 do
      begin
        book_idx := findID(data_buku, data_kehilangan.t[i].ID_Buku);
        writeln(data_kehilangan.t[i].ID_Buku, ' | ', data_buku.t[book_idx].Judul_Buku, ' | ', data_kehilangan.t[i].Tanggal_Laporan);
      end;
    end;
    end;
end.
