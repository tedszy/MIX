{$mode objfpc}{$R+}{$H+}

program test_add;

uses
   mix, testing, SysUtils, Math;

var
   Knuth: TMIX;
   Expected: TMIXWord;
   Instruction: TMIXInstruction;

procedure Test_SidewaysAdd;
var 
   Mem: integer = 2000;
   Width: integer = 25;
   TestNo: integer = 1;
begin
   
   Knuth.Reboot;

   { Put something in rA. We will sideways-add these bytes.
     Not including the sign byte. }
   Knuth.rA.Refill(0, 1, 2, 3, 4, 5);
   writeln(format('test: Sideways ADD %d ...', [TestNo]));
   writeln('initial register contents => ':Width, Knuth.rA.ToString);

   { STA 2000 }
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 0*8 + 5, 24); 
   Knuth.execute(Instruction);

   { LDA 2000(5:5) }
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 5*8 + 5, 8);
   Knuth.execute(Instruction);
   
   { ADD 2000(4:4) }
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 4*8 + 4, 1);
   Knuth.execute(Instruction);

   { ADD 2000(3:3) }
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 3*8 + 3, 1);
   Knuth.execute(Instruction);

   { ADD 2000(2:2) }
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 2*8 + 2, 1);
   Knuth.execute(Instruction);

   { ADD 2000(1:1) }
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 1*8 + 1, 1);
   Knuth.execute(Instruction);

   writeln('result register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(0, 0, 0, 0, 0, 1 + 2 + 3 + 4 + 5);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected)));
   writeln;
end;

procedure Test_GetValue1;
var
   TempWord: TMIXWord;
   Width: integer = 25;
   V: int64;
   TestNo: integer = 1;
begin
   TempWord := TMIXWord.CreateFromBytes(1, 1, 2, 3, 4, 5);
   writeln(format('test: GetValue %d (%d:%d)...', [TestNo, 1, 5]));
   writeln('word => ':Width, TempWord.ToString);
   V := 1*MIXBase**4 + 2*MIXBase**3 + 3*MIXBase**2 + 4*MIXBase**1 + 5;
   writeln('field value => ':Width, V);
   writeln('getvalue => ':Width, TempWord.GetValue(1,5));
   writeln('==> ', RecordTestResult(TempWord.GetValue(1,5) = V));
   writeln;
end;

procedure Test_GetValue2;
var
   TempWord: TMIXWord;
   Width: integer = 25;
   V: int64;
   TestNo: integer = 2;
begin
   TempWord := TMIXWord.CreateFromBytes(1, 1, 2, 3, 4, 5);
   writeln(format('test: GetValue %d (%d:%d)...', [TestNo, 0, 2]));
   writeln('word => ':Width, TempWord.ToString);
   V := -(1*MIXBase**1 + 2);
   writeln('field value => ':Width, V);
   writeln('getvalue => ':Width, TempWord.GetValue(0,2));
   writeln('==> ', RecordTestResult(TempWord.GetValue(0,2) = V));
   writeln;
end;

procedure Test_GetValue3;
var
   TempWord: TMIXWord;
   Width: integer = 25;
   V: int64;
   TestNo: integer = 3;
begin
   TempWord := TMIXWord.CreateFromBytes(1, 1, 2, 3, 4, 5);
   writeln(format('test: GetValue %d (%d:%d)...', [TestNo, 2, 4]));
   writeln('word => ':Width, TempWord.ToString);
   V := (2*MIXBase**2 + 3*MIXBase + 4);
   writeln('field value => ':Width, V);
   writeln('getvalue => ':Width, TempWord.GetValue(2,4));
   writeln('==> ', RecordTestResult(TempWord.GetValue(2,4) = V));
   writeln;
end;

procedure Test_GetValue4;
var
   TempWord: TMIXWord;
   Width: integer = 25;
   V: int64;
   TestNo: integer = 4;
begin
   TempWord := TMIXWord.CreateFromBytes(1, 63, 63, 63, 63, 63);
   writeln(format('test: GetValue %d (%d:%d)...', [TestNo, 0, 5]));
   writeln('word => ':Width, TempWord.ToString);
   V := -(63*MIXBase**4 + 63*MIXBase**3 + 63*MIXBase**2 + 63*MIXBase**1 + 63);
   writeln('field value => ':Width, V);
   writeln('getvalue => ':Width, TempWord.GetValue(0,5));
   writeln('==> ', RecordTestResult(TempWord.GetValue(0,5) = V));
   writeln;
end;

procedure Test_Overflow;
var
   TestNo: integer = 1;
   Width: integer = 25;
   Mem: integer = 2000;
begin
   Knuth.Reboot;
   Knuth.rA.Refill(0, 63, 1, 2, 3, 4);
   Knuth.PokeBytes(0, 1, 0, 0, 0, 0, Mem);
   writeln(format('test: Overflow %d ...', [TestNo]));
   writeln('initial register contents => ':Width, Knuth.rA.ToString);
   
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 0*8 + 5, 1);
   Knuth.execute(Instruction);

   writeln('result register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(0, 0, 1, 2, 3, 4);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = ON)));
   writeln;
end;

procedure Test_SignByte;
begin
   { put negative number in rA and add... }
end;







(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;
   Instruction := TMIXInstruction.Create;

   Test_GetValue1;
   Test_GetValue2;
   Test_GetValue3;
   Test_GetValue4;

   Test_SidewaysAdd;

   Test_Overflow;
   Test_SignByte;


   ReportTests;

   Expected.Free;
   Knuth.Free;
   Instruction.Free;
end.
