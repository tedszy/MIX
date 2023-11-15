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
   ShowMIXState;
   ShowMIXMemory(0,10);

   // Tests.

   MyField.Start := 0;
   MyField.Stop := 3;
   writeln('encode (0,3) => ', EncodeField(MyField));

   MyField := DecodeField(11);
   writeln(format('decode %d => (%d,%d)', [11, MyField.Start, MyField.Stop]));

   MyField.Start := 0;
   MyField.Stop := 5;
   writeln('encode (0,5) => ', EncodeField(MyField));

   // Test LDA -------------

   InitMix;
   Poke(2000, MakeMIXWord(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4));
   MyField.Start := 0;
   MyField.Stop := 4;
   MyInstruction := MakeInstruction(8, 2000, 0, EncodeField(MyField)); 
   Execute(MyInstruction);

   ShowMIXState;
   ShowMIXMemory(2000, 5);




   
end.

