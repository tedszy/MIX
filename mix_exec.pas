{$mode objfpc}{$R+}{$H+}

unit mix_exec;

interface

uses
   mix_machine;

procedure Poke(Address: integer; W: MIXWord);

implementation

// Make this more powerful, with field specifier.
procedure Poke(Address: integer; W: MIXWord);
var
   I: integer;
begin
   for I := 0 to 5 do
      Memory[Address][I] := W[I];
end;


end.
