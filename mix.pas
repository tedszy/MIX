{$mode objfpc}{$R+}{$H+}

unit mix;

interface

uses
   SySUtils;

const
   MIXBase: byte = 64;           { 84 <= MIXBase <= 100. } 
   MIXMemoryCells = 4000;        { Total words of memory. }

type 
   TMIXByte = byte;              { Reasonable choice for MIX byte. }
   TMIXOverflowToggle = (ON, OFF);
   TMIXComparisonIndicator = (LESS, EQUAL, GREATER);

   TMIXWord = class
   public   
      ByteVal: array[0..5] of TMIXByte; 
      procedure Clear;
      constructor Create;
      constructor CreateFromBytes(a, b, c, d, e, f: TMIXByte);
      function ToString: string; override;
      function Check: boolean; virtual;
   end;  

   { Register types: main register, index, jump. }
   
   TMIXRegister = class(TMIXWord)
   private
      Mnemonic: string;
   public
      constructor Create(Mnem: string);
      function ToString: string; override;
      procedure Load(W: TMIXWord; Start, Stop: integer); virtual; 
      function Check: boolean; override;
   end;  

   TMIXIndexRegister = class(TMIXRegister)
   public
      procedure Load(W: TMIXWord; Start, Stop: integer); override;
      function Check: boolean; override;
   end;
   
   TMIXJumpRegister = class(TMIXRegister)
   public
      procedure Load(W: TMIXWord; Start, Stop: integer); override;
      function Check: boolean; override;
   end;

   { Memory system. }

   TMIXMemory = class
   private
      Cell: array[0..MIXMemoryCells - 1] of TMIXWord;
   public
      constructor Create;
      procedure Show(Address, Rows: integer);
      procedure Clear;
      destructor Destroy; override;
   end;

   { The MIX machine class. }

   TMIX = class
   private
      Memory: TMIXMemory;
      rA: TMIXRegister;
      rX: TMIXRegister;
      rI: array[1..6] of TMIXIndexRegister;
      rJ: TMIXJumpRegister;
      OT: TMIXOverflowToggle;
      CI: TMIXComparisonIndicator;
   public
      constructor Create;
      // use default arg vals for Show()...
      procedure Show(Address: integer = 0; rows: integer = 5);
      procedure Reboot;
      function Peek(Address: integer): TMIXWord; 
      procedure PokeWord(W: TMIXWord; Address: integer);
      procedure PokeBytes(a, b, c, d, e, f: TMIXByte; Address: integer);
      destructor Destroy; override;
   end;  

implementation

{ TMIXWord... }

procedure TMIXWord.Clear;
var
   I: integer;
begin
   for I := 0 to 5 do
      ByteVal[I] := 0;
end;  

constructor TMIXWord.Create;
begin
   Clear;
end; 

constructor TMIXWord.CreateFromBytes(a,b,c,d,e,f: TMIXByte);
begin
   ByteVal[0] := a;
   ByteVal[1] := b;
   ByteVal[2] := c;
   ByteVal[3] := d;
   ByteVal[4] := e;
   ByteVal[5] := f;
end;  

function TMIXWord.ToString: string;
begin
   ToString := format('[%0.2d %0.2d %0.2d %0.2d %0.2d %0.2d]', 
      [ByteVal[0], ByteVal[1], ByteVal[2], ByteVal[3], ByteVal[4], ByteVal[5]]); 
end;

function TMIXWord.Check: boolean;
var 
   I: integer;
begin
   { Sanity check: all bytes of a word must have values < MIXBase }
   Check := true;
   for I := 0 to 5 do
      Check := Check and (ByteVal[I] < MIXBase);
end;

{ TMIXRegister... }

constructor TMIXRegister.Create(Mnem: string);
begin
   Mnemonic := Mnem;
   Clear;
end;  

function TMIXRegister.Check: boolean;
begin
   { Sanity check: no byte can be >= MIXBase, 
     while for registers, the sign byte (byte 0)
     must be either 0 or 1. }
   Check := (ByteVal[0] = 0) or (ByteVal[0] = 1);
   Check := Check and (inherited Check);
end;

procedure TMIXRegister.Load(W: TMIXWord; Start, Stop: integer);
var
   I: integer;
begin
   Clear;
   if Start = 0 then
   begin
      ByteVal[0] := W.ByteVal[0];
      for I := 1 to Stop do 
         ByteVal[5 - Stop + I] := W.ByteVal[I]
   end
   else
      for I := Start to Stop do 
         ByteVal[5 - Stop + I] := W.ByteVal[I];
end;

function TMIXRegister.ToString: string;
begin
   ToString :=  Mnemonic + ': ' + (inherited ToString);
end;

{ TMIXIndexRegister... } 

procedure TMIXIndexRegister.Load(W: TMIXWord; Start, Stop: integer); 
var
   I: integer;
begin
   { 
      Some checks need to be done for the case of index registers.
      Stop - Start must be <= 3 and if it is 3, then the field must
      contain the sign byte at ByteVal[0].

      Also, a load operation cannot result in bytes 1, 2 or 3 of
      an index register to end up being non-zero. So we will test
      this with assertions.

      The tests of zero bytes in positions 1, 2, 3 will come after
      the load operation is done.
   }
   assert(Stop - Start <= 3, 'Load: Field modifier too wide for index register.');
   if (Stop - Start = 3) then
      assert(Start = 0, 'LoadRegiser: field of length 3 must include sign byte.');

   { Can we replace the next block with (inherited Load(W, Start, Stop)) ? }

   Clear;
   if Start = 0 then
   begin
      ByteVal[0] := W.ByteVal[0];
      for I := 1 to Stop do 
         ByteVal[5 - Stop + I] := W.ByteVal[I]
   end
   else
      for I := Start to Stop do 
         ByteVal[5 - Stop + I] := W.ByteVal[I];

   assert((ByteVal[1] = 0) and 
          (ByteVal[2] = 0) and 
          (ByteVal[3] = 0),
         'LoadRegister: index register bytes 1, 2, 3 must be 0');
end;

function TMIXIndexRegister.Check: boolean; 
begin
   { Same checks apply like TMIXRegister except bytes 1, 2, 3 must be zero. }
   Check := inherited Check;
   Check := Check and ((ByteVal[1] = 0) and
                       (ByteVal[2] = 0) and
                       (ByteVal[3] = 0));
end;

{ TMIXJumpRegister... }

procedure TMIXJumpRegister.Load(W: TMIXWord; Start, Stop: integer);
begin

end;

function TMIXJumpRegister.Check: boolean;
begin
   Check := true;
end;

{ TMIXMemory... }

constructor TMIXMemory.Create;
var
   I: integer;
begin
   for I := 0 to MIXMemoryCells - 1 do
      Cell[I] := TMIXWord.Create;
end;

procedure TMIXMemory.Show(Address, Rows: integer);
var
   I: integer;
begin
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

procedure TMIXMemory.Clear;
var
   I: integer;
begin
   for I := 0 to MIXMemoryCells - 1 do Cell[I].Clear;
end;

destructor TMIXMemory.Destroy;
var
   I: integer;
begin
   for I := 0 to MIXMemoryCells - 1 do Cell[I].Free;
   inherited;
end;

{ TMIX... }

constructor TMIX.Create;
var
   I: integer;
begin
   Memory := TMIXMemory.Create;
   rA := TMIXRegister.Create('rA');
   rX := TMIXRegister.Create('rX');
   for I := 1 to 6 do rI[I] := TMIXIndexRegister.Create('rI' + IntToStr(I));
   rJ := TMIXJumpRegister.Create('rJ');
   OT := OFF;
   CI := EQUAL;
end;

procedure TMIX.Show(Address: integer; Rows: integer);
var 
   RegWidth: integer = 25;
begin
   { Show the internal state in a nice layout. }
   writeln;
   writeln('---------- MIX ----------':50);
   writeln;
   write(rA.ToString:RegWidth);
   write(rX.ToString:RegWidth);
   writeln;
   writeln;
   write(rI[1].ToString:RegWidth);
   write(rI[2].ToString:RegWidth);
   write(rI[3].ToString:RegWidth);
   writeln;
   write(rI[4].ToString:RegWidth);
   write(rI[5].ToString:RegWidth);
   write(rI[6].ToString:RegWidth);
   writeln;
   writeln;
   write(rJ.ToString:RegWidth);
   write('OT: ':10, OT);
   write('CI: ':10, CI);
   writeln;
   writeln;
   Memory.Show(Address, Rows);
   writeln
end;

procedure TMIX.Reboot;
var 
   I: integer;
begin
   rA.Clear;
   rX.Clear;
   for I := 1 to 6 do rI[I].Clear;
   rJ.Clear;
   OT := OFF;
   CI := EQUAL;
   Memory.Clear;
end; 

function TMIX.Peek(Address: integer): TMIXWord; 
var
   I: integer;
begin
   //Peek := Memory.Cell[Address];
   Peek := TMIXWord.Create;
   for I := 0 to 5 do Peek.ByteVal[I] := Memory.Cell[Address].ByteVal[I];
end;
      
procedure TMIX.PokeWord(W: TMIXWord; Address: integer);
var 
   I: integer;
begin
   for I := 0 to 5 do Memory.Cell[Address].ByteVal[I] := W.ByteVal[I];
end;

procedure TMIX.PokeBytes(a, b, c, d, e, f: TMIXByte; Address: integer);
begin
   Memory.Cell[Address].ByteVal[0] := a;
   Memory.Cell[Address].ByteVal[1] := b;
   Memory.Cell[Address].ByteVal[2] := c;
   Memory.Cell[Address].ByteVal[3] := d;
   Memory.Cell[Address].ByteVal[4] := e;
   Memory.Cell[Address].ByteVal[5] := f;
end;

destructor TMIX.Destroy;
var
   I: integer;
begin
   Memory.Free;
   rA.Free;
   rX.Free;
   for I := 1 to 6 do rI[I].Free;
   rJ.Free;
   inherited;
end;




end.
