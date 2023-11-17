{$mode objfpc}{$R+}{$H+}{$ASSERTIONS ON}

unit mix_exec;

interface

uses
   mix_machine, mix_show;

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

  [  +-  A1  A2  I   F   C  ] 

  Mnemonics layout:

  OP ADDRESS,I(F)

  C  (+- A1 A2)  I  F

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
   Address := Instruction[1]*MIXBase + Instruction[2];
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

{
   Generalized load register, handles all cases,
   including index registers, negation.

   Address M, start, stop, negated, RegisterType, var register.
}   

procedure LoadRegister(Address: integer; 
   F_Modifier: MIXByte;
   Index: MIXByte;
   Negated: boolean; 
   RegType: RegisterType; 
   var LoadReg: MIXRegister);
var
   F_Field: Field;
   I, Sign: integer;
begin
   F_Field := DecodeField(F_Modifier);

   { 
      Some checks need to be done for the case of INDEX_REG type.
      Stop - Start must be <= 3 and if it is 3, then the field 
      it must contain the sign byte.

      Also, a load operation cannot result in bytes 1, 2 or 3 of
      an index register to end up being non-zero. So we will test
      these with assertions.

      The tests of zero bytes in positions 1, 2, 3 will come after
      the load operations are done.
   }

   if RegType = INDEX_REG then 
      assert(F_Field.Stop - F_Field.Start <= 3, 
         'LoadRegister: Field modifier too wide for index register.');

   if (RegType = INDEX_REG) and (F_Field.Stop - F_Field.Start = 3) then
      assert(F_Field.Start = 0, 
         'LoadRegiser: field of length 3 must include sign byte.');

   { Add contents of index register to Address.
   Remember that index register has a sign. }
   if Index > 0 then
   begin
      if rI[Index][0] = 1 then
         Sign := -1
      else
         Sign := 1;
      Address := Address + Sign*(rI[Index][4]*MIXBase + rI[Index][5]);
   end;

   if F_Field.Start = 0 then
   begin
      LoadReg[0] := Memory[Address][0];
      for I := 1 to F_Field.Stop do 
         LoadReg[5 - F_Field.Stop + I] := Memory[Address][I]
   end
   else
      for I := F_Field.Start to F_Field.Stop do 
         LoadReg[5 - F_Field.Stop + I] := Memory[Address][I];

   { If index register, make sure bytes 1, 2, 3 are undisturbed. }

   if RegType = INDEX_REG then 
      assert((LoadReg[1] = 0) and 
         (LoadReg[2] = 0) and (LoadReg[3] = 0),
         'LoadRegister: index register bytes 1, 2, 3 must be 0');
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

   { LDA }
   8: 
   begin
      ZeroRegister(rA);
      LoadRegister(Address, F_Modifier, I_Index, False, WIDE_REG, rA);
   end;  

   { LDX }
   15:
   begin
      ZeroRegister(rX);
      LoadRegister(Address, F_Modifier, I_Index, False, WIDE_REG, rX);
   end;

   { LDi load index registers}
   (8+1)..(8+6):
   begin 
      ZeroRegister(rI[C_OpCode - 8]);
      LoadRegister(Address, F_Modifier, I_Index, False, INDEX_REG, rI[C_OpCode - 8]);
   end;


   else
      writeln('Instruction not implemented yet.');      
   end; 



end;

end.
