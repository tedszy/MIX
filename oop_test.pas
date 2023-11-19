{$mode objfpc}{$R+}{$H+}

program oop_test;

uses
   mix_word;

var
   MyWord: TMIXWord;
   MyWord2: TMIXWord;
   Foo: TMIXField;
   I: integer;
   Goo: TMIXRegister;
   F: TMixField = (Size:3; ByteVal:(11,22,33,0,0,0));

begin
   MyWord := TMIXWord.Create;
   MyWord2 := TMIXWord.CreateFromBytes(0,1,2,3,4,95);
   Goo := TMIXRegister.Create('rA');

   writeln(F.Byteval[0]);
   writeln(F.Byteval[1]);
   writeln(F.Byteval[2]);
   
   Goo.SetField(3, F);

   writeln(MyWord.ToString);
   writeln(MyWord2.ToString);
   writeln(Goo.ToString);
   
   Foo := MyWord2.GetField(1,3);
   for I := 0 to Foo.Size - 1 do
      write((Foo.ByteVal[I]):5);
   writeln;

   if not MyWord2.Check then
      writeln(MyWord2.ToString, ' ', 'failed check.');



   MyWord.Free;
   MyWord2.Free;
end.


