{$mode objfpc}{$R+}{$H+}{$ASSERTIONS+}

{
   New, refactored MIX internals.
}

unit mix_new;

(**********)

interface

uses
   mix_word, SysUtils;

const
   MIXMemoryCells = 4000;        { Total words of memory. }

type
   TMIXOverflowToggle = (ON, OFF);
   TMIXComparisonIndicator = (LESS, EQUAL, GREATER);

   TMIX = class
   public
      Cell: array[0..MIXMemoryCells - 1] of TMIXWord;
      rA: TMIXWord;
      rX: TMIXWord;
      rI: array[1..6] of TMIXWord;
      rJ: TMIXWord;
      OT: TMIXOverflowToggle;
      CI: TMIXComparisonIndicator;
      constructor Create;
      destructor Destroy; override;
      procedure Clear;
      procedure Show(Address: integer = 0; Rows: integer = 5);
      procedure Inst_LDA(Address: integer; Index, Modifier: byte);
      procedure Inst_LDX(Address: integer; Index, Modifier: byte);
      procedure Inst_LDAN(Address: integer; Index, Modifier: byte);
      procedure Inst_LDXN(Address: integer; Index, Modifier: byte);
      procedure Inst_LDi(RegI, Address: integer; Index, Modifier: byte); 
      procedure Inst_LDiN(RegI, Address: integer; Index, Modifier: byte); 
      procedure Inst_STA(Address: integer; Index, Modifier: byte);
      procedure Inst_STX(Address: integer; Index, Modifier: byte);
      procedure Inst_STI(RegI, Address: integer; Index, Modifier: byte); 
      procedure Inst_STJ(Address: integer; Index, Modifier: byte);
      procedure Inst_STZ(Address: integer; Index, Modifier: byte);
      procedure Inst_ADD(Address: integer; Index, Modifier: byte);
      procedure Inst_SUB(Address: integer; Index, Modifier: byte);
   end;  

(**********)

implementation

constructor TMIX.Create;
var
   I: integer;
begin
   for I := low(Cell) to high(Cell) do Cell[I] := TMIXWord.Create;
   rA := TMIXWord.Create;
   rX := TMIXWord.Create;
   for I := 1 to 6 do rI[I] := TMIXWord.Create;
   rJ := TMIXWord.Create;
   OT := OFF;
   CI := EQUAL;
end;

destructor TMIX.Destroy;
var
   I: integer;
begin
   For I := low(Cell) to high(Cell) do Cell[I].Free;
   rA.Free;
   rX.Free;
   for I := 1 to 6 do rI[I].Free;
   rJ.Free;
   inherited;
end;

procedure TMIX.Clear;
var
   I: integer;
begin
   for I := low(Cell) to high(Cell) do Cell[I].Clear;
   rA.Clear;
   rX.Clear;
   for I := 1 to 6 do rI[I].Clear;
   rJ.Clear;
   OT := OFF;
   CI := EQUAL;
end;

procedure TMIX.Show(Address, Rows: integer);
var
   Width: integer = 25;
   I: integer;
begin
   writeln('----------------------------------- MIX -----------------------------------');
   write(format('rA: %s', [rA.ToString]):Width);
   write(format('rX: %s', [rX.ToString]):Width);
   writeln;
   write(format('rI1: %s', [rI[1].ToString]):Width);   
   write(format('rI2: %s', [rI[2].ToString]):Width);   
   write(format('rI3: %s', [rI[3].ToString]):Width);   
   writeln;
   write(format('rI4: %s', [rI[4].ToString]):Width);   
   write(format('rI5: %s', [rI[5].ToString]):Width);   
   write(format('rI6: %s', [rI[6].ToString]):Width);   
   writeln;
   write(format('rJ: %s', [rJ.ToString]):Width);   
   writeln;
   write('OT: ':Width, OT);
   write('CI: ':Width, CI);
   writeln;
   for I := 0 to Rows - 1 do
   begin
      write(format('%5d: ', [Address + 4*I]));
      Write(Cell[Address + 4*I].ToString);
      write(' ');
      Write(Cell[Address + 4*I + 1].ToString);
      write(' ');
      Write(Cell[Address + 4*I + 2].ToString);
      write(' ');
      Write(Cell[Address + 4*I + 3].ToString);
      writeln;
   end;
end;

procedure TMIX.Inst_LDA(Address: integer; Index, Modifier: byte);
var
   Start, Stop: integer;
begin
   rA.Clear;
   if Index >= 1 then
      Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   {
      When Start = Stop = 0, then only the sign is loaded as + or -1,
      but this becomes an actual value loaded into rA as the number +1 or -1.
      So we have to be careful here to only load the sign, as Knuth requires.
   }
   if (Start = 0) and (Stop = 0) then
      rA.SetSign(Cell[Address].GetSign)
   else
      rA.SetField(Cell[Address].GetFieldValue(Start, Stop), 0, 5);
end;

procedure TMIX.Inst_LDX(Address: integer; Index, Modifier: byte);
var
   Start, Stop: integer;
begin
   rX.Clear;
   if Index >= 1 then
      Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   {
      See comment above in LDA.
   }
   if (Start = 0) and (Stop = 0) then
      rX.SetSign(Cell[Address].GetSign)
   else
      rX.SetField(Cell[Address].GetFieldValue(Start, Stop), 0, 5);
end;

procedure TMIX.Inst_LDAN(Address: integer; Index, Modifier: byte);
begin
   Inst_LDA(Address, Index, Modifier);
   rA.Negate;
end;

procedure TMIX.Inst_LDXN(Address: integer; Index, Modifier: byte);
begin
   Inst_LDX(Address, Index, Modifier);
   rX.Negate;
end;

procedure TMIX.Inst_LDi(RegI, Address: integer; Index, Modifier: byte); 
var
   Start, Stop: integer;
begin
   rI[RegI].Clear;
   if Index >= 1 then
      Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   {
      See comment above in LDA.
   }
   if (Start = 0) and (Stop = 0) then
      rI[RegI].SetSign(Cell[Address].GetSign)
   else
      rI[RegI].SetField(Cell[Address].GetFieldValue(Start, Stop), 0, 5);
end;

procedure TMIX.Inst_LDiN(RegI, Address: integer; Index, Modifier: byte); 
begin
   Inst_LDi(RegI, Address, Index, Modifier); 
   rI[RegI].Negate;
end;

procedure TMIX.Inst_STA(Address: integer; Index, Modifier: byte);
var
   Start, Stop, NBytes: integer;
   rA_Value: int64;
begin
   if Index >= 1 then Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   { Figure out the number of bytes we will take from right side of rA. } 
   NBytes := Stop - Start + 1;
   { 
      What happens if rA is -0 and all of it is stored into a cell?
      There is a loss of sign information when bytes are converted into 
      the value 0. So this case should be handled (and tested) seperately. 
   
      If rA_Value = 0 and field is (0:5) then we must consider 
      the sign byte of rA.
   }
   rA_Value := rA.GetFieldValue(high(rA.Data) - NBytes + 1, high(rA.Data));
   if (rA_Value = 0) and (Start = 0) and (Stop = high(rA.Data)) then
   begin
      Cell[Address].Clear;
      Cell[Address].SetSignByte(rA.Sign);
   end
   else
      Cell[Address].SetField(rA_Value, Start, Stop);
   {
      We are also making an assumption that Knuth may or may not intend.

      When the field is, say (0:1) or (0:2), then we are storing
      the low bytes of rA which does not include the sign byte.
      The value we are storing into (0:1) or (0:2) will thus be always
      positive and will set the sign byte of the Cell to +.

      However when the field is the full (0:5), then the value extracted
      from rA to be stored in (0:5) of the cell can be either + or -.
   }
end;

procedure TMIX.Inst_STX(Address: integer; Index, Modifier: byte);
var
   Start, Stop, NBytes: integer;
   rX_Value: int64;
begin
   if Index >= 1 then Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   { Figure out the number of bytes we will take from right side of rA. } 
   NBytes := Stop - Start + 1;
   { 
      STA comments above apply here.
   }
   rX_Value := rX.GetFieldValue(high(rX.Data) - NBytes + 1, high(rX.Data));
   if (rX_Value = 0) and (Start = 0) and (Stop = high(rX.Data)) then
   begin
      Cell[Address].Clear;
      Cell[Address].SetSignByte(rX.Sign);
   end
   else
      Cell[Address].SetField(rX_Value, Start, Stop);
end;

procedure TMIX.Inst_STI(RegI, Address: integer; Index, Modifier: byte); 
var
   Start, Stop, NBytes, data_hi: integer;
   rI_Value: int64;
begin
   data_hi := high(rI[RegI].Data);
   if Index >= 1 then Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   { Figure out the number of bytes we will take from right side of rA. } 
   NBytes := Stop - Start + 1;
   { 
      STA comments above apply here.
   }
   rI_Value := rI[RegI].GetFieldValue(data_hi - NBytes + 1, data_hi);
   if (rI_Value = 0) and (Start = 0) and (Stop = data_hi) then
   begin
      Cell[Address].Clear;
      Cell[Address].SetSignByte(rI[RegI].Sign);
   end
   else
      Cell[Address].SetField(rI_Value, Start, Stop);
end;

procedure TMIX.Inst_STJ(Address: integer; Index, Modifier: byte);
var
   Start, Stop, NBytes, data_hi: integer;
   rJ_Value: int64;
begin
   data_hi := high(rJ.Data);
   if Index >= 1 then Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   NBytes := Stop - Start + 1;
   { 
      STA comments above apply here.
   }
   rJ_Value := rJ.GetFieldValue(data_hi - NBytes + 1, data_hi);
   if (rJ_Value = 0) and (Start = 0) and (Stop = data_hi) then
   begin
      Cell[Address].Clear;
      Cell[Address].SetSignByte(rJ.Sign);
   end
   else
      Cell[Address].SetField(rJ_Value, Start, Stop);
end;

procedure TMIX.Inst_STZ(Address: integer; Index, Modifier: byte);
begin
   rA.Clear;
   Inst_STA(Address, Index, Modifier);
end;

procedure TMIX.Inst_ADD(Address: integer; Index, Modifier: byte);
var
   Start, Stop: integer;
   V, ResultSum: int64;
   rA_SignByte: byte;
begin
   if Index >= 1 then Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   { 
      Rule out the case of Start = Stop = 0. 
      It makes no sense to add only the sign.
   }
   assert(not ((Start = 0) and (Stop = 0)), 'TMIX.Inst_ADD: unreasonable field (0:0).');
   V := Cell[Address].GetFieldValue(Start, Stop);
   ResultSum := rA.GetFieldValue(0, 5) + V;
   if abs(ResultSum) > MIXMaxInt then 
   begin
      OT := ON;
      rA.SetPacked([PV(ResultSum, 6)]);
   end
   else if ResultSum = 0 then
   begin 
      rA_SignByte := rA.Sign;
      rA.Clear;
      rA.SetSignByte(rA_SignByte);
   end
   else 
      rA.SetPacked([PV(ResultSum, 6)]);
end;

procedure TMIX.Inst_SUB(Address: integer; Index, Modifier: byte);
var
   Start, Stop: integer;
   V, ResultSum: int64;
   rA_SignByte: byte;
begin
   {
      It's too bad we have to duplicate all this code just to change V -> -V.
   }
   if Index >= 1 then Address := Address + rI[Index].GetFieldValue(0, 5); 
   Start := Modifier div 8;
   Stop := Modifier mod 8;
   assert(not ((Start = 0) and (Stop = 0)), 'TMIX.Inst_ADD: unreasonable field (0:0).');
   V := Cell[Address].GetFieldValue(Start, Stop);
   ResultSum := rA.GetFieldValue(0, 5) - V;
   if abs(ResultSum) > MIXMaxInt then 
   begin
      OT := ON;
      rA.SetPacked([PV(ResultSum, 6)]);
   end
   else if ResultSum = 0 then
   begin 
      rA_SignByte := rA.Sign;
      rA.Clear;
      rA.SetSignByte(rA_SignByte);
   end
   else 
      rA.SetPacked([PV(ResultSum, 6)]);
end;



end.

