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
   
begin
   C_OpCode := Instruction[5];
   F_Modifier := Instruction[4];
   I_Index := Instruction[3];
   Address := GetAddress(Instruction);
   case C_OpCode of


      
      8: begin
            writeln('LDA');
            writeln('C:  ', C_OpCode);
            writeln('F:  ', F_Modifier);
            writeln('I:  ', I_Index);
            writeln('+-AA: ', Address);
            
            
         end;



      
   else
      writeln('Instruction not implemented yet.');      
   end;
end;



end.
