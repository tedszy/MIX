{$mode objfpc}{$R+}{$H+}

program main;

uses
   mix_machine, mix_show, mix_exec; 

   
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
   
end.

