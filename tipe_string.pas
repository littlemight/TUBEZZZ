unit tipe_string;

interface
const
    nmax = 1000;
type
  arr_str = record
                st : array [0..nmax] of string;
                sz : integer; //effective size
            end;

implementation

end.