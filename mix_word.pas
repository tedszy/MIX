{$mode objfpc}{$R+}{$H+}{$ASSERTIONS+}

{
   The new MIX word objects have more abilities.
} 

unit mix_word;

(**********)

interface

uses
   Math, SysUtils;

const
   MIXBase: byte = 64;           { 64 <= MIXBase <= 100. } 

type   
   TByteWord = array[0..5] of byte;

   TPack = record
      V: int64;
      N: integer;
   end;

   TMIXWord = class
   public
      Sign: byte;
      Data: array[1..5] of byte;
      constructor Create;
      constructor Create(a, b, c, d, e, f: byte); overload;
      constructor Create(BW: TByteWord); overload;
      constructor Create(Ps: array of TPack); overload;
      procedure Clear;
      function GetSign: integer;
      procedure SetSign(V: int64);
      procedure SetBytes(a, b, c, d, e, f: byte);
      procedure SetSignByte(a: byte);
      procedure SetPacked(Ps: array of TPack);
      function GetFieldValue(Start, Stop: integer): int64;
      procedure SetField(V: int64; Start, Stop: integer);
      procedure Negate;
      function ToString: string; override;
      function ToString(Ns: array of integer): string; overload;
      function IsValid: boolean;
   end;

var
   MIXMaxInt: int64;
   MIXMaxIndexInt: int64;
   MIXMaxIntExtended: int64;

function PV(V: int64; N: integer): TPack;

(**********)

implementation

constructor TMIXWord.Create;
var
   I: integer;
begin
   Sign := 0;
   for I := low(Data) to high(Data) do Data[I] := 0;
end;

constructor TMIXWord.Create(a, b, c, d, e, f: byte);
begin
   SetBytes(a, b, c, d, e, f);
end;  

constructor TMIXWord.Create(BW: TByteWord);
var 
   I: integer;
begin
   Sign := BW[0];
   for I := low(Data) to high(Data) do 
      Data[I] := BW[I];
end;

constructor TMIXWord.Create(Ps: array of TPack); 
begin
   SetPacked(Ps);
end;

procedure TMIXWord.Clear;
var
   I: integer;
begin
   Sign := 0;
   for I := low(Data) to high(Data) do Data[I] := 0;
end;

function TMIXWord.GetSign: integer;
begin
   if Sign = 0 then GetSign := 1 else GetSign := -1;
end;

procedure TMIXWord.SetSign(V: int64);
begin
   { Sets the sign byte of word to the sign of V. }
   if V >= 0 then Sign := 0 else Sign := 1; 
end;

procedure TMIXWord.SetBytes(a, b, c, d, e, f: byte);
begin
   Sign := a;
   Data[1] := b;
   Data[2] := c;
   Data[3] := d;
   Data[4] := e;
   Data[5] := f;
end;

procedure TMIXWord.SetSignByte(a: byte);
begin
   assert((a = 0) or (a = 1), 'TMIXWord.SetSignByte: bad sign byte argument.');
   Sign := a;
end;

procedure TMIXWord.SetPacked(Ps: array of TPack);
var
   J, Start, Stop: integer;
begin
   {
      An open array of TPack objects build up the fields of the word.
      Only the first of these TPack objects can be negative. Check this.
   }
   Start := 0;
   for J := low(Ps) to high(Ps) do
   begin
      if J > low(Ps) then
         assert(Ps[J].V >= 0, 
            'TMIXWord.Create: non-initial TPack has negative value.'); 
      Stop := Start + Ps[J].N - 1;
      SetField(Ps[J].V, Start, Stop);
      Start := Stop + 1;
   end;
end;

function TMIXWord.GetFieldValue(Start, Stop: integer): int64;
var 
   ResultSign, I: integer;
   Temp: int64 = 0;
begin
   {
      Cases to consider:
         (1) Start = Stop = 0.
         (2) Start = 0, Stop > 0.
         (3) Start <= Stop > 0 (usual case).
   }
   if (Start = 0) and (Stop = 0) then 
      GetFieldValue := Sign
   else if Start = 0 then 
   begin
      ResultSign := GetSign;
      for I := 1 to Stop do Temp := Temp*MIXBase + Data[I]; 
      GetFieldValue := ResultSign*Temp
   end
   else  
   begin
      for I := Start to Stop do Temp := Temp*MIXBase + Data[I]; 
      GetFieldValue := Temp;
   end;
end;

procedure TMIXWord.SetField(V: int64; Start, Stop: integer);
var
   I: integer;
begin
   {
      A negative V can only be put into a field which starts at 0.

      We do not check if V fits into the specified field.
      If it does not, then the field is filled with least 
      significant bytes of V. 

      Cases: 

      (1) Start = Stop = 0. Only the sign of V is loaded.
      (2) Start = 0, Stop > 0. Consider sign byte seperately, sign is loaded.
      (3) Start <= Stop > 0. The common case. No sign is loaded or changed.
          Cannot load a negative number into this kind of field.
   }
   if (Start = 0) and (Stop = 0) then 
      SetSign(V)
   else if Start = 0 then 
   begin
      SetSign(V);
      V := abs(V);
      for I := Stop downto 1 do
      begin
         Data[I] := V mod MIXBase;   
         V := V div MIXBase;
      end;
   end
   else  
   begin
      assert(V >= 0, 'TMIXWord.SetFieldValue: negative value in non-initial field.'); 
      for I := Stop downto Start do
      begin
         Data[I] := V mod MIXBase;   
         V := V div MIXBase;
      end;
   end;
end;

procedure TMIXWord.Negate;
begin
   if Sign = 0 then Sign := 1 else Sign := 0;
end;

function TMIXWord.ToString: string; 
var 
   I: integer;
begin
   ToString := format('[%0.2d', [Sign]);
   for I := low(Data) to high(Data) do
      if I = high(Data) then
         ToString := ToString + format(' %0.2d]', [Data[I]])
      else 
         ToString := ToString + format(' %0.2d', [Data[I]]);
end;

function TMIXWord.ToString(Ns: array of integer): string; 
var
   J, Start, Stop: integer;
begin
   {
      The elements of Ns must sum to the length of the word: 6.

      To do: check this.
   }
   ToString := '[';
   Start := 0;
   for J := low(Ns) to high(Ns) do
   begin
      Stop := Start + Ns[J] - 1;
      ToString := ToString + format('%d:%d', [GetFieldValue(Start, Stop), Ns[J]]); 
      if J < high(Ns) then ToString := ToString + ' ';
      Start := Stop + 1;
   end;
   ToString := ToString + ']';
end;

function TMIXWord.IsValid: boolean;
var
   I: integer;
begin
   IsValid := true;
   for I := low(Data) to high(Data) do
      IsValid := IsValid and ((Data[I] >= 0) and (Data[I] < MIXBase));
   IsValid := IsValid and ((Sign = 0) or (Sign = 1));
end;

function PV(V: int64; N: integer): TPack;
begin
   {
      We need a short name for this, hence PV rather than PackValue.
   }
   PV.V := V;
   PV.N := N;
end;

(**********)

initialization

   MIXMaxInt := MIXBase**5 - 1;           { Max integer that can fit in register. }
   MIXMaxIndexInt := MIXBase**2 - 1;      { Max integer that fits in index register. }
   MIXMaxIntExtended := MIXBase**10 - 1;  { Max integer that fits in extended rA,rX. }

end.
