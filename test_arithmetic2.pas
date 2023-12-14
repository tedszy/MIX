{$mode objfpc}{$R+}{$H+}

{
   Test MUL, DIV.
}

program test_arithmetic2;

uses
   mix_word, mix_new, testing_new;

var
   Knuth: TMIX;
   ExpectedA, ExpectedX: TMIXWord;

procedure Test_MUL1;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 1, 1, 1, 1, 1);
   Knuth.Cell[Address].SetBytes(0, 1, 1, 1, 1, 1);
   MakeTitle('MUL', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_MUL(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(0, 0, 1, 2, 3, 4);
   ExpectedX.SetBytes(0, 5, 4, 3, 2, 1);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;

procedure Test_MUL2;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(-112,6)]);
   Knuth.Cell[Address].SetBytes(1, 2, 3, 4, 5, 6);
   MakeTitle('MUL', 2);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_MUL(Address, 0, 1*8 + 1);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(1, 0, 0, 0, 0, 0);
   ExpectedX.SetPacked([PV(-224,6)]);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;

procedure Test_MUL3;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetPacked([PV(-50,2),PV(0,1),PV(112,2),PV(4,1)]);
   Knuth.Cell[Address].SetBytes(1, 2, 0, 0, 0, 0);
   MakeTitle('MUL', 3);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_MUL(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetPacked([PV(100,3),PV(0,1),PV(224,2)]);
   ExpectedX.SetPacked([PV(8,2),PV(0,4)]);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;

procedure Test_MUL4;
var
   Address: integer = 1000;
begin
   { 
      Edge case: rA=-0 * V=-0 should be rA,rX = 0,-0.
   }    
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.Cell[Address].SetBytes(1, 0, 0, 0, 0, 0);
   MakeTitle('MUL', 4);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_MUL(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(1, 0, 0, 0, 0, 0);
   ExpectedX.SetBytes(1, 0, 0, 0, 0, 0);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;

procedure Test_MUL5;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(1, 63, 63, 63, 63, 63);
   Knuth.Cell[Address].SetBytes(1, 63, 63, 63, 63, 63);
   MakeTitle('MUL', 5);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_MUL(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(0, 63, 63, 63, 63, 62);
   ExpectedX.SetBytes(0, 0, 0, 0, 0, 1);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;

(* ************************************* *)

procedure Test_DIV1;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 0, 0, 0);
   Knuth.rX.SetBytes(1, 0, 0, 0, 0, 17);
   Knuth.Cell[Address].SetBytes(0, 0, 0, 0, 0, 3);
   MakeTitle('DIV', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_DIV(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(0, 0, 0, 0, 0, 5);
   ExpectedX.SetBytes(0, 0, 0, 0, 0, 2);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;

procedure Test_DIV2;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(1, 0, 0, 0, 0, 0);
   Knuth.rX.SetPacked([PV(1235,3),PV(0,1),PV(3,1),PV(1,1)]);
   Knuth.Cell[Address].SetBytes(1, 0, 0, 0, 2, 0);
   MakeTitle('DIV', 2);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_DIV(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetPacked([PV(617,4),PV(32,1),PV(1,1)]);
   ExpectedX.SetBytes(1, 0, 0, 0, 1, 1);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;


{
   Testing overflows.

   When |rA| >= |V|, the quotient |rA| div |V| cannot fit into five bytes.
   Observe:

   Ten byte contents of (rA,rX):

      (rA,rX) = [0; 0; 28; 4; 33 | 58; 11; 52; 52; 63] = 123456589876543
      rA      = [0; 0; 28; 4; 33]                      = 114977

   Let's choose a V such that |rA| < |V| and perform the division.

      V             = [28; 4; 34]          = 114978
      (rA,rX) div V = [63; 63; 63; 50; 47] = 1073740975
      (rA,rX) mod V = [12; 60; 1]          = 52993

   The quotient fits into five bytes. But if we make V smaller,
   so that |rA| >= |V|,

      V             = [28;4;33]           = 114977
      (rA,rX) div V = [1; 0; 0; 2; 4; 42] = 1073750314
      (rA,rX) mod V = [5; 51; 21]         = 23765

   and the quotient (div) is six bytes and cannot fit back in to rA.
   Thus in this case we have to signal an overflow, just as in the 
   divide-by-zero case.
}

procedure Test_DIV3;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 28, 4, 33);
   Knuth.rX.SetBytes(0, 58, 11, 52, 52, 63);
   Knuth.Cell[Address].SetPacked([PV(114978, 6)]);
   MakeTitle('DIV', 3);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_DIV(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(0, 63, 63, 63, 50, 47);
   ExpectedX.SetBytes(0, 0, 0, 12, 60, 1);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      EqualWords(Knuth.rX, ExpectedX) and (Knuth.OT = OFF));
end;

procedure Test_DIV4;
var
   Address: integer = 1000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 28, 4, 33);
   Knuth.rX.SetBytes(0, 58, 11, 52, 52, 63);
   Knuth.Cell[Address].SetPacked([PV(114977, 6)]);
   MakeTitle('DIV', 4);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_DIV(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(0, 0, 0, 0, 0, 0);
   ExpectedX.SetBytes(0, 0, 0, 0, 0, 0);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      EqualWords(Knuth.rX, ExpectedX) and (Knuth.OT = ON));
end;

(* ************************************* *)

procedure Test_MUL_Indexed;
var
   Address: integer = 2000;
   RegI: byte = 1;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 1, 1, 1, 1, 1);
   Knuth.Cell[Address].SetBytes(0, 1, 1, 1, 1, 1);
   Knuth.rI[RegI].SetPacked([PV(1000,6)]);
   MakeTitle('MUL indexed', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_MUL(1000, RegI, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(0, 0, 1, 2, 3, 4);
   ExpectedX.SetBytes(0, 5, 4, 3, 2, 1);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      (EqualWords(Knuth.rX, ExpectedX)));
end;

procedure Test_DIV_Indexed;
var
   Address: integer = 2000;
   RegI: byte = 6;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 0, 0, 28, 4, 33);
   Knuth.rX.SetBytes(0, 58, 11, 52, 52, 63);
   Knuth.Cell[Address].SetPacked([PV(114978, 6)]);
   Knuth.rI[RegI].SetPacked([PV(1000,6)]);
   MakeTitle('DIV indexed', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('rX before', Knuth.rX);
   DisplaylnWord('rI[RegI]', Knuth.rI[RegI]);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_DIV(Address, 0, 0*8 + 5);
   DisplaylnWord('rA after', Knuth.rA);
   DisplaylnWord('rX after', Knuth.rX);
   ExpectedA.SetBytes(0, 63, 63, 63, 50, 47);
   ExpectedX.SetBytes(0, 0, 0, 12, 60, 1);
   DisplaylnWord('ExpectedA', ExpectedA);
   DisplayWord('ExpectedX', ExpectedX);
   RecordTestResult(EqualWords(Knuth.rA, ExpectedA) and 
      EqualWords(Knuth.rX, ExpectedX) and (Knuth.OT = OFF));
end;


(* Main. *)

begin
   Knuth := TMIX.Create;
   ExpectedA := TMIXWord.Create;
   ExpectedX := TMIXWord.Create;

   Test_MUL1;
   Test_MUL2;
   Test_MUL3;
   Test_MUL4;
   Test_MUL5;

   Test_DIV1;
   Test_DIV2;
   Test_DIV3;
   Test_DIV4;

   Test_MUL_Indexed;
   Test_DIV_Indexed;

   ReportTests;

   ExpectedA.Free;
   ExpectedX.Free;
   Knuth.Free;
end.
