{$mode objfpc}{$R+}{$H+}

program test_mul;

uses
   mix, testing, SysUtils, Math;

var
   Knuth: TMIX;
   Expected_rA, Expected_rX: TMIXWord;
   Instruction: TMIXInstruction;

procedure Test_MUL1;
var 
   Address: integer = 1000;
   Width: integer = 25;
   TestNo: integer = 1;
begin
   Knuth.Reboot;
   Knuth.rA.Refill(0, 1, 1, 1, 1, 1);
   Knuth.PokeBytes(0, 1, 1, 1, 1, 1, Address);
   writeln(format('test: MUL %d ...', [TestNo]));
   writeln('rA contents => ':Width, Knuth.rA.ToString);
   writeln('cell contents => ':Width, Knuth.Peek(Address).ToString);
   
   Instruction.Refill(0, Address div MIXBase, Address mod MIXBase, 0, 0*8 + 5, 3);
   Knuth.execute(Instruction);
   writeln('result rA contents => ':Width, Knuth.rA.ToString);
   writeln('result rX contents => ':width, Knuth.rX.ToString);

   Expected_rA.Refill(0, 0, 1, 2, 3, 4);
   Expected_rX.Refill(0, 5, 4, 3, 2, 1);

   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected_rA) 
                                    and EqualWords(Knuth.rX, Expected_rX)));
   writeln;
end;

procedure Test_MUL2;
var 
   Address: integer = 1000;
   Width: integer = 25;
   TestNo: integer = 2;
   aa, ab, ac, ad, ae, xa, xb, xc, xd, xe: TMIXByte;
begin
   Knuth.Reboot;
   ValueToBytes(112, aa, ab, ac, ad, ae);
   Knuth.rA.Refill(1, aa, ab, ac, ad, ae);
   Knuth.PokeBytes(1, 2, 3, 4, 5, 6, Address);
   writeln(format('test: MUL %d ...', [TestNo]));
   writeln('rA contents => ':Width, Knuth.rA.ToString);
   writeln('cell contents => ':Width, Knuth.Peek(Address).ToString);
   Instruction.Refill(0, Address div MIXBase, Address mod MIXBase, 0, 1*8 + 1, 3);
   Knuth.execute(Instruction);
   writeln('result rA contents => ':Width, Knuth.rA.ToString);
   writeln('result rX contents => ':width, Knuth.rX.ToString);
   ValueToBytes(224, xa, xb, xc, xd, xe);
   Expected_rA.Refill(1, 0, 0, 0, 0, 0);
   Expected_rX.Refill(1, xa, xb, xc, xd, xe);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected_rA) 
                                    and EqualWords(Knuth.rX, Expected_rX)));
   writeln;
end;

procedure Test_MUL3;
var 
   Address: integer = 1000;
   Width: integer = 25;
   TestNo: integer = 3;
begin
   Knuth.Reboot;
   Knuth.rA.Refill(1, 50, 0, 112 div MIXBase, 112 mod MIXBase, 4);
   Knuth.PokeBytes(1, 2, 0, 0, 0, 0, Address);
   writeln(format('test: MUL %d ...', [TestNo]));
   writeln('rA contents => ':Width, Knuth.rA.ToString);
   writeln('cell contents => ':Width, Knuth.Peek(Address).ToString);
   Instruction.Refill(0, Address div MIXBase, Address mod MIXBase, 0, 0*8 + 5, 3);
   Knuth.execute(Instruction);
   writeln('result rA contents => ':Width, Knuth.rA.ToString);
   writeln('result rX contents => ':width, Knuth.rX.ToString);
   Expected_rA.Refill(0, 100 div MIXBase, 100 mod MIXBase, 0, 224 div MIXBase, 224 mod MIXBase);
   Expected_rX.Refill(0, 8, 0, 0, 0, 0);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected_rA) 
                                    and EqualWords(Knuth.rX, Expected_rX)));
   writeln;
end;

procedure Test_DIV1;
var 
   Address: integer = 1000;
   Width: integer = 25;
   TestNo: integer = 1;
begin
   Knuth.Reboot;
   Knuth.rA.Refill(0, 0, 0, 0, 0, 0);
   Knuth.rX.Refill(1, 0, 0, 0, 0, 17);
   Knuth.PokeBytes(0, 0, 0, 0, 0, 3, Address);
   writeln(format('test: DIV %d ...', [TestNo]));
   writeln('rA contents => ':Width, Knuth.rA.ToString);
   writeln('rX contents => ':Width, Knuth.rX.ToString);
   writeln('cell contents => ':Width, Knuth.Peek(Address).ToString);

   Instruction.Refill(0, Address div MIXBase, Address mod MIXBase, 0, 0*8 + 5, 4);
   Knuth.execute(Instruction);
   writeln('result rA contents => ':Width, Knuth.rA.ToString);
   writeln('result rX contents => ':width, Knuth.rX.ToString);
   Expected_rA.Refill(0, 0, 0, 0, 0, 5);
   Expected_rX.Refill(0, 0, 0, 0, 0, 2);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected_rA) 
                                    and EqualWords(Knuth.rX, Expected_rX)));
   writeln;
end;




procedure Test_DIV2;
var 
   Address: integer = 1000;
   Width: integer = 25;
   TestNo: integer = 2;
begin
   Knuth.Reboot;
   Knuth.rA.Refill(1, 0, 0, 0, 0, 0);

   Knuth.rX.Refill(0, 1235 div MIXBase, 1235 mod MIXBase, 0, 3, 1);
   Knuth.PokeBytes(1, 0, 0, 0, 2, 0, Address);
   writeln(format('test: DIV %d ...', [TestNo]));
   writeln('rA contents => ':Width, Knuth.rA.ToString);
   writeln('rX contents => ':Width, Knuth.rX.ToString);
   writeln('cell contents => ':Width, Knuth.Peek(Address).ToString);

   Instruction.Refill(0, Address div MIXBase, Address mod MIXBase, 0, 0*8 + 5, 4);
   Knuth.execute(Instruction);
   writeln('result rA contents => ':Width, Knuth.rA.ToString);
   writeln('result rX contents => ':width, Knuth.rX.ToString);
   Expected_rA.Refill(0, 0, 617 div MIXBase, 617 mod MIXBase, 32, 1);
   Expected_rX.Refill(1, 0, 0, 0, 1, 1);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected_rA) 
                                    and EqualWords(Knuth.rX, Expected_rX)));
   writeln;
end;




(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected_rA := TMIXWord.Create;
   Expected_rX := TMIXWord.Create;
   Instruction := TMIXInstruction.Create;

   Test_MUL1;
   Test_MUL2;
   Test_MUL3;
   Test_DIV1;
   Test_DIV2;

   ReportTests;

   Expected_rA.Free;
   Expected_rX.Free;
   Knuth.Free;
   Instruction.Free;
end.
