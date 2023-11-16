{$mode objfpc}{$R+}{$H+}

unit mix_show;

interface

uses
   mix_machine, SysUtils;

procedure ShowMIXCharTable;
procedure ShowMIXSizes;
function FormatWord(W: MIXWord): string;
procedure WriteWord(W: MIXWord);
procedure WriteRegister(RegLabel: string; Reg: MIXRegister);
function FormatRegister(RegLabel: string; Reg: MIXRegister): string;
procedure WriteMemoryCell(Address: integer);
function FormatMemoryCell(Address: integer): string;
procedure ShowMIXState;
procedure ShowMIXMemory(StartAddress: integer; Rows: integer);

implementation

procedure ShowMIXCharTable;
var
   I: integer;
begin
   write(format('%-16s', ['MIX char table']));
   for I := low(MIXCharTable) to high(MIXCharTable) do
   begin
      write(I,':',MIXCharTable[I],' ');
      if ((I mod 12) = 0) and (I > 0) then
      begin
         writeln;
         write(' ':16)
      end;         
   end;
   writeln;
end;

procedure ShowMIXSizes;
var
   Width: integer = 25;
   procedure print_info(n:integer; s:string);
   begin
      writeln(s, n:(Width-length(s)));
   end;
begin
   writeln('MIX component', 'size':(width-13));
   print_info(sizeof(MIXByte), 'MIX byte:');
   print_info(MIXBase, 'MIX byte base:');
   print_info(sizeof(MIXWord), 'MIX_word:');
   print_info(sizeof(MIXRegister), 'MIX register:');
   print_info(sizeof(MIXMemory), 'MIX memory:');
   print_info(MIXMemoryWords, 'MIX memory words:');
   print_info(sizeof(MIXOverflow), 'MIX overflow:');
   print_info(sizeof(MIXComparison), 'MIX comparison:');
   print_info(sizeof(MIXUnit), 'MIX peripheral unit:');
end;

procedure WriteWord(W: MIXWord);
begin
   write(format('[%0.2d %0.2d %0.2d %0.2d %0.2d %0.2d]',
      [W[0],W[1],W[2],W[3],W[4],W[5]])); 
end;

function FormatWord(W: MIXWord): string;
begin
   FormatWord := format('[%0.2d %0.2d %0.2d %0.2d %0.2d %0.2d]',
      [W[0],W[1],W[2],W[3],W[4],W[5]]); 
end;


procedure WriteRegister(RegLabel: string; Reg: MIXRegister);
begin
   write(format('%5s: ', [RegLabel]));
   WriteWord(Reg);
end;

function FormatRegister(RegLabel: string; Reg: MIXRegister): string;
begin
   FormatRegister := format('%5s: ', [RegLabel]) + formatWord(Reg);
end;  


procedure WriteMemoryCell(Address: integer);
begin
   write(format('%5d: ', [Address]));
   WriteWord(Memory[Address]);
end;

function FormatMemoryCell(Address: integer): string;
begin
   FormatMemoryCell := format('%5d: ', [Address]) + 
      formatWord(Memory[Address]);
end;  






procedure ShowMIXState;
var
   I: integer;
   TempString: string;
begin
   write(format('%5s: ', ['rA']));
   WriteWord(rA);
   writeln;
   
   write(format('%5s: ', ['rX']));
   WriteWord(rX);
   writeln;



   for I := 1 to 6 do
   begin
      TempString := format('rI%d', [I]);
      write(format('%5s: ', [TempString]));
      WriteWord(rI[I]);
      writeln;
      
   end;

   
   write(format('%5s: ', ['rJ']));
   WriteWord(rJ);
   writeln;
   
   writestr(TempString, OI);
   writeln(format('%5s: %s', ['OI', TempString]));
   writestr(TempString, CI);
   writeln(format('%5s: %s', ['CI', TempString]));
end;

procedure ShowMIXMemory(StartAddress: integer; Rows: integer);
var
   I: integer;
begin
   for I := 0 to Rows - 1 do
   begin
      write(format('%5d: ', [StartAddress + 4*I]));
      WriteWord(Memory[StartAddress + 4*I]);
      write(' ');
      WriteWord(Memory[StartAddress + 4*I + 1]);
      write(' ');
      WriteWord(Memory[StartAddress + 4*I + 2]);
      write(' ');
      WriteWord(Memory[StartAddress + 4*I + 3]);
      writeln;
   end;
end;

end.
