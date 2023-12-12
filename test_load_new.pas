{$mode objfpc}{$R+}{$H+}

program test_load;

uses
   mix_word, mix_new, testing_new, SysUtils;

var
   Knuth: TMIX;
   Expected: TMIXWord;

procedure Test_LDA1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDA(2000, 0, 0*8 + 5);
   MakeTitle('LDA', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDA2;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDA(2000, 0, 1*8 + 5);
   MakeTitle('LDA', 2);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDA3;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDA(2000, 0, 3*8 + 5);
   MakeTitle('LDA', 3);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 3, 5, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDA4;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDA(2000, 0, 0*8 + 3);
   MakeTitle('LDA', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   // This is equivalent way to set Expected.
   //Expected.SetBytes(1, 0, 0, 80 div MIXbase, 80 mod MIXBase, 3);
   Expected.SetPacked([PV(-1,1),PV(0,2),PV(80,2),PV(3,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDA5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDA(2000, 0, 4*8 + 4);
   MakeTitle('LDA', 5);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 5);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDA6;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDA(2000, 0, 0*8 + 0);
   MakeTitle('LDA', 6);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDA7;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDA(2000, 0, 1*8 + 1);
   MakeTitle('LDA', 7);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 80 div MIXBase);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

(* *********************************** *)

procedure Test_LDX1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDX(2000, 0, 0*8 + 5);
   MakeTitle('LDX', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDX2;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDX(2000, 0, 1*8 + 5);
   MakeTitle('LDX', 2);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDX3;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDX(2000, 0, 3*8 + 5);
   MakeTitle('LDX', 3);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 3, 5, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDX4;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDX(2000, 0, 0*8 + 3);
   MakeTitle('LDX', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   // This is equivalent way to set Expected.
   //Expected.SetBytes(1, 0, 0, 80 div MIXbase, 80 mod MIXBase, 3);
   Expected.SetPacked([PV(-1,1),PV(0,2),PV(80,2),PV(3,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDX5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDX(2000, 0, 4*8 + 4);
   MakeTitle('LDX', 5);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 5);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDX6;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDX(2000, 0, 0*8 + 0);
   MakeTitle('LDX', 6);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDX7;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDX(2000, 0, 1*8 + 1);
   MakeTitle('LDX', 7);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 80 div MIXBase);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

(* *********************************** *)

procedure Test_LDAN1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDAN(2000, 0, 0*8 + 5);
   MakeTitle('LDAN', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDAN2;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDAN(2000, 0, 1*8 + 5);
   MakeTitle('LDAN', 2);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDAN3;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDAN(2000, 0, 3*8 + 5);
   MakeTitle('LDAN', 3);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 3, 5, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDAN4;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDAN(2000, 0, 0*8 + 3);
   MakeTitle('LDA', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   // This is equivalent way to set Expected.
   //Expected.SetBytes(1, 0, 0, 80 div MIXbase, 80 mod MIXBase, 3);
   Expected.SetPacked([PV(1,1),PV(0,2),PV(80,2),PV(3,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDAN5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDAN(2000, 0, 4*8 + 4);
   MakeTitle('LDAN', 5);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 5);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDAN6;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDAN(2000, 0, 0*8 + 0);
   MakeTitle('LDAN', 6);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDAN7;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDAN(2000, 0, 1*8 + 1);
   MakeTitle('LDAN', 7);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 80 div MIXBase);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

(* *********************************** *)

procedure Test_LDXN1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDXN(2000, 0, 0*8 + 5);
   MakeTitle('LDXN', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rA', Knuth.rX);
   Expected.SetPacked([PV(1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDXN2;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDXN(2000, 0, 1*8 + 5);
   MakeTitle('LDXN', 2);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDXN3;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDXN(2000, 0, 3*8 + 5);
   MakeTitle('LDXN', 3);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 3, 5, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDXN4;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDXN(2000, 0, 0*8 + 3);
   MakeTitle('LDXN', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(1,1),PV(0,2),PV(80,2),PV(3,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDXN5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDXN(2000, 0, 4*8 + 4);
   MakeTitle('LDXN', 5);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 5);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDXN6;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDXN(2000, 0, 0*8 + 0);
   MakeTitle('LDXN', 6);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDXN7;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDXN(2000, 0, 1*8 + 1);
   MakeTitle('LDXN', 7);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rX', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 80 div MIXBase);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

(* *********************************** *)

procedure Test_LDi1;
var
   RegI: integer = 3;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDi(RegI, 2000, 0, 0*8 + 2);
   MakeTitle('LDi', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 1, 16);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDi2;
var
   RegI: integer = 3;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDi(RegI, 2000, 0, 4*8 + 5);
   MakeTitle('LDi', 2);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 5, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDi3;
var
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDi(RegI, 2000, 0, 0*8 + 0);
   MakeTitle('LDi', 3);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDi4;
var
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDi(RegI, 2000, 0, 1*8 + 2);
   MakeTitle('LDi', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 1, 16);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDi5;
var
   RegI: integer = 5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDi(RegI, 2000, 0, 0*8 + 1);
   MakeTitle('LDi', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 1);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

(* *********************************** *)

procedure Test_LDiN1;
var
   RegI: integer = 4;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDiN(RegI, 2000, 0, 0*8 + 2);
   MakeTitle('LDiN', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 1, 16);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDiN2;
var
   RegI: integer = 2;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDiN(RegI, 2000, 0, 4*8 + 5);
   MakeTitle('LDiN', 2);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 5, 4);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDiN3;
var
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDiN(RegI, 2000, 0, 0*8 + 0);
   MakeTitle('LDiN', 3);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDiN4;
var
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDiN(RegI, 2000, 0, 1*8 + 2);
   MakeTitle('LDiN', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 1, 16);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_LDiN5;
var
   RegI: integer = 5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.Inst_LDiN(RegI, 2000, 0, 0*8 + 1);
   MakeTitle('LDiN', 4);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 1);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

(* *********************************** *)

procedure Test_LDA_Indexed;
var
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.rI[RegI].SetPacked([PV(-1,1),PV(0,3),PV(1000,2)]);
   Knuth.Inst_LDA(3000, RegI, 0*8 + 5);
   MakeTitle('LDA indexed', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_LDX_Indexed;
var
   RegI: integer = 5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.rI[RegI].SetPacked([PV(1,1),PV(0,3),PV(1000,2)]);
   Knuth.Inst_LDX(1000, RegI, 0*8 + 5);
   MakeTitle('LDX indexed', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_LDi_Indexed;
var
   RegI: integer = 5;
begin
   Knuth.Clear;
   Knuth.Cell[2000].SetPacked([PV(-1,1), PV(80,2), PV(3,1), PV(5,1), PV(4,1)]);
   Knuth.rI[RegI].SetPacked([PV(1,1),PV(0,3),PV(1000,2)]);
   Knuth.Inst_LDi(1, 1000, RegI, 0*8 + 2);
   MakeTitle('LDi indexed', 1);
   DisplaylnWord('Cell 2000', Knuth.Cell[2000]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('rI', Knuth.ri[1]);
   Expected.SetPacked([PV(-1,1),PV(0,3),PV(80,2)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[1], Expected));
end;

(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;

   Test_LDA1;
   Test_LDA2;
   Test_LDA3;
   Test_LDA4;
   Test_LDA5;
   Test_LDA6;
   Test_LDA7;

   Test_LDX1;
   Test_LDX2;
   Test_LDX3;
   Test_LDX4;
   Test_LDX5;
   Test_LDX6;
   Test_LDX7;

   Test_LDAN1;
   Test_LDAN2;
   Test_LDAN3;
   Test_LDAN4;
   Test_LDAN5;
   Test_LDAN6;
   Test_LDAN7;

   Test_LDXN1;
   Test_LDXN2;
   Test_LDXN3;
   Test_LDXN4;
   Test_LDXN5;
   Test_LDXN6;
   Test_LDXN7;

   Test_LDi1;
   Test_LDi2;
   Test_LDi3;
   Test_LDi4;
   Test_LDi5;

   Test_LDiN1;
   Test_LDiN2;
   Test_LDiN3;
   Test_LDiN4;
   Test_LDiN5;

   Test_LDA_Indexed;
   Test_LDX_Indexed;
   Test_LDi_Indexed;

   ReportTests;

   Expected.Free;
   Knuth.Free;
end.


