{$mode objfpc}{$R+}{$H+}

program test_store;

uses
   mix, SysUtils;

var
   Knuth: TMIX;
   Expected: TMIXWord;
   Instruction: TMIXInstruction;
   Passed: integer = 0;
   Failed: integer = 0;

function RecordTestResult(Res: boolean): boolean;
begin
   if Res then
      Passed := Passed + 1
   else
      Failed := Failed + 1;
   RecordTestResult := Res;
end;

function EqualWords(W1, W2: TMIXWord): boolean;
var
   I: Integer;
begin
   EqualWords := true;
   for I := 0 to 5 do
      EqualWords := EqualWords and (W1.ByteVal[I]=W2.ByteVal[I]);
end;

procedure Test_STA(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      STA.
      Opcode 24.

      Exa, Exb, Exc, Exd, Exe, Exf are expected bytes values of the
      word residing in memory after the instruction is executed.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 1, 2, 3, 4, 5, Mem);
   Knuth.rA.Refill(0, 6, 7, 8, 9, 0);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, FStart*8+FStop, 24); 
   writeln(format('test: STA %d ...', [TestNo]));
   writeln('memory before => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   writeln('register contents => ':Width, Knuth.rA.ToString);
   writeln('instruction => ':Width, Instruction.ToString);
   Knuth.execute(Instruction);
   writeln('memory after => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.Peek(Mem), Expected)));
   writeln;
end;

procedure Test_STX(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      STX.
      Opcode 31.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 1, 2, 3, 4, 5, Mem);
   Knuth.rX.Refill(0, 6, 7, 8, 9, 0);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, FStart*8+FStop, 31); 
   writeln(format('test: STX %d ...', [TestNo]));
   writeln('memory before => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   writeln('register contents => ':Width, Knuth.rX.ToString);
   writeln('instruction => ':Width, Instruction.ToString);
   Knuth.execute(Instruction);
   writeln('memory after => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.Peek(Mem), Expected)));
   writeln;
end;

(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;
   Instruction := TMIXInstruction.Create;

   Test_STA(1, 2000, 0, 5, 0, 6, 7, 8, 9, 0);
   Test_STA(2, 2000, 1, 5, 1, 6, 7, 8, 9, 0);
   Test_STA(3, 2000, 5, 5, 1, 1, 2, 3, 4, 0);
   Test_STA(4, 2000, 2, 2, 1, 1, 0, 3, 4, 5);
   Test_STA(5, 2000, 0, 1, 0, 0, 2, 3, 4, 5);

   Test_STX(1, 2000, 0, 5, 0, 6, 7, 8, 9, 0);
   Test_STX(2, 2000, 1, 5, 1, 6, 7, 8, 9, 0);
   Test_STX(3, 2000, 5, 5, 1, 1, 2, 3, 4, 0);
   Test_STX(4, 2000, 2, 2, 1, 1, 0, 3, 4, 5);
   Test_STX(5, 2000, 0, 1, 0, 0, 2, 3, 4, 5);


   writeln('----------');
   writeln('Passed: ', Passed);
   writeln('Failed: ', Failed);

   Expected.Free;
   Knuth.Free;
   Instruction.Free;

end.



