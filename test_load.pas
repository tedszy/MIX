{$mode objfpc}{$R+}{$H+}

program test_load;

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

procedure Test_LDA(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      LDA.
      Opcode 8.

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
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected)));
   writeln;
end;

procedure Test_LDX(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      LDX.
      Opcode 15.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 8*FStart+Fstop, 15); 
   writeln(format('test: LDX %d ...', [TestNo]));
   writeln('instruction => ':Width, Instruction.ToString);
   writeln('memory => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Knuth.execute(Instruction);
   writeln('register contents => ':Width, Knuth.rX.ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rX, Expected)));
   writeln;
end;

procedure Test_LDI(TestNo: integer; IndexReg: TMIXByte; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      LD1 to LD6.
      Opcodes 8+1 = 9 to 8+6 = 14.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 8*FStart+Fstop, 8 + IndexReg); 
   writeln(format('test: LDi %d ...', [TestNo]));
   writeln('instruction => ':Width, Instruction.ToString);
   writeln('memory => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Knuth.execute(Instruction);
   writeln('register contents => ':Width, Knuth.rI[IndexReg].ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rI[IndexReg], Expected)));
   writeln;
end;

procedure Test_LDAN(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      LDAN.
      Opcode 16.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 8*FStart+Fstop, 16); 
   writeln(format('test: LDAN %d ...', [TestNo]));
   writeln('instruction => ':Width, Instruction.ToString);
   writeln('memory => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Knuth.execute(Instruction);
   writeln('register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected)));
   writeln;
end;

procedure Test_LDXN(TestNo: integer; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      LDXN.
      Opcode 23.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 8*FStart+Fstop, 23); 
   writeln(format('test: LDXN %d ...', [TestNo]));
   writeln('instruction => ':Width, Instruction.ToString);
   writeln('memory => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Knuth.execute(Instruction);
   writeln('register contents => ':Width, Knuth.rX.ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rX, Expected)));
   writeln;
end;

procedure Test_LDIN(TestNo: integer; IndexReg: TMIXByte; 
   Mem: integer; FStart, FStop: TMIXByte;
   Exa, Exb, Exc, Exd, Exe, Exf: TMIXByte);
var
   Width: integer = 25;
begin
   {
      LD1N to LD6N.
      Opcodes 16+1 = 17 to 16+6 = 22.
   }
   Knuth.Reboot;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 8*FStart+Fstop, 16 + IndexReg); 
   writeln(format('test: LDiN %d ...', [TestNo]));
   writeln('instruction => ':Width, Instruction.ToString);
   writeln('memory => ':Width, inttostr(Mem)+': '+Knuth.Peek(Mem).ToString);
   Knuth.execute(Instruction);
   writeln('register contents => ':Width, Knuth.rI[IndexReg].ToString);
   Expected.Refill(Exa, Exb, Exc, Exd, Exe, Exf);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rI[IndexReg], Expected)));
   writeln;
end;

(* Main. *)

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

   Test_LDX(1, 2000, 0, 5, 1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDX(2, 2000, 1, 5, 0, 89 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDX(3, 2000, 3, 5, 0, 0, 0, 3, 5, 4);
   Test_LDX(4, 2000, 0, 3, 1, 0, 0, 80 div MIXBase, 80 mod MIXBase, 3);
   Test_LDX(5, 3000, 4, 4, 0, 0, 0, 0, 0, 5);
   Test_LDX(6, 3000, 0, 0, 1, 0, 0, 0, 0, 0);
   Test_LDX(7, 3000, 1, 1, 0, 0, 0, 0, 0, 80 div MIXBase);

   Test_LDI(1, 3, 2000, 0, 2, 1, 0, 0, 0, 1, 16);
   Test_LDI(2, 3, 2000, 4, 5, 0, 0, 0, 0, 5, 4);
   Test_LDI(3, 3, 2000, 0, 0, 1, 0, 0, 0, 0, 0); 
   Test_LDI(4, 3, 2000, 1, 2, 0, 0, 0, 0, 1, 16);
   Test_LDI(5, 4, 3000, 0, 1, 1, 0, 0, 0, 0, 1);

   Test_LDAN(1, 2000, 0, 5, 0, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDAN(2, 2000, 1, 5, 1, 89 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDAN(3, 2000, 3, 5, 1, 0, 0, 3, 5, 4);
   Test_LDAN(4, 2000, 0, 3, 0, 0, 0, 80 div MIXBase, 80 mod MIXBase, 3);
   Test_LDAN(5, 3000, 4, 4, 1, 0, 0, 0, 0, 5);
   Test_LDAN(6, 3000, 0, 0, 0, 0, 0, 0, 0, 0);
   Test_LDAN(7, 3000, 1, 1, 1, 0, 0, 0, 0, 80 div MIXBase);

   Test_LDXN(1, 2000, 0, 5, 0, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDXN(2, 2000, 1, 5, 1, 89 div MIXBase, 80 mod MIXBase, 3, 5, 4);
   Test_LDXN(3, 2000, 3, 5, 1, 0, 0, 3, 5, 4);
   Test_LDXN(4, 2000, 0, 3, 0, 0, 0, 80 div MIXBase, 80 mod MIXBase, 3);
   Test_LDXN(5, 3000, 4, 4, 1, 0, 0, 0, 0, 5);
   Test_LDXN(6, 3000, 0, 0, 0, 0, 0, 0, 0, 0);
   Test_LDXN(7, 3000, 1, 1, 1, 0, 0, 0, 0, 80 div MIXBase);

   Test_LDIN(1, 3, 2000, 0, 2, 0, 0, 0, 0, 1, 16);
   Test_LDIN(2, 3, 2000, 4, 5, 1, 0, 0, 0, 5, 4);
   Test_LDIN(3, 3, 2000, 0, 0, 0, 0, 0, 0, 0, 0); 
   Test_LDIN(4, 3, 2000, 1, 2, 1, 0, 0, 0, 1, 16);
   Test_LDIN(5, 4, 3000, 0, 1, 0, 0, 0, 0, 0, 1);

   writeln('----------');
   writeln('Passed: ', Passed);
   writeln('Failed: ', Failed);

   Expected.Free;
   Knuth.Free;
   Instruction.Free;
end.


