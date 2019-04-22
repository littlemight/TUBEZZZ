unit intro;

interface
uses crt;

procedure printOwl();
procedure printWelcome();
procedure welcome();
procedure loading();

implementation
procedure printOwl();
  begin
    writeln('                            ,_.                                                          ,_.');
    writeln('                            ''\cXX.==- __                                        __ -==,XXv/`');
    writeln('                                ~=_X7~ ,/~!g=-,_.                      ,_.-=s!~L. ~TX_=~');
    writeln('                                   ~=c. = /- T--e''T|=v._  ....   _,v=!7`z--\ -\ = ,v=~');
    writeln('                                      ~=c` ./ ,-`,/ /i/Z\/~~~~\/Z\i\ \.''-. \, ''v=~');
    writeln('                                         ~\s,/ ,/ ,/ Y]`/ @/\@ \''[Y \. \. \.g/~');
    writeln('                                            ''`Yc.v`,/Vs)-  \/  -(sV\.''c,v+''`');
    writeln('                                                 ~~]mZczTV ''` VTevZm[~~');
    writeln('                                              ,=-T|--2Y [      ] Y2--!T-=.');
    writeln('                                              ''i`_ -|-''i!      !i`-!- _''i`');
    writeln('                                                ''-s|.cf ,!]\/[!. 1v,!g-`');
    writeln('                                                    ~Y/v/vv..vv\v\Y~');
  end;

procedure printWelcome();
  begin
    writeln('             U _____ u  _        ____   U  ___ u  __  __  U _____ u ');
    writeln(' __        __\| ___"|/ |"|    U /"___|   \/"_ \/U|  \/  |u\| ___"|/ ');
    writeln(' \"\      /"/ |  _|" U | | u  \| | u     | | | |\| |\/| |/ |  _|"   ');
    writeln(' /\ \ /\ / /\ | |___  \| |/__  | |/__.-,_| |_| | | |  | |  | |___   ');
    writeln('U  \ V  V /  U|_____|  |_____|  \____|\_)-\___/  |_|  |_|  |_____|  ');
    writeln('.-,_\ /\ /_,-.<<   >>  //  \\  _// \\      \\   <<,-,,-.   <<   >>  ');
    writeln(' \_)-    -(_/(__) (__)(_")("_)(__)(__)    (__)   (./  \.) (__) (__) ');
	delay(1000);
	clrscr();
    writeln('                    _____   U  ___ u ');
    writeln('                   |_ " _|   \/"_ \/ ');
    writeln('                     | |     | | | | ');
    writeln('                    /| |\.-,_| |_| | ');
    writeln('                   u |_|U \_)-\___/  ');
    writeln('                   _// \\_     \\    ');
    writeln('                  (__) (__)   (__)   ');
    delay(1000);
    clrscr();
    writeln('                             _      _   _     ');
    writeln('             __        __ U  /"\  u | \ |"|    ');
    writeln('             \"\      /"/  \/ _ \/ <|  \| |>   ');
    writeln('             /\ \ /\ / /\  / ___ \ U| |\  |u   ');
    writeln('            U  \ V  V /  U/_/   \_\ |_| \_|    ');
    writeln('            .-,_\ /\ /_,-. \\    >> ||   \\,-. ');
    writeln('             \_)-    -(_/ (__)  (__)(_")  (_/  ');
    delay(1000);
    clrscr();
    writeln('                ____     _   _               ');
    writeln('               / __"| u | | | |     ___      ');
    writeln('              <\___ \/ /| |_| |\   |_"_|     ');
    writeln('               u___) | U|  _  |u    | |      ');
    writeln('               |____/>> |_| |_|   U/| |\u    ');
    writeln('                )(  (__)//   \\.-,_|___|_,-. ');
    writeln('               (__)    (_") ("_)\_)-   -(_/  ');
    delay(1000);
    clrscr();
    writeln('          _____   U  ___ u  _   _     ____   _   ____     ');
    writeln('         |_ " _|   \/"_ \/ | \ |"| U /"___|u|"| / __"| u  ');
    writeln('           | |     | | | |<|  \| |>\| |  _ /|_|<\___ \/   ');
    writeln('          /| |\.-,_| |_| |U| |\  |u | |_| |     u___) |   ');
    writeln('         u |_|U \_)-\___/  |_| \_|   \____|     |____/>>  ');
    writeln('         _// \\_     \\    ||   \\,-._)(|_       )(  (__) ');
    writeln('        (__) (__)   (__)   (_")  (_/(__)__)     (__)     ');
    delay(1000);
    clrscr();
    writeln('   _                   ____     ____        _       ____     __   __ ');
    writeln('  |"|        ___    U | __")uU |  _"\ u U  /"\  uU |  _"\ u  \ \ / / ');
    writeln('U | | u     |_"_|    \|  _ \/ \| |_) |/  \/ _ \/  \| |_) |/   \ V /  ');
    writeln('  |_____|  U/| |\u    |____/   |_| \_\  /_/   \_\  |_| \_\     |_|   ');
    writeln('  //  \\.-,_|___|_,-._|| \\_   //   \\_  \\    >>  //   \\_.-,//|(_  ');
    writeln(' (_")("_)\_)-   -(_/(__) (__) (__)  (__)(__)  (__)(__)  (__)\_) (__) ');
    delay(1000);
    clrscr();
  end;


procedure loading();
    var
      x,z : integer;
    begin
     clrscr;
     gotoxy(36,10);
     writeln('Loading..');
     gotoxy(29,13);
     writeln('---------------------');
     gotoxy(29,14);
     writeln('|');
     gotoxy(50,14);
     writeln('|');
     gotoxy(29,15);
     writeln('---------------------');
     z:= 0;
     for x:=1 to 100 do
    begin
          delay(50);
          gotoxy(38,12);
          writeln(x,' %');
 
          if(x mod 5=0) then
			begin
              z:=z+1;
              gotoxy(29+z,14);
              writeln('=');
          end;
     end;
end;

procedure welcome();
    var
        inp: string;
    begin
      printWelcome();
      delay(1000);
      clrscr();
      printOwl();
      delay(2500);
      clrscr();
      writeln('Press any key...');
      inp:= readkey();
      clrscr();
    end;

end.
