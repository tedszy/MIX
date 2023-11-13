{$mode objfpc}{$R+}{$H+}

program main;

uses
   mix_machine, mix_show; 

var
   TempWord: MIXWord;
   
procedure Poke(Address: integer; W: MIXWord);
var
   I: integer;
begin
   for I := 0 to 5 do
      Memory[Address][I] := W[I];
end;
   
begin
   
   ShowMIXSizes;
   ShowMIXCharTable;
   InitMix;

   rA[0] := 1;
   rA[1] := 2;
   rA[3] := 3;
   rA[4] := 4;
   rA[5] := 5;

   TempWord[0] := 1;
   TempWord[1] := 32;
   TempWord[2] := 17;
   Tempword[3] := 55;
   TempWord[4] := 41;
   TempWord[5] := 28;
   Poke(0, TempWord);

   ShowMIXState;
   ShowMIXMemory(0,10);
   
end.

