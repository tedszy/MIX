{$mode objfpc}{$R+}{$H+}{$ASSERTIONS ON}

(*

  Test our machine instructions using
  the examples from Knuth's book.

*)

program test_instructions;

uses
   mix_machine, mix_show, mix_exec, SysUtils, StrUtils; 

var
   WW: array[1..4] of integer = (15, 25, 30, 28);
   WW_sum: integer = 15+25+30+28;

procedure Test_header;
begin
   writeln('Test':WW[1], 'Instruction':WW[2], 'Memory':WW[3], 'register contents':WW[4]);
   writeln(DupeString('-', WW_sum));
end;

procedure LDA_test(TestName: string; Start: byte; Stop: byte);
var
   MyInstruction: MIXWord;
   MyField: Field;
begin
   InitMIX;
   Poke(2000, MakeMIXWord(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4));
   MyField.Start := Start;
   MyField.Stop := Stop;
   MyInstruction := MakeInstruction(8, 2000, 0, EncodeField(MyField)); 
   Execute(MyInstruction);
   write(TestName:WW[1]);
   write(FormatWord(MyInstruction):WW[2]);
   write(FormatMemoryCell(2000):WW[3]);
   write(FormatRegister('rA', rA):WW[4]);
   writeln;
end;  

procedure LDAN_test(TestName: string; Start: byte; Stop: byte);
var
   MyInstruction: MIXWord;
   MyField: Field;
begin
   InitMIX;
   Poke(2000, MakeMIXWord(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4));
   MyField.Start := Start;
   MyField.Stop := Stop;
   MyInstruction := MakeInstruction(16, 2000, 0, EncodeField(MyField)); 
   Execute(MyInstruction);
   write(TestName:WW[1]);
   write(FormatWord(MyInstruction):WW[2]);
   write(FormatMemoryCell(2000):WW[3]);
   write(FormatRegister('rA', rA):WW[4]);
   writeln;
end;  

procedure LDX_test(TestName: string; Start: byte; Stop: byte);
var
   MyInstruction: MIXWord;
   MyField: Field;
begin
   InitMIX;
   Poke(2000, MakeMIXWord(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4));
   MyField.Start := Start;
   MyField.Stop := Stop;
   MyInstruction := MakeInstruction(15, 2000, 0, EncodeField(MyField)); 
   Execute(MyInstruction);
   write(TestName:WW[1]);
   write(FormatWord(MyInstruction):WW[2]);
   write(FormatMemoryCell(2000):WW[3]);
   write(FormatRegister('rX', rX):WW[4]);
   writeln;
end;  

procedure LDXN_test(TestName: string; Start: byte; Stop: byte);
var
   MyInstruction: MIXWord;
   MyField: Field;
begin
   InitMIX;
   Poke(2000, MakeMIXWord(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4));
   MyField.Start := Start;
   MyField.Stop := Stop;
   MyInstruction := MakeInstruction(23, 2000, 0, EncodeField(MyField)); 
   Execute(MyInstruction);
   write(TestName:WW[1]);
   write(FormatWord(MyInstruction):WW[2]);
   write(FormatMemoryCell(2000):WW[3]);
   write(FormatRegister('rX', rX):WW[4]);
   writeln;
end;  

procedure LDi_test(TestName: string; Start: byte; Stop: byte);
var
   MyInstruction: MIXWord;
   MyField: Field;
begin
   InitMIX;
   Poke(2000, MakeMIXWord(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4));
   MyField.Start := Start;
   MyField.Stop := Stop;
   MyInstruction := MakeInstruction(8 + 3, 2000, 0, EncodeField(MyField)); 
   Execute(MyInstruction);
   write(TestName:WW[1]);
   write(FormatWord(MyInstruction):WW[2]);
   write(FormatMemoryCell(2000):WW[3]);
   write(FormatRegister('rI3', rI[3]):WW[4]);
   writeln;
end;  

procedure LDiN_test(TestName: string; Start: byte; Stop: byte);
var
   MyInstruction: MIXWord;
   MyField: Field;
begin
   InitMIX;
   Poke(2000, MakeMIXWord(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4));
   MyField.Start := Start;
   MyField.Stop := Stop;
   MyInstruction := MakeInstruction(16 + 3, 2000, 0, EncodeField(MyField)); 
   Execute(MyInstruction);
   write(TestName:WW[1]);
   write(FormatWord(MyInstruction):WW[2]);
   write(FormatMemoryCell(2000):WW[3]);
   write(FormatRegister('rI3', rI[3]):WW[4]);
   writeln;
end;  




begin
   Test_header;
   LDA_test('LDA 1', 0, 5);
   LDA_test('LDA 2', 1, 5);
   LDA_test('LDA 3', 0, 3);
   LDA_test('LDA 4', 0, 0);
   LDA_test('LDA 5', 1, 1);

   writeln;   

   LDX_test('LDX 1', 0, 5);
   LDX_test('LDX 2', 1, 5);
   LDX_test('LDX 3', 0, 3);
   LDX_test('LDX 4', 0, 0);
   LDX_test('LDX 5', 1, 1);

   writeln;

   LDi_test('LD3 1', 0, 2);
   LDi_test('LD3 2', 4, 5);
   LDi_test('LD3 3', 0, 0);
   LDi_test('LD3 4', 1, 2);
   LDi_test('LD3 5', 0, 1);

   writeln;

   LDAN_test('LDAN 1', 0, 5);
   LDAN_test('LDAN 2', 1, 5);

   writeln;

   LDXN_test('LDXN 1', 0, 5);
   LDXN_test('LDXN 2', 1, 5);

   writeln;

   LDiN_test('LD3N 1', 0, 2);
   LDiN_test('LD3N 2', 4, 5);
   LDiN_test('LD3N 3', 0, 0);
   LDiN_test('LD3N 4', 1, 2);
   LDiN_test('LD3N 5', 0, 1);


   ShowMIXState;
   ShowMIXMemory(2000,2);
end.




