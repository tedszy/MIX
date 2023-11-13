{$mode objfpc}{$R+}{$H+}

unit mix_machine;

interface
   
type
   MIXByte = byte;
   MIXWord = array[0..5] of MIXByte;
   MIXRegister = array[0..5] of MIXByte;
   MIXMemory = array[0..3999] of MIXWord;
   MIXOverflow = (ON, OFF);
   MIXComparison = (LESS, EQUAL, GREATER);
   MIXUnit = (U0, U1, U2, U3, U4, U5, U6, U7, U8, U9,
              U10, U11, U12, U13, U14, U15, U16, U17,
              U18, U19);
      
var

   // A number larger than 63 will not appear in a MIX byte.
   MIXByteValues: byte = 64;
   
   MIXMemoryWords: integer = 4000;
   rA, rX: MIXRegister;
   rI1, rI2, rI3, rI4, rI5, rI6: MIXRegister;
   rJ: MIXRegister;
   OI: MIXOverflow;
   CI: MIXComparison;
   Memory: MIXMemory;
   cap_sigma: string = 'Σ';
   cap_delta: string = 'Δ';
   cap_pi: string  = 'Π';
   MIXCharTable: array[0..24] of string =
      (' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
       'I', 'Δ', 'J', 'K', 'L', 'M', 'N', 'O',
       'P', 'Q', 'R', 'Σ', 'Π', 'S', 'T', 'U');

procedure InitMIX;
   
implementation

procedure InitMIX;
var
   I, J: integer;
begin
   for I := 0 to 5 do
   begin
      rA[I] := 0;
      rX[I] := 0;
      rI1[I] := 0;
      rI2[I] := 0;
      rI3[I] := 0;
      rI4[I] := 0;
      rI5[I] := 0;
      rI6[I] := 0;
      rJ[I] := 0;
   end;
   for I := 0 to MIXMemoryWords - 1 do
      for J:= 0 to 5 do
         Memory[I][J] := 0;
   OI := OFF;
   CI := EQUAL; // For now!
end;


end.
