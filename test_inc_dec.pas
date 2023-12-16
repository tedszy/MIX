{$mode objfpc}{$R+}{$H+}

program test_inc_dec;

uses
   mix_word, mix, testing;

var
   Knuth: TMIX;
   Expected: TMIXWord;

procedure Test_INCA1;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 1, 2, 3, 4, 63);
   MakeTitle('INCA', 1);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_INCA(1, 0);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(0, 1, 2, 3, 5, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_INCA2;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 63, 63, 63, 63, 63);
   MakeTitle('INCA', 2);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_INCA(10, 0);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 0, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = ON));
end;

(* *************************************** *)

procedure Test_INCX1;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(0, 1, 2, 3, 4, 63);
   MakeTitle('INCX', 1);
   DisplaylnWord('rA before', Knuth.rX);
   Knuth.Inst_INCX(1, 0);
   DisplaylnWord('rX after', Knuth.rX);
   Expected.SetBytes(0, 1, 2, 3, 5, 0);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_INCX2;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(0, 63, 63, 63, 63, 63);
   MakeTitle('INCX', 2);
   DisplaylnWord('rX before', Knuth.rX);
   Knuth.Inst_INCX(10, 0);
   DisplaylnWord('rX after', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 0, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected) and (Knuth.OT = ON));
end;

(* *************************************** *)

procedure Test_INCi1;
var
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 0, 1);
   MakeTitle('INCi', 1);
   DisplaylnWord('rI[RegI] before', Knuth.rI[RegI]);
   Knuth.Inst_INCi(RegI, 10, 0);
   DisplaylnWord('rI[RegI] after', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 0, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_INCi2;
var
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 61, 63);
   MakeTitle('INCi', 2);
   DisplaylnWord('rI[RegI] before', Knuth.rI[RegI]);
   Knuth.Inst_INCi(RegI, 10, 0);
   DisplaylnWord('rI[RegI] after', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 62, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

(* *************************************** *)

procedure Test_DECA1;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 0, 0, 0);
   MakeTitle('DECA', 1);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_DECA(1, 0);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 1);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_DECA2;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(1, 63, 63, 63, 63, 63);
   MakeTitle('DECA', 2);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_DECA(10, 0);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected) and (Knuth.OT = ON));
end;

(* *************************************** *)

procedure Test_DECX1;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(0, 0, 0, 0, 0, 0);
   MakeTitle('DECX', 1);
   DisplaylnWord('rX before', Knuth.rX);
   Knuth.Inst_DECX(1, 0);
   DisplaylnWord('rX after', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 1);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_DECX2;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(1, 63, 63, 63, 63, 63);
   MakeTitle('DECX', 2);
   DisplaylnWord('rX before', Knuth.rX);
   Knuth.Inst_DECX(10, 0);
   DisplaylnWord('rX after', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected) and (Knuth.OT = ON));
end;

(* *************************************** *)

procedure Test_DECi1;
var
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 0, 0);
   MakeTitle('DECi', 1);
   DisplaylnWord('r[RegI] before', Knuth.rI[RegI]);
   Knuth.Inst_DECi(RegI, 1, 0);
   DisplaylnWord('rI[RegI] after', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 1);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

procedure Test_DECi2;
var
   RegI: integer = 6;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(1, 0, 0, 0, 62, 63);
   MakeTitle('DECi', 2);
   DisplaylnWord('rI[RegI] before', Knuth.rI[RegI]);
   Knuth.Inst_DECi(RegI, 10, 0);
   DisplaylnWord('rI[RegI] after', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 63, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

(* Tests with index registers. *)

procedure Test_INCA_Indexed;
var
   IndexRegister: integer = 3;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 0, 0, 63);
   Knuth.rI[IndexRegister].SetPacked([PV(5,6)]);
   MakeTitle('INCA indexed', 1);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_INCA(5, IndexRegister);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(0, 0, 0, 0, 1, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_INCX_Indexed;
var
   IndexRegister: integer = 3;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(0, 0, 0, 0, 0, 63);
   Knuth.rI[IndexRegister].SetPacked([PV(5,6)]);
   MakeTitle('INCX indexed', 1);
   DisplaylnWord('rX before', Knuth.rX);
   Knuth.Inst_INCX(5, IndexRegister);
   DisplaylnWord('rX after', Knuth.rX);
   Expected.SetBytes(0, 0, 0, 0, 1, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_INCi_Indexed;
var
   IndexRegister: integer = 3;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 0, 63);
   Knuth.rI[IndexRegister].SetPacked([PV(5,6)]);
   MakeTitle('INCi indexed', 1);
   DisplaylnWord('rI[RegI] before', Knuth.rI[RegI]);
   Knuth.Inst_INCi(RegI, 5, IndexRegister);
   DisplaylnWord('rI[RegI] after', Knuth.rI[RegI]);
   Expected.SetBytes(0, 0, 0, 0, 1, 9);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;








procedure Test_DECA_Indexed;
var
   IndexRegister: integer = 3;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.rI[IndexRegister].SetPacked([PV(5,6)]);
   MakeTitle('DECA indexed', 1);
   DisplaylnWord('rA before', Knuth.rA);
   Knuth.Inst_DECA(5, IndexRegister);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetBytes(1, 0, 0, 0, 0, 10);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

procedure Test_DECX_Indexed;
var
   IndexRegister: integer = 3;
begin
   Knuth.Clear;
   Knuth.rX.SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.rI[IndexRegister].SetPacked([PV(5,6)]);
   MakeTitle('DECX indexed', 1);
   DisplaylnWord('rX before', Knuth.rX);
   Knuth.Inst_DECX(5, IndexRegister);
   DisplaylnWord('rX after', Knuth.rX);
   Expected.SetBytes(1, 0, 0, 0, 0, 10);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rX, Expected));
end;

procedure Test_DECi_Indexed;
var
   IndexRegister: integer = 3;
   RegI: integer = 1;
begin
   Knuth.Clear;
   Knuth.rI[RegI].SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.rI[IndexRegister].SetPacked([PV(5,6)]);
   MakeTitle('DECi indexed', 1);
   DisplaylnWord('rI[RegI] before', Knuth.rI[RegI]);
   Knuth.Inst_DECi(RegI, 5, IndexRegister);
   DisplaylnWord('rI[RegI] after', Knuth.rI[RegI]);
   Expected.SetBytes(1, 0, 0, 0, 0, 10);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rI[RegI], Expected));
end;

(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;

   Test_INCA1;
   Test_INCA2;

   Test_INCX1;
   Test_INCX2;

   Test_INCi1;
   Test_INCi2;

   Test_DECA1;
   Test_DECA2;

   Test_DECX1;
   Test_DECX2;

   Test_DECi1;
   Test_DECi2;

   Test_INCA_Indexed;
   Test_INCX_Indexed;
   Test_INCi_Indexed;
   Test_DECA_Indexed;
   Test_DECX_Indexed;
   Test_DECi_Indexed;

   ReportTests;

   Expected.Free;
   Knuth.Free;
end.
