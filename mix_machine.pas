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
   MIXByteValues: byte = 64;
   MIXMemoryWords: integer = 4000;
   rA, rX: MIXRegister;
   rI: array[1..6] of MIXRegister;
   rJ: MIXRegister;
   OI: MIXOverflow;
   CI: MIXComparison;
   Memory: MIXMemory;
   cap_sigma: string = 'Σ';
   cap_delta: string = 'Δ';
   cap_pi: string  = 'Π';
   MIXCharTable: array[0..55] of string =
      (' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
       'I', 'Δ', 'J', 'K', 'L', 'M', 'N', 'O',
       'P', 'Q', 'R', 'Σ', 'Π', 'S', 'T', 'U',
       'V', 'W', 'X', 'Y', 'Z', '0', '1', '2',
       '3', '4', '5', '6', '7', '8', '9', '.',
       ',', '(', ')', '+', '-', '*', '/', '=',
       '$', '<', '>', '@', ';', ':', '''');

procedure InitMIX;
procedure ZeroRegister(var Reg: MIXRegister);   
procedure Poke(Address: integer; W: MIXWord);

implementation

procedure InitMIX;
var
   I, J: integer;
begin
   for I := 0 to 5 do
   begin
      rA[I] := 0;
      rX[I] := 0;
      rJ[I] := 0;
      for J := 1 to 6 do
      begin
         rI[J][I] := 0;
      end;
   end;
   for I := 0 to MIXMemoryWords - 1 do
      for J:= 0 to 5 do
         Memory[I][J] := 0;
   OI := OFF;
   CI := EQUAL; // For now!
end;

procedure ZeroRegister(var Reg: MIXRegister);
var
   I: integer;
begin
   for I := 0 to 5 do Reg[I] := 0;
end;





      
procedure Poke(Address: integer; W: MIXWord);
var
   I: integer;
begin
   for I := 0 to 5 do
      Memory[Address][I] := W[I];
end;



end.
