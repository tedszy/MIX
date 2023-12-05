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







(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected_rA := TMIXWord.Create;
   Expected_rX := TMIXWord.Create;
   Instruction := TMIXInstruction.Create;

   Test_MUL1;

   ReportTests;

   Expected_rA.Free;
   Expected_rX.Free;
   Knuth.Free;
   Instruction.Free;
end.
