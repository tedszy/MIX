{$mode objfpc}{$R+}{$H+}

program oop_test;

uses
   mix, SysUtils;

var
   Knuth: TMIX;
   Expected: TMIXWord;
   Instruction: TMIXInstruction;
   Mem: integer;

function EqualWords(W1, W2: TMIXWord): boolean;
var
   I: Integer;
begin
   EqualWords := true;
   for I := 0 to 5 do
      EqualWords := EqualWords and (W1.ByteVal[I]=W2.ByteVal[I]);
end;

procedure Test_LDA(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      Exa, Exb, Exc, Exd, Exe, Exf are expected bytes values of the
      word residing in rA after the instruction is executed.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 8*FStart+Fstop, 8); 
   writeln(format('test: LDA %d ...', [TestNo]));
   writeln('instruction => ':Width, Instruction.ToString);
   writeln('memory => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Knuth.execute(Instruction);
   writeln('register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', EqualWords(Knuth.rA, Expected));
   writeln;
end;

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;
   Instruction := TMIXInstruction.Create;

   Test_LDA(1, 2000, 0, 5, 1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDA(2, 2000, 1, 5, 0, 89 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDA(3, 2000, 3, 5, 0, 0, 0, 3, 5, 4);
   Test_LDA(4, 2000, 0, 3, 1, 0, 0, 80 div MIXBase, 80 mod MIXBase, 3);
   Test_LDA(5, 3000, 4, 4, 0, 0, 0, 0, 0, 5);
   Test_LDA(6, 3000, 0, 0, 1, 0, 0, 0, 0, 0);
   Test_LDA(7, 3000, 1, 1, 0, 0, 0, 0, 0, 80 div MIXBase);






   Expected.Free;
   Knuth.Free;
   Instruction.Free;
end.


