{$mode objfpc}{$R+}{$H+}

program test_compare;

uses
   mix_word, mix, testing;

var
   Knuth: TMIX;
   Expected: TMIXWord;

procedure Test_CMPA1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(1235,6)]);
   MakeTitle('CMPA', 1);
   DisplaylnWord('rA ', Knuth.rA);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPA(Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = LESS);
end;

procedure Test_CMPA2;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(-1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(-1234,6)]);
   MakeTitle('CMPA', 2);
   DisplaylnWord('rA ', Knuth.rA);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPA(Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = EQUAL);
end;

procedure Test_CMPA3;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(-1234,6)]);
   MakeTitle('CMPA', 3);
   DisplaylnWord('rA ', Knuth.rA);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPA(Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = GREATER);
end;

procedure Test_CMPA4;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 8, 9);
   MakeTitle('CMPA', 4);
   DisplaylnWord('rA ', Knuth.rA);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPA(Address, 0, 1*8 + 3);
   RecordTestResult(Knuth.CI = EQUAL);
end;

procedure Test_CMPA5;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 8, 9);
   MakeTitle('CMPA', 5);
   DisplaylnWord('rA ', Knuth.rA);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPA(Address, 0, 1*8 + 0);
   RecordTestResult(Knuth.CI = EQUAL);
end;

(* *********************************************** *)

procedure Test_CMPX1;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rX.SetPacked([PV(1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(1236,6)]);
   MakeTitle('CMPX', 1);
   DisplaylnWord('rX ', Knuth.rX);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPX(Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = LESS);
end;

procedure Test_CMPX2;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rX.SetPacked([PV(-1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(-1234,6)]);
   MakeTitle('CMPX', 2);
   DisplaylnWord('rX ', Knuth.rX);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPX(Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = EQUAL);
end;

procedure Test_CMPX3;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rX.SetPacked([PV(1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(-1234,6)]);
   MakeTitle('CMPX', 3);
   DisplaylnWord('rX ', Knuth.rX);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPX(Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = GREATER);
end;

procedure Test_CMPX4;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 8, 9);
   MakeTitle('CMPX', 4);
   DisplaylnWord('rX ', Knuth.rX);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPX(Address, 0, 1*8 + 3);
   RecordTestResult(Knuth.CI = EQUAL);
end;

procedure Test_CMPX5;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 8, 9);
   MakeTitle('CMPX', 5);
   DisplaylnWord('rX ', Knuth.rX);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPX(Address, 0, 1*8 + 0);
   RecordTestResult(Knuth.CI = EQUAL);
end;

(* *********************************************** *)

procedure Test_CMPi1;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 1, 2);
   Knuth.Cell[Address].SetBytes(0, 0, 0, 0, 1, 3);;
   MakeTitle('CMPi', 1);
   DisplaylnWord('rI[RegI] ', Knuth.rI[RegI]);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPi(RegI, Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = LESS);
end;

procedure Test_CMPi2;
var
   Address: integer = 2000;
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetPacked([PV(-1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(-1234,6)]);
   MakeTitle('CMPi', 2);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPi(RegI, Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = EQUAL);
end;

procedure Test_CMPi3;
var
   Address: integer = 2000;
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetPacked([PV(1234,6)]);
   Knuth.Cell[Address].SetPacked([PV(-1234,6)]);
   MakeTitle('CMPi', 3);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPi(RegI, Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = GREATER);
end;

procedure Test_CMPi4;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 0, 0, 0, 8, 9);
   MakeTitle('CMPi', 4);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPi(RegI, Address, 0, 1*8 + 3);
   RecordTestResult(Knuth.CI = EQUAL);
end;

procedure Test_CMPi5;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 8, 9);
   MakeTitle('CMPi', 5);
   DisplaylnWord('r{RegI]', Knuth.rI[RegI]);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPi(RegI, Address, 0, 0*8 + 0);
   RecordTestResult(Knuth.CI = EQUAL);
end;

procedure Test_CMPi6;
var
   Address: integer = 2000;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(1, 1, 2, 3, 4, 5);
   Knuth.Cell[Address].SetBytes(0, 1, 2, 3, 8, 9);
   MakeTitle('CMPX', 6);
   DisplaylnWord('rX ', Knuth.rX);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPi(RegI, Address, 0, 1*8 + 2);
   RecordTestResult(not (Knuth.CI = GREATER));
end;

(* *********************************************** *)

procedure Test_CMPA_Indexed;
var
   Address: integer = 2000;
   IndexReg: integer = 3;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(1234,6)]);
   Knuth.rI[IndexReg].SetPacked([PV(1000,6)]);
   Knuth.Cell[Address].SetPacked([PV(1235,6)]);
   MakeTitle('CMPA indexed', 1);
   DisplaylnWord('rA ', Knuth.rA);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPA(1000, IndexReg, 0*8 + 5);
   RecordTestResult(Knuth.CI = LESS);
end;

procedure Test_CMPX_Indexed;
var
   Address: integer = 2000;
   IndexReg: integer = 3;
begin
   Knuth.Clear;
   Knuth.rX.SetPacked([PV(1234,6)]);
   Knuth.rI[IndexReg].SetPacked([PV(1000,6)]);
   Knuth.Cell[Address].SetPacked([PV(1235,6)]);
   MakeTitle('CMPX indexed', 1);
   DisplaylnWord('rX', Knuth.rX);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPA(1000, IndexReg, 0*8 + 5);
   RecordTestResult(Knuth.CI = LESS);
end;

procedure Test_CMPi_Indexed;
var
   Address: integer = 2000;
   RegI: integer = 1;
   IndexReg: integer = 3;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 1, 2);
   Knuth.Cell[Address].SetBytes(0, 0, 0, 0, 1, 3);;
   Knuth.rI[IndexReg].SetPacked([PV(1000,6)]);
   MakeTitle('CMPi indexed', 1);
   DisplaylnWord('rI[RegI] ', Knuth.rI[RegI]);
   DisplayWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_CMPi(RegI, Address, 0, 0*8 + 5);
   RecordTestResult(Knuth.CI = LESS);
end;

(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;

   Test_CMPA1;
   Test_CMPA2;
   Test_CMPA3;
   Test_CMPA4;
   Test_CMPA5;

   Test_CMPX1;
   Test_CMPX2;
   Test_CMPX3;
   Test_CMPX4;
   Test_CMPX5;

   Test_CMPi1;
   Test_CMPi2;
   Test_CMPi3;
   Test_CMPi4;
   Test_CMPi5;
   Test_CMPi6;
   
   Test_CMPA_Indexed;
   Test_CMPX_Indexed;
   Test_CMPi_Indexed;


   ReportTests;

   Expected.Free;
   Knuth.Free;
end.
