{$mode objfpc}{$R+}{$H+}

program test_arithmetic3;

uses
   mix_word, mix, testing;

var
   Knuth: TMIX;
   Expected, ExpectedA, ExpectedX: TMIXWord;

procedure Test_SidewaysAdd;
var
   Address: integer = 2000;
begin
   Knuth.Clear;
   Knuth.rA.SetBytes(0, 63, 63, 63, 63, 63);
   MakeTitle('Sideways addition', 1);
   DisplaylnWord('rA before', Knuth.rA);
   DisplaylnWord('Cell', Knuth.Cell[Address]);
   Knuth.Inst_STA(Address, 0, 0*8 + 5);
   Knuth.Inst_LDA(Address, 0, 5*8 + 5);
   Knuth.Inst_Add(Address, 0, 4*8 + 4);
   Knuth.Inst_Add(Address, 0, 3*8 + 3);
   Knuth.Inst_Add(Address, 0, 2*8 + 2);
   Knuth.Inst_Add(Address, 0, 1*8 + 1);
   DisplaylnWord('rA after', Knuth.rA);
   Expected.SetPacked([PV(5*63,6)]);
   DisplayWord('Expected', Expected);
   RecordTestResult(EqualWords(Knuth.rA, Expected));
end;

(* Main. *)

begin
   Knuth := TMIX.Create;
   Expected := TMIXWord.Create;
   ExpectedA := TMIXWord.Create;
   ExpectedX := TMIXWord.Create;

   Test_SidewaysAdd;

   ReportTests;

   ExpectedX.Free;
   ExpectedA.Free;
   Expected.Free;
   Knuth.Free;
end.
