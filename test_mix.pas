{$mode objfpc}{$R+}{$H+}

program oop_test;

uses
   mix;

var
   MyWord: TMIXWord;
   MyWord2: TMIXWord;
   I: integer;
   Goo: TMIXRegister;
   Knuth: TMIX;

begin
   MyWord := TMIXWord.Create;
   MyWord2 := TMIXWord.CreateFromBytes(1,2,3,4,5,6);
   Goo := TMIXRegister.Create('rA');


   writeln(MyWord.ToString);
   writeln(MyWord2.ToString);
   writeln(Goo.ToString);
   writeln;

   Goo.Load(MyWord2, 1, 3);
   writeln(Goo.ToString);
   writeln;

   Goo.Load(MyWord2, 0, 5);
   writeln(Goo.ToString);
   writeln;


   Goo.Load(MyWord2, 0, 0);
   writeln(Goo.ToString);
   writeln;

   writeln('---- MIX ----');

   Knuth := TMIX.Create;

   writeln('test peek, poke');
   Knuth.PokeBytes(6,5,4,3,2,1, 3);
   Knuth.PokeWord(MyWord2, 2);
   writeln((Knuth.Peek(2)).ToString);

   Knuth.Show;








   MyWord.Free;
   MyWord2.Free;
   Goo.Free;
   Knuth.Free;
end.


