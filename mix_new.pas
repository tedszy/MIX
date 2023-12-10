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
   Temp: string;
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










end.

