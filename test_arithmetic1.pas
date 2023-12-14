{$mode objfpc}{$R+}{$H+}

{
   Test ADD, SUB.
}

program test_arithmetic1;

uses
   mix_word, mix, testing, SysUtils;

var
   Knuth: TMIX;
   Expected: TMIXWord;

procedure Test_ADD1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 4, 5);
   Knuth.rA.SetBytes(0, 5, 4, 3, 2, 1);
   MakeTitle('ADD', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_ADD(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(0, 6, 6, 6, 6, 6);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ADD2;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(1234,3),PV(1,1),PV(150,2)]);
   Knuth.Cell[Address].SetPacked([PV(100,3),PV(5,1),PV(50,2)]);
   MakeTitle('ADD', 2);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_ADD(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetPacked([PV(1334,3),PV(6,1),PV(200,2)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ADD3;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 4, 5);
   MakeTitle('ADD: rA sign byte check', 3);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_ADD(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ADD4;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 63, 1, 2, 3, 4);
   Knuth.Cell[Address].SetBytes(0, 1, 0, 0, 0, 0);
   MakeTitle('ADD: overflow check', 4);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_ADD(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(0, 0, 1, 2, 3, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = ON));
end;

procedure Test_ADD5;
var
   Address: integer = 1000;
begin
   { Testing the reverse of Knuth's SUB example. }
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 11, 62, 2, 21, 55);
   Knuth.Cell[Address].SetBytes(1, 31, 16, 2, 22, 00);
   MakeTitle('ADD', 5);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_ADD(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(1, 19, 18, 0, 0, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

(* ******************************************* *)

procedure Test_SUB1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(-1234,3),PV(0,2),PV(9,1)]);
   Knuth.Cell[Address].SetPacked([PV(-2000,3),PV(150,2),PV(0,1)]);
   MakeTitle('SUB', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_SUB(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetPacked([PV(766,3),PV(149,2),PV(55,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_SUB2;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(1, 63, 1, 2, 3, 4);
   Knuth.Cell[Address].SetBytes(0, 1, 0, 0, 0, 0);
   MakeTitle('SUB: overflow check', 2);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_SUB(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(1, 0, 1, 2, 3, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = ON));
end;

(* ******************************************* *)

procedure Test_ADD_Indexed;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(1234,3),PV(1,1),PV(150,2)]);
   Knuth.Cell[Address].SetPacked([PV(100,3),PV(5,1),PV(50,2)]);
   Knuth.rI[RegI].SetPacked([PV(1000,6)]);
   MakeTitle('ADD indexed', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   DisplaylnWord('rI[Reg]', Knuth.rI[RegI]);
   Knuth.Inst_ADD(1000, RegI, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetPacked([PV(1334,3),PV(6,1),PV(200,2)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_SUB_Indexed;
var
   Address: integer = 1000;
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(-1234,3),PV(0,2),PV(9,1)]);
   Knuth.Cell[Address].SetPacked([PV(-2000,3),PV(150,2),PV(0,1)]);
   Knuth.rI[RegI].SetPacked([PV(-1000,6)]);
   MakeTitle('SUB indexed', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   DisplaylnWord('rI[Reg]', Knuth.rI[RegI]);
   Knuth.Inst_SUB(2000, RegI, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetPacked([PV(766,3),PV(149,2),PV(55,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;




(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;

   Test_ADD1;
   Test_ADD2;
   Test_ADD3;
   Test_ADD4;
   Test_ADD5;

   Test_SUB1;
   Test_SUB2;

   Test_ADD_Indexed;
   Test_SUB_Indexed;

   ReportTests;

   Expected.Free;
   Knuth.Free;
end.
