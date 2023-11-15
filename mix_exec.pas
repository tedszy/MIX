{$mode objfpc}{$R+}{$H+}{$ASSERTIONS ON}

unit mix_exec;

interface

uses
   mix_machine;

type
   Field = record
      start: byte;
      stop: byte;
   end;


function MakeMIXWord(w0: byte; w1: byte; w2: byte; w3: byte;
                     w4: byte; w5: byte): MIXWord;

function EncodeField(F: Field): MIXByte;
function DecodeField(B: MIXByte): Field;

function MakeInstruction(C_Opcode: MIXByte;
                         Address: integer;
                         I_Index: MIXByte;
                         F_Modifier: MIXByte): MIXWord;

procedure Execute(Instruction: MIXWord);

implementation

{ 

  Instruction layout:

  [  +- A A  |  I  |  F  |  C  ] 

}

function MakeMIXWord(w0: byte; w1: byte; w2: byte; w3: byte;
                     w4: byte; w5: byte): MIXWord;
begin
   MakeMIXWord[0] := w0;
   MakeMIXWord[1] := w1;
   MakeMIXWord[2] := w2;
   MakeMIXWord[3] := w3;
   MakeMIXWord[4] := w4;
   MakeMIXWord[5] := w5;
end;


function GetAddress(Instruction: MIXWord): integer;
var
   Address: integer;
   Sign: byte;
begin
   sign := Instruction[0];
   Assert((sign = 0) or (sign = 1), 'GetAddress: bad sign byte.');
   Address := Instruction[1]*MIXByteValues + Instruction[2];
   if Sign = 0 then
      GetAddress := Address
   else
      GetAddress := -Address;
end;

function EncodeField(F: Field): MIXByte;
begin
   EncodeField := F.Start*8 + F.Stop;
end;

function DecodeField(B: MIXByte): Field;
var
   F: Field;
begin
   F.Start := B div 8;
   F.Stop := B mod 8;
   DecodeField := F;
end;


// OP ADDRESS,I(F)
function MakeInstruction(C_Opcode: MIXByte;
                         Address: integer;
                         I_Index: MIXByte;
                         F_Modifier: MIXByte): MIXWord;
var
   Sign, A1, A2: byte;
begin
   if Address < 0 then Sign := 1 else Sign := 0;
   A1 := abs(Address) div 64;
   A2 := abs(Address) mod 64;
   MakeInstruction := MakeMIXWord(Sign, A1, A2, I_Index, F_Modifier, C_OpCode); 
end;

procedure Execute(Instruction: MIXWord);
var
   C_OpCode: MIXByte; 
   F_Modifier: MIXByte;
   I_Index: MIXByte;
   Address: integer;
   F_Field: Field;
   I: integer;
   Sign: integer;
begin
   C_OpCode := Instruction[5];
   F_Modifier := Instruction[4];
   I_Index := Instruction[3];
   Address := GetAddress(Instruction);
   case C_OpCode of
      
      8: begin // LDA
            // Zero out rA.
            ZeroRegister(rA);
            // Add contents of index register to Address.
            // Remember that index register has a sign.
            if I_Index > 0 then
            begin
               if rI[I_Index][0] = 1 then
                  Sign := -1
               else
                  Sign := 1;
               Address := Address + Sign*(rI[I_Index][4]*MIXByteValues +
                                             rI[I_Index][5]);
            end;
            F_Field := DecodeField(F_Modifier);
            if F_Field.Start = 0 then
            begin
               rA[0] := Memory[Address][0];
               for I := 1 to F_Field.Stop do
                  rA[5 - F_Field.Stop + I] := Memory[Address][I];
            end
            else
            begin
               for I := F_Field.Start to F_Field.Stop do
                  rA[5 - F_Field.Stop + I] := Memory[Address][I];
            end;
         end; // LDA
   
   
      
     
      
   else
      writeln('Instruction not implemented yet.');      
   end; // case


   
end; // procedure Execute



end.
