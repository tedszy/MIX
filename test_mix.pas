{$mode objfpc}{$R+}{$H+}

program oop_test;

uses
   mix, SysUtils;

var
   Knuth: TMIX;
   MyWord: TMIXWord;
   Instruction: TMIXInstruction;
   Mem: integer = 2000;

function EqualWords(W1, W2: TMIXWord): boolean;
var
   I: Integer;
begin
   EqualWords := true;
   for I := 0 to 5 do
      EqualWords := EqualWords and (W1.ByteVal[I]=W2.ByteVal[I]);
end;


begin

   Knuth := TMIX.Create;

   Knuth.Reboot;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   MyWord := TMIXWord.CreateFromBytes(0, Mem div MIXBase, Mem mod MIXBase, 0, 5, 8);
   Instruction := TMIXInstruction.Create(MyWord);
   writeln('test: LDA 1 ...');
   writeln('instruction => ':25, Instruction.ToString);
   writeln('memory => ':25, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Knuth.execute(Instruction);
   writeln('register contents => ':25, Knuth.rA.ToString);
   MyWord.Refill(1, 89 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   writeln('test => ', EqualWords(Knuth.rA, MyWord));
   



   MyWord.Free;
   Knuth.Free;
   Instruction.Free;
end.


