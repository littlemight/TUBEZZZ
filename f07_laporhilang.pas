unit f07_laporhilang;

interface
uses
    kehilangan_handler,
    utilitas;

procedure lapor(var data_kehilangan: tabel_kehilangan; username: String);

implementation
procedure lapor(var data_kehilangan: tabel_kehilangan; username: String);
    var
        id, judul, tanggal: string;
        temp: kehilangan;
    begin
      writeln('Masukkan id buku: '); readln(id);
      writeln('Masukkan judul buku: '); readln(judul);
      writeln('Masukkan tanggal pelaporan: '); readln(tanggal);
      writeln('');
      
      temp.Username := username;
      temp.ID_Buku := id;
      temp.Tanggal_Laporan := tanggal;

      data_kehilangan.sz := data_kehilangan.sz+1;
      data_kehilangan.t[data_kehilangan.sz-1] := temp;
      
      writeln('Laporan berhasil diterima.');
    end;
end.