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
var
   TestNo: integer = 1;
   Width: integer = 25;
   Mem: integer = 2000;
begin
   { put negative number in rA and add... }
   Knuth.Reboot;
   Knuth.rA.Refill(1, 1, 2, 3, 4, 5);
   Knuth.PokeBytes(0, 1, 2, 3, 4, 5, Mem);

   writeln(format('test: Sign byte %d ...', [TestNo]));
   writeln('initial register contents => ':Width, Knuth.rA.ToString);
   
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 0*8 + 5, 1);
   Knuth.execute(Instruction);

   writeln('result register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(1, 0, 0, 0, 0, 0);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = OFF)));
   writeln;
end;

procedure Test_ADD1;
var
   TestNo: integer = 1;
   Width: integer = 25;
   Mem: integer = 2000;
begin
   { Normal usage of ADD... }
   Knuth.Reboot;
   Knuth.rA.Refill(0, 1, 2, 3, 4, 5);
   Knuth.PokeBytes(0, 5, 4, 3, 2, 1, Mem);

   writeln(format('test: ADD %d ...', [TestNo]));
   writeln('initial register contents => ':Width, Knuth.rA.ToString);
   
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 0*8 + 5, 1);
   Knuth.execute(Instruction);

   writeln('result register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(0, 6, 6, 6, 6, 6);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = OFF)));
   writeln;
end;

procedure Test_ADD2;
var
   TestNo: integer = 2;
   Width: integer = 25;
   Mem: integer = 1000;
begin
   { ADD test from Knuth. }
   Knuth.Reboot;
   Knuth.rA.Refill(0, 1234 div MIXBase, 1234 mod MIXBase, 1, 150 div MIXBase, 150 mod MIXBase);
   Knuth.PokeBytes(0, 100 div MIXBase, 100 mod MIXBase, 5, 50 div MIXBase, 50 mod MIXBase, Mem);

   writeln(format('test: ADD %d ...', [TestNo]));
   writeln('initial register contents => ':Width, Knuth.rA.ToString);
   
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 0*8 + 5, 1);
   Knuth.execute(Instruction);

   writeln('result register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(0, 1334 div MIXBase, 1334 mod MIXBase, 6, 200 div MIXBase, 200 mod MIXBase);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = OFF)));
   writeln;
end;

procedure Test_SUB1;
var
   TestNo: integer = 1;
   Width: integer = 25;
   Mem: integer = 2000;
begin
   { SUB test from Knuth. }
   Knuth.Reboot;
   Knuth.rA.Refill(1, 1234 div MIXBase, 1234 mod MIXBase, 0, 0, 9);
   Knuth.PokeBytes(1, 2000 div MIXBase, 2000 mod MIXBase, 150 div MIXBase, 150 mod MIXBase, 0, Mem);

   writeln(format('test: SUB %d ...', [TestNo]));
   writeln('initial register contents => ':Width, Knuth.rA.ToString);
   writeln('memory cell contents => ':Width, Knuth.Peek(Mem).ToString);
   
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 0*8 + 5, 2);
   Knuth.execute(Instruction);

   writeln('result register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(0, 766 div MIXBase, 766 mod MIXBase, 149 div MIXBase, 149 mod MIXBase, 55);
   writeln('expected register contents => ':Width, Expected.ToString);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = OFF)));
   writeln;
end;

procedure Test_ADD3;
var
   TestNo: integer = 3;
   Width: integer = 25;
   Mem: integer = 2000;
begin
   { 
      Would be a good idea to check Knuth's 
      SUB example in reverse, as an ADD... 
  }
   Knuth.Reboot;
   Knuth.rA.Refill(0, 11, 62, 2, 21, 55);
   Knuth.PokeBytes(1, 31, 16, 2, 22, 00, Mem);

   writeln(format('test: ADBD %d ...', [TestNo]));
   writeln('initial register contents => ':Width, Knuth.rA.ToString);
   writeln('memory cell contents => ':Width, Knuth.Peek(Mem).ToString);
   
   Instruction.Refill(0, Mem div MIXBase, Mem mod MIXBase, 0, 0*8 + 5, 1);
   Knuth.execute(Instruction);

   writeln('result register contents => ':Width, Knuth.rA.ToString);
   Expected.Refill(1, 19, 18, 00, 00, 9);
   writeln('expected register contents => ':Width, Expected.ToString);
   writeln('==> ', RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = OFF)));
   writeln;
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
   Test_ADD1;
   Test_ADD2;
   Test_SUB1;
   Test_ADD3;

   ReportTests;

   Expected.Free;
   Knuth.Free;
   Instruction.Free;
end.
