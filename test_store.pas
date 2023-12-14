{$mode objfpc}{$R+}{$H+}

program test_store;

uses
   mix_word, mix, testing, SysUtils;

var
   Knuth: TMIX;
   Expected: TMIXWord;

procedure Test_STA1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STA', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rA.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STA(Address, 0, 0*8 + 5);
   Expected.SetBytes(0, 6, 7, 8, 9, 0);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STA2;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STA', 2);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rA.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STA(Address, 0, 1*8 + 5);
   Expected.SetBytes(1, 6, 7, 8, 9, 0);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STA3;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STA', 3);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rA.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STA(Address, 0, 5*8 + 5);
   Expected.SetBytes(1, 1, 2, 3, 4, 0);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STA4;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STA', 4);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rA.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STA(Address, 0, 2*8 + 2);
   Expected.SetBytes(1, 1, 0, 3, 4, 5);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STA5;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STA', 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rA.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STA(Address, 0, 0*8 + 1);
   Expected.SetBytes(0, 0, 2, 3, 4, 5);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STA6;
var
   Address: integer = 2000;
begin
   {
      Edge case: what happens when rA contains -0? 
      It should be stored in a cell as -0 with the
      correct sign byte. We are assuming this:
      Knuth's text does not explicitly say so (yet).
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 4, 5);
   MakeTitle('STA', 6);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rA.SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_STA(Address, 0, 0*8 + 5);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STA7;
var
   Address: integer = 2000;
begin
   {
      Edge case: what happens when field is (0:0)?
      Since it loads only the lowest byte of rA, 
      this is always positive, so the sign of the
      cell will become +.
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STA', 7);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rA.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Inst_STA(Address, 0, 0*8 + 0);
   Expected.SetBytes(0, 1, 2, 3, 4, 5);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

(* ************************************************* *)

procedure Test_STX1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STX', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rX.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STX(Address, 0, 0*8 + 5);
   Expected.SetBytes(0, 6, 7, 8, 9, 0);
   DisplaylnWord('rX', Knuth.rX);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STX2;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STX', 2);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rX.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STX(Address, 0, 1*8 + 5);
   Expected.SetBytes(1, 6, 7, 8, 9, 0);
   DisplaylnWord('rX', Knuth.rX);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STX3;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STX', 3);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rX.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STX(Address, 0, 5*8 + 5);
   Expected.SetBytes(1, 1, 2, 3, 4, 0);
   DisplaylnWord('rX', Knuth.rX);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STX4;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STX', 4);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rX.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STX(Address, 0, 2*8 + 2);
   Expected.SetBytes(1, 1, 0, 3, 4, 5);
   DisplaylnWord('rX', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STX5;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STX', 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rX.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STX(Address, 0, 0*8 + 1);
   Expected.SetBytes(0, 0, 2, 3, 4, 5);
   DisplaylnWord('rX', Knuth.rX);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STX6;
var
   Address: integer = 2000;
begin
   {
      Edge case: what happens when rA contains -0? 
      It should be stored in a cell as -0 with the
      correct sign byte. We are assuming this:
      Knuth's text does not explicitly say so (yet).
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 4, 5);
   MakeTitle('STX', 6);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rX.SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_STX(Address, 0, 0*8 + 5);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('rX', Knuth.rX);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STX7;
var
   Address: integer = 2000;
begin
   {
      Edge case: what happens when field is (0:0)?
      Since it loads only the lowest byte of rA, 
      this is always positive, so the sign of the
      cell will become +.
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STX', 7);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rX.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Inst_STX(Address, 0, 0*8 + 0);
   Expected.SetBytes(0, 1, 2, 3, 4, 5);
   DisplaylnWord('rX', Knuth.rX);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

(* ************************************************* *)

procedure Test_STI1;
var
   Address: integer = 2000;
   RegI: integer = 3;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STI', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STI(RegI, Address, 0, 0*8 + 5);
   Expected.SetBytes(0, 0, 0, 0, 8, 0);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STI2;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STI', 2);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STI(RegI, Address, 0, 1*8 + 5);
   Expected.SetBytes(1, 0, 0, 0, 8, 0);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STI3;
var
   Address: integer = 2000;
   RegI: integer = 5;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STI', 3);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STI(RegI, Address, 0, 5*8 + 5);
   Expected.SetBytes(1, 1, 2, 3, 4, 0);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STI4;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STI', 4);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STI(RegI, Address, 0, 2*8 + 2);
   Expected.SetBytes(1, 1, 0, 3, 4, 5);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STI5;
var
   Address: integer = 2000;
   RegI: integer = 4;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STI', 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STI(RegI, Address, 0, 0*8 + 1);
   Expected.SetBytes(0, 0, 2, 3, 4, 5);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STI6;
var
   Address: integer = 2000;
   RegI: integer = 4;
begin
   {
      Edge case.
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STI', 6);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_STI(RegI, Address, 0, 0*8 + 5);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STI7;
var
   Address: integer = 2000;
   RegI: integer = 4;
begin
   {
      Edge case.
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STI', 7);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 8, 0);
   Knuth.Inst_STI(RegI, Address, 0, 0*8 + 0);
   Expected.SetBytes(0, 1, 2, 3, 4, 5);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

(* ************************************************* *)

procedure Test_STJ1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STJ', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rJ.SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STJ(Address, 0, 0*8 + 5);
   Expected.SetBytes(0, 0, 0, 0, 8, 0);
   DisplaylnWord('rJ', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STJ2;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STJ', 2);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rJ.SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STJ(Address, 0, 1*8 + 5);
   Expected.SetBytes(1, 0, 0, 0, 8, 0);
   DisplaylnWord('rJ', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STJ3;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STj', 3);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rJ.SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STJ(Address, 0, 5*8 + 5);
   Expected.SetBytes(1, 1, 2, 3, 4, 0);
   DisplaylnWord('rJ', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STJ4;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STJ', 4);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rJ.SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STJ(Address, 0, 2*8 + 2);
   Expected.SetBytes(1, 1, 0, 3, 4, 5);
   DisplaylnWord('rJ', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STJ5;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STJ', 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rJ.SetBytes(0, 0, 0, 0, 8, 0);
   Knuth.Inst_STJ(Address, 0, 0*8 + 1);
   Expected.SetBytes(0, 0, 2, 3, 4, 5);
   DisplaylnWord('rI', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STJ6;
var
   Address: integer = 2000;
begin
   {
      Edge case.
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STJ', 6);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rJ.SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_STJ(Address, 0, 0*8 + 5);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('rJ', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STJ7;
var
   Address: integer = 2000;
begin
   {
      Edge case.
   }
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   MakeTitle('STJ', 7);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   Knuth.rJ.SetBytes(1, 0, 0, 0, 8, 0);
   Knuth.Inst_STJ(Address, 0, 0*8 + 0);
   Expected.SetBytes(0, 1, 2, 3, 4, 5);
   DisplaylnWord('rJ', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

(* ************************************************* *)

procedure Test_STZ1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   MakeTitle('STZ', 1);
   Knuth.rA.SetBytes(1, 2, 3, 4, 5, 6);
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_STZ(Address, 0, 0*8 + 5);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STZ2;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   MakeTitle('STZ', 2);
   Knuth.rA.SetBytes(1, 2, 3, 4, 5, 6);
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_STZ(Address, 0, 1*8 + 5);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STZ3;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   MakeTitle('STZ', 3);
   Knuth.rA.SetBytes(1, 2, 3, 4, 5, 6);
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_STZ(Address, 0, 5*8 + 5);
   Expected.SetBytes(1, 1, 2, 3, 4, 0);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STZ4;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   MakeTitle('STZ', 4);
   Knuth.rA.SetBytes(1, 2, 3, 4, 5, 6);
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_STZ(Address, 0, 2*8 + 2);
   Expected.SetBytes(1, 1, 0, 3, 4, 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STZ5;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   MakeTitle('STZ', 5);
   Knuth.rA.SetBytes(1, 2, 3, 4, 5, 6);
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_STZ(Address, 0, 0*8 + 1);
   Expected.SetBytes(0, 0, 2, 3, 4, 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STZ6;
var
   Address: integer = 2000;
begin
   { Edge case. }
   Knuth.Clear;
   MakeTitle('STZ', 6);
   Knuth.rA.SetBytes(1, 2, 3, 4, 5, 6);
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_STZ(Address, 0, 0*8 + 0);
   Expected.SetBytes(0, 1, 2, 3, 4, 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

(* ************************************************* *)

procedure Test_STA_Indexed;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.rI[RegI].SetPacked([PV(-1000,6)]);
   MakeTitle('STA Indexed', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Knuth.rA.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STA(Address + 1000, RegI, 0*8 + 5);
   Expected.SetBytes(0, 6, 7, 8, 9, 0);
   DisplaylnWord('rA', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STX_Indexed;
var
   Address: integer = 2000;
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.rI[RegI].SetPacked([PV(-1000,6)]);
   MakeTitle('STX Indexed', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Knuth.rX.SetBytes(0, 6, 7, 8, 9, 0);
   Knuth.Inst_STX(Address + 1000, RegI, 0*8 + 5);
   Expected.SetBytes(0, 6, 7, 8, 9, 0);
   DisplaylnWord('rX', Knuth.rX);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STI_Indexed;
var
   Address: integer = 2000;
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.rI[RegI].SetPacked([PV(-1000,6)]);
   MakeTitle('STI Indexed', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Knuth.rI[1].SetBytes(1, 0, 0, 8, 9, 0);
   Knuth.Inst_STI(1, Address + 1000, RegI, 0*8 + 5);
   Expected.SetBytes(1, 0, 0, 8, 9, 0);
   DisplaylnWord('rI[1]', Knuth.rI[1]);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STJ_Indexed;
var
   Address: integer = 2000;
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.rI[RegI].SetPacked([PV(-1000,6)]);
   MakeTitle('STJ Indexed', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rI', Knuth.rI[RegI]);
   Knuth.rJ.SetBytes(0, 0, 0, 0, 8, 9);
   Knuth.Inst_STJ(Address + 1000, RegI, 0*8 + 5);
   Expected.SetBytes(0, 0, 0, 0, 8, 9);
   DisplaylnWord('rJ', Knuth.rJ);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

procedure Test_STZ_Indexed;
var
   Address: integer = 2000;
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.Cell[Address].SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.rI[RegI].SetPacked([PV(-1000,6)]);
   Knuth.rA.SetBytes(1, 2, 3, 4, 5, 6);
   MakeTitle('STZ Indexed', 1);
   DisplaylnWord('Cell before', Knuth.Cell[Address]);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_STZ(Address + 1000, RegI, 0*8 + 5);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('Cell after', Knuth.Cell[Address]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.Cell[Address], Expected));
end;

(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;

   Test_STA1;
   Test_STA2;
   Test_STA3;
   Test_STA4;
   Test_STA5;
   Test_STA6;
   Test_STA7;

   Test_STX1;
   Test_STX2;
   Test_STX3;
   Test_STX4;
   Test_STX5;
   Test_STX6;
   Test_STX7;

   Test_STI1;
   Test_STI2;
   Test_STI3;
   Test_STI4;
   Test_STI5;
   Test_STI6;
   Test_STI7;

   Test_STJ1;
   Test_STJ2;
   Test_STJ3;
   Test_STJ4;
   Test_STJ5;
   Test_STJ6;
   Test_STJ7;

   Test_STZ1;
   Test_STZ2;
   Test_STZ3;
   Test_STZ4;
   Test_STZ5;
   Test_STZ6;
   
   Test_STA_Indexed;
   Test_STX_Indexed;
   Test_STI_Indexed;
   Test_STJ_Indexed;
   Test_STZ_Indexed;

   ReportTests;

   Expected.Free;
   Knuth.Free;
end.
