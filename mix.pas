{$mode objfpc}{$R+}{$H+}

unit mix;

interface

uses
   SySUtils;

const
   MIXBase: byte = 64;           { 84 <= MIXBase <= 100. } 
   MIXMemoryCells = 4000;        { Total words of memory. }

type 
   TMIXByte = byte;

   TMIXWord = class
   private
      ByteVal: array[0..5] of TMIXByte; 
   public   
      procedure Clear;
      constructor Create;
      constructor CreateFromBytes(a, b, c, d, e, f: TMIXByte);
      function ToString: string; override;
      function Check: boolean; virtual;
   end;  
   
   TMIXRegister = class(TMIXWord)
   private
      Mnemonic: string;
   public
      constructor Create(Mnem: string);
      function ToString: string; override;
      procedure Load(W: TMIXWord; Start, Stop: integer); 
      function Check: boolean; override;
   end;  


   { index register, jump register, memory system }





implementation

{
   TMIXWord...
}

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

{
   TMIXRegister...
}

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






end.
