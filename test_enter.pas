{$mode objfpc}{$R+}{$H+}

{
   Address transfer operations.
}

program test_enter;

uses
   mix_word, mix, testing;

var
   Knuth: TMIX;
   Expected: TMIXWord;

procedure Test_ENTA1;
begin
   { ENTA 0 }
   Knuth.Clear;
   Knuth.Inst_ENTA(0, 0, 0);
   MakeTitle('ENTA', 1);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENTA2;
begin
   { ENTA -0 }
   Knuth.Clear;
   Knuth.Inst_ENTA(0, 0, 1);
   MakeTitle('ENTA', 2);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENTA3;
var
   RegI: integer = 1;
begin
   { 
      ENTA -1000,1
      If the result of the indexing gives M=0, 
      then + (from the instruction itself, is loaded.
   }
   Knuth.Clear;
   Knuth.rI[RegI].SetPacked([PV(1000,6)]);
   Knuth.Inst_ENTA(-1000, RegI, 1);
   MakeTitle('ENTA', 3);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENTA4;
var
   RegI: integer = 1;
begin
   { ENTA 0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTA(0, RegI, 0);
   MakeTitle('ENTA', 4);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENTA5;
var
   RegI: integer = 1;
begin
   { ENTA -0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTA(0, RegI, 1);
   MakeTitle('ENTA', 5);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENTA6;
begin
   { ENTA -1234 }
   Knuth.Clear;
   Knuth.Inst_ENTA(-1234, 0);
   MakeTitle('ENTA', 6);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(-1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENTA7;
begin
   { ENTA 1234 }
   Knuth.Clear;
   Knuth.Inst_ENTA(1234, 0);
   MakeTitle('ENTA', 7);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

(* ********************************* *)

procedure Test_ENTX1;
begin
   { ENTX 0 }
   Knuth.Clear;
   Knuth.Inst_ENTX(0, 0, 0);
   MakeTitle('ENTX', 1);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENTX2;
begin
   { ENTX -0 }
   Knuth.Clear;
   Knuth.Inst_ENTX(0, 0, 1);
   MakeTitle('ENTX', 2);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENTX3;
var
   RegI: integer = 1;
begin
   { 
      ENTX -1000,1
      If the result of the indexing gives M=0, 
      then + (from the instruction itself, is loaded.
   }
   Knuth.Clear;
   Knuth.rI[RegI].SetPacked([PV(1000,6)]);
   Knuth.Inst_ENTX(-1000, RegI, 1);
   MakeTitle('ENTX', 3);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENTX4;
var
   RegI: integer = 1;
begin
   { ENTX 0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTX(0, RegI, 0);
   MakeTitle('ENTX', 4);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENTX5;
var
   RegI: integer = 1;
begin
   { ENTX -0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTX(0, RegI, 1);
   MakeTitle('ENTX', 5);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENTX6;
begin
   { ENTX -1234 }
   Knuth.Clear;
   Knuth.Inst_ENTX(-1234, 0);
   MakeTitle('ENTX', 6);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(-1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENTX7;
begin
   { ENTX 1234 }
   Knuth.Clear;
   Knuth.Inst_ENTX(1234, 0);
   MakeTitle('ENTX', 7);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

(* ********************************* *)






procedure Test_ENTi1;
var
   RegI: integer = 3;
begin
   { ENT3 0 }
   Knuth.Clear;
   Knuth.Inst_ENTi(3, 0, 0, 0);
   MakeTitle('ENTi', 1);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi2;
var
   RegI: integer = 3;
begin
   { ENT3 -0 }
   Knuth.Clear;
   Knuth.Inst_ENTi(RegI, 0, 0, 1);
   MakeTitle('ENTi', 2);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi3;
var
   RegI: integer = 3;
begin
   { 
      ENTX -1000,1
      If the result of the indexing gives M=0, 
      then + (from the instruction itself, is loaded.
   }
   Knuth.Clear;
   Knuth.rI[1].SetPacked([PV(1000,6)]);
   Knuth.Inst_ENTi(RegI, -1000, 1, 1);
   MakeTitle('ENTi', 3);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi4;
var
   RegI: integer = 1;
begin
   { ENTX 0,1 }
   Knuth.Clear;
   Knuth.rI[3].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTi(RegI, 0, 3, 0);
   MakeTitle('ENTi', 4);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi5;
var
   RegI: integer = 1;
begin
   { ENTi -0,1 }
   Knuth.Clear;
   Knuth.rI[6].SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTi(RegI, 0, 6, 1);
   MakeTitle('ENTi', 5);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi6;
var
   RegI: integer = 1;
begin
   { ENTi -1234 }
   Knuth.Clear;
   Knuth.Inst_ENTi(RegI, -1234, 0);
   MakeTitle('ENTi', 6);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetPacked([PV(-1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi7;
var
   RegI: integer = 3;
begin
   { ENTi 1234 }
   Knuth.Clear;
   Knuth.Inst_ENTi(RegI, 1234, 0);
   MakeTitle('ENTi', 7);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetPacked([PV(1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi8;
var
   RegI: integer = 3;
begin
   { ENT3 0,3 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTi(RegI, 0, RegI, 0);
   MakeTitle('ENTi', 8);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENTi9;
var
   RegI: integer = 3;
begin
   { ENT3 -0,3 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENTi(RegI, 0, RegI, 1);
   MakeTitle('ENTi', 9);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

(* ********************************* *)

(* ********************************* *)
(* ********************************* *)
(* ********************************* *)


procedure Test_ENNA1;
begin
   { ENNA 0 }
   Knuth.Clear;
   Knuth.Inst_ENNA(0, 0, 0);
   MakeTitle('ENNA', 1);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENNA2;
begin
   { ENNA -0 }
   Knuth.Clear;
   Knuth.Inst_ENNA(0, 0, 1);
   MakeTitle('ENNA', 2);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENNA3;
var
   RegI: integer = 1;
begin
   { ENNA -1000,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetPacked([PV(1000,6)]);
   Knuth.Inst_ENNA(-1000, RegI, 1);
   MakeTitle('ENNA', 3);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENNA4;
var
   RegI: integer = 1;
begin
   { ENNA 0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNA(0, RegI, 0);
   MakeTitle('ENNA', 4);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENNA5;
var
   RegI: integer = 1;
begin
   { ENNA -0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNA(0, RegI, 1);
   MakeTitle('ENTA', 5);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENNA6;
begin
   { ENNA -1234 }
   Knuth.Clear;
   Knuth.Inst_ENNA(-1234, 0);
   MakeTitle('ENNA', 6);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_ENNA7;
begin
   { ENNA 1234 }
   Knuth.Clear;
   Knuth.Inst_ENNA(1234, 0);
   MakeTitle('ENNA', 7);
   DisplaylnWord('rA', Knuth.rA);
   Expected.SetPacked([PV(-1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

(* ********************************* *)

procedure Test_ENNX1;
begin
   { ENNX 0 }
   Knuth.Clear;
   Knuth.Inst_ENNX(0, 0, 0);
   MakeTitle('ENNX', 1);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENNX2;
begin
   { ENNX -0 }
   Knuth.Clear;
   Knuth.Inst_ENNX(0, 0, 1);
   MakeTitle('ENNX', 2);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENNX3;
var
   RegI: integer = 1;
begin
   { ENTX -1000,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetPacked([PV(1000,6)]);
   Knuth.Inst_ENNX(-1000, RegI, 1);
   MakeTitle('ENNX', 3);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENNX4;
var
   RegI: integer = 1;
begin
   { ENNX 0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNX(0, RegI, 0);
   MakeTitle('ENNX', 4);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENNX5;
var
   RegI: integer = 1;
begin
   { ENNX -0,1 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNX(0, RegI, 1);
   MakeTitle('ENNX', 5);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENNX6;
begin
   { ENNX -1234 }
   Knuth.Clear;
   Knuth.Inst_ENNX(-1234, 0);
   MakeTitle('ENNX', 6);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_ENNX7;
begin
   { ENNX 1234 }
   Knuth.Clear;
   Knuth.Inst_ENNX(1234, 0);
   MakeTitle('ENNX', 7);
   DisplaylnWord('rX', Knuth.rX);
   Expected.SetPacked([PV(-1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

(* ********************************* *)

procedure Test_ENNi1;
var
   RegI: integer = 3;
begin
   { ENN3 0 }
   Knuth.Clear;
   Knuth.Inst_ENNi(3, 0, 0, 0);
   MakeTitle('ENNi', 1);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi2;
var
   RegI: integer = 3;
begin
   { ENN3 -0 }
   Knuth.Clear;
   Knuth.Inst_ENNi(RegI, 0, 0, 1);
   MakeTitle('ENNi', 2);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi3;
var
   RegI: integer = 3;
begin
   { ENNX -1000,1 }
   Knuth.Clear;
   Knuth.rI[1].SetPacked([PV(1000,6)]);
   Knuth.Inst_ENNi(RegI, -1000, 1, 1);
   MakeTitle('ENNi', 3);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi4;
var
   RegI: integer = 1;
begin
   { ENNX 0,1 }
   Knuth.Clear;
   Knuth.rI[3].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNi(RegI, 0, 3, 0);
   MakeTitle('ENNi', 4);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi5;
var
   RegI: integer = 1;
begin
   { ENNi -0,1 }
   Knuth.Clear;
   Knuth.rI[6].SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNi(RegI, 0, 6, 1);
   MakeTitle('ENNi', 5);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi6;
var
   RegI: integer = 1;
begin
   { ENNi -1234 }
   Knuth.Clear;
   Knuth.Inst_ENNi(RegI, -1234, 0);
   MakeTitle('ENNi', 6);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetPacked([PV(1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi7;
var
   RegI: integer = 3;
begin
   { ENNi 1234 }
   Knuth.Clear;
   Knuth.Inst_ENNi(RegI, 1234, 0);
   MakeTitle('ENNi', 7);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetPacked([PV(-1234,6)]);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi8;
var
   RegI: integer = 3;
begin
   { ENN3 0,3 : -0 remains -0. }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNi(RegI, 0, RegI, 0);
   MakeTitle('ENNi', 8);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_ENNi9;
var
   RegI: integer = 3;
begin
   { ENN3 -0,3 }
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.Inst_ENNi(RegI, 0, RegI, 1);
   MakeTitle('ENNi', 9);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;

   Test_ENTA1;
   Test_ENTA2;
   Test_ENTA3;
   Test_ENTA4;
   Test_ENTA5;
   Test_ENTA6;
   Test_ENTA7;

   Test_ENTX1;
   Test_ENTX2;
   Test_ENTX3;
   Test_ENTX4;
   Test_ENTX5;
   Test_ENTX6;
   Test_ENTX7;

   Test_ENTi1;
   Test_ENTi2;
   Test_ENTi3;
   Test_ENTi4;
   Test_ENTi5;
   Test_ENTi6;
   Test_ENTi7;
   Test_ENTi8;
   Test_ENTi9;

   (* *** *)

   Test_ENNA1;
   Test_ENNA2;
   Test_ENNA3;
   Test_ENNA4;
   Test_ENNA5;
   Test_ENNA6;
   Test_ENNA7;

   Test_ENNX1;
   Test_ENNX2;
   Test_ENNX3;
   Test_ENNX4;
   Test_ENNX5;
   Test_ENNX6;
   Test_ENNX7;

   Test_ENNi1;
   Test_ENNi2;
   Test_ENNi3;
   Test_ENNi4;
   Test_ENNi5;
   Test_ENNi6;
   Test_ENNi7;
   Test_ENNi8;
   Test_ENNi9;

   ReportTests;

   Expected.Free;
   Knuth.Free;
end.
