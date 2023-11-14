{$mode objfpc}{$R+}{$H+}

program main;

uses
   mix_machine, mix_show, mix_exec; 

var
   MyInstruction: MIXWord;
   
begin
   
   ShowMIXSizes;
   ShowMIXCharTable;
   InitMix;

   rA[0] := 1;
   rA[1] := 2;
   rA[3] := 3;
   rA[4] := 4;
   rA[5] := 5;

   Poke(0, MakeMIXWord(11,22,33,44,55,13));

   ShowMIXState;
   ShowMIXMemory(0,10);

   MyInstruction := MakeMIXWord(0, 0, 0, 0, 0, 8);
   Execute(MyInstruction);

   MyInstruction := MakeMIXWord(0, 0, 0, 0, 0, 7);
   Execute(MyInstruction);


   
end.

