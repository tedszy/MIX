{$mode objfpc}{$R+}{$H+}

unit mix_word;

interface

uses
   SySUtils;

const

   { 84 <= MIXBase <= 100. } 

   MIXBase: byte = 64;

type 
   TMIXByte = byte;

   { A MIX field can be more efficiently and easily represented 
     by a simple static array and a size. The field bytes are stored
     in array elements 0 thru size-1. }

   TMIXField = record
      size: integer;
      ByteVal: array[0..5] of TMIXByte;
   end;


   TMIXWord = class
   private
      ByteVal: array[0..5] of TMIXByte; 
   public   
      procedure Clear;
      constructor Create;
      constructor CreateFromBytes(a,b,c,d,e,f: TMIXByte);
      function GetField(Start, Stop: integer): TMIXField;
      procedure SetField(Start: integer; F: TMIXField);
      




      { To do. }

      // procedure LoadLeft(F: TMIXField);
      // procedure LoadRight(F: TMIXField);





      function ToString: string; override;
      function Check: boolean; virtual;
   end;  
   
   TMIXRegister = class(TMIXWord)
   private
      Mnemonic: string;
   public
      constructor Create(Mnem: string);
      function ToString: string; override;
      function Check: boolean; override;
   end;  


   { index register, jump register, memory system }





function FormatField(F: TMIXField): string;

implementation

function FormatField(F: TMIXField): string;
begin
   FormatField := format('%d: (%0.2d %0.2d %0.2d %0.2d %0.2d %0.2d)', 
      [F.Size, F.ByteVal[0], F.ByteVal[1], F.ByteVal[2], F.ByteVal[3], 
       F.ByteVal[4], F.ByteVal[5]]); 
end;

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

function TMIXWord.GetField(Start, Stop: integer): TMIXField;
var 
   I: integer;
begin
   GetField.size := Stop - Start + 1;
   for I := Start to Stop do
      GetField.ByteVal[I - Start] := ByteVal[I];
end;

procedure TMIXWord.SetField(Start: integer; F: TMIXField);
var
   I: integer;
begin
   { Put the bytes of F into the Register, starting at position Start. 
     This is a general purpose way of setting some field IN THE REGISTER
     with some bytes of a given field record. LoadLeft and LoadRight
     are more specific operations of this sort. }
   assert(start + F.size <= 5, 'SetField: given F is too wide.');
   for I := Start to Start + F.size - 1 do
      ByteVal[I] := F.ByteVal[I - Start];
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

function TMIXRegister.ToString: string;
begin
   ToString :=  Mnemonic + ': ' + (inherited ToString);
end;


end.
