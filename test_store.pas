{$mode objfpc}{$R+}{$H+}

program test_store;

uses
   mix, testing, SysUtils;

var
   Knuth: TMIX;
   Expected: TMIXWord;
   Instruction: TMIXInstruction;

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

procedure Test_STI(TestNo: integer; IndexReg: TMIXByte;
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      ST1 to ST6.
      Opcodes 24+1=25 to 24+6=30.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 1, 2, 3, 4, 5, Mem);
   Knuth.rI[IndexReg].Refill(0, 0, 0, 0, 8, 0);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, FStart*8+FStop, 24+IndexReg); 
   writeln(format('test: STi %d ...', [TestNo]));
   writeln('memory before => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   writeln('register contents => ':Width, Knuth.rI[IndexReg].ToString);
   writeln('instruction => ':Width, Instruction.ToString);
   Knuth.execute(Instruction);
   writeln('memory after => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.Peek(Mem), Expected)));
   writeln;
end;

procedure Test_STJ(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      STJ.
      Opcode 32.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 1, 2, 3, 4, 5, Mem);
   Knuth.rJ.Refill(0, 0, 0, 0, 8, 0);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, FStart*8+FStop, 32); 
   writeln(format('test: STJ %d ...', [TestNo]));
   writeln('memory before => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   writeln('register contents => ':Width, Knuth.rJ.ToString);
   writeln('instruction => ':Width, Instruction.ToString);
   Knuth.execute(Instruction);
   writeln('memory after => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.Peek(Mem), Expected)));
   writeln;
end;

procedure Test_STz(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      STZ.
      Opcode 33.

      Equivalent to clearing rA, then doing STA.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 1, 2, 3, 4, 5, Mem);
   // We zero out rA during the execution of this instruction.
   // So we do not need the following line...
   // Knuth.rA.Refill(0, 0, 0, 0, 0, 0);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, FStart*8+FStop, 33); 
   writeln(format('test: STZ %d ...', [TestNo]));
   writeln('memory before => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   writeln('register contents => ':Width, Knuth.rA.ToString);
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

   Test_STI(1, 3, 2000, 0, 5, 0, 0, 0, 0, 8, 0);
   Test_STI(2, 3, 2000, 1, 5, 1, 0, 0, 0, 8, 0);
   Test_STI(3, 3, 2000, 5, 5, 1, 1, 2, 3, 4, 0);
   Test_STI(4, 3, 2000, 2, 2, 1, 1, 0, 3, 4, 5);
   Test_STI(5, 3, 2000, 0, 1, 0, 0, 2, 3, 4, 5);

   Test_STJ(1, 2000, 0, 5, 0, 0, 0, 0, 8, 0);
   Test_STJ(2, 2000, 1, 5, 1, 0, 0, 0, 8, 0);
   Test_STJ(3, 2000, 5, 5, 1, 1, 2, 3, 4, 0);
   Test_STJ(4, 2000, 2, 2, 1, 1, 0, 3, 4, 5);
   Test_STJ(5, 2000, 0, 1, 0, 0, 2, 3, 4, 5);

   Test_STZ(1, 2000, 0, 5, 0, 0, 0, 0, 0, 0);
   Test_STZ(2, 2000, 1, 5, 1, 0, 0, 0, 0, 0);
   Test_STZ(3, 2000, 5, 5, 1, 1, 2, 3, 4, 0);
   Test_STZ(4, 2000, 2, 2, 1, 1, 0, 3, 4, 5);
   Test_STZ(5, 2000, 0, 1, 0, 0, 2, 3, 4, 5);

   ReportTests;

   Expected.Free;
   Knuth.Free;
   Instruction.Free;

end.



