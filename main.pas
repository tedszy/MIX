{$mode objfpc}{$R+}{$H+}

program main;

uses
   mix_machine, mix_show, mix_exec, SysUtils; 

var
   MyInstruction: MIXWord;
   MyField: Field;
   
begin
   
   ShowMIXSizes;
   ShowMIXCharTable;
   InitMix;

   Poke(0, MakeMIXWord(11,22,33,44,55,13));

   ShowMIXState;
   ShowMIXMemory(0,10);

   // Tests.

   MyInstruction := MakeMIXWord(0, 2000 div 64, 2000 mod 64, 2, 3, 8);
   Execute(MyInstruction);
   
   writeln;

   MyInstruction := MakeMIXWord(1, 2000 div 64, 2000 mod 64, 4, 5, 8);
   Execute(MyInstruction);

   writeln;   

   MyInstruction := MakeMIXWord(0, 0, 0, 0, 0, 7);
   Execute(MyInstruction);

   MyField.Start := 0;
   MyField.Stop := 3;
   writeln('encode (0,3) => ', EncodeField(MyField));

   MyField := DecodeField(11);
   writeln(format('decode %d => (%d,%d)', [11, MyField.Start, MyField.Stop]));

   MyField.Start := 0;
   MyField.Stop := 5;
   writeln('encode (0,5) => ', EncodeField(MyField));

   
end.

