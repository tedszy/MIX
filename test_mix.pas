{$mode objfpc}{$R+}{$H+}

program oop_test;

uses
   mix;

var
   MyWord2: TMIXWord;
   I: integer;
   Goo: TMIXRegister;
   Knuth: TMIX;

   MyWord: TMIXWord;
   Instruction: TMIXInstruction;
   Mem: integer = 2000;

begin

   MyWord := TMIXWord.CreateFromBytes(0, Mem div MIXBase, Mem mod MIXBase, 0, 5, 8);
   writeln(MyWord.ToString);
   Instruction := TMIXInstruction.Create(MyWord);
   
   {
      we need a TMIXInstruction.ToString function.
   }

   Knuth := TMIX.Create;
   Knuth.PokeBytes(1, 80 div MIXBase, 80 mod MIXBase, 3, 5, 4, Mem);
   Knuth.rA.Load(Myword, 0, 5);
   Knuth.execute(Instruction);
   writeln(Instruction.ToString); 



//   Knuth.show(Mem);





   {
   MyWord := TMIXWord.Create;
   MyWord2 := TMIXWord.CreateFromBytes(1,2,3,4,5,6);
   Goo := TMIXRegister.Create('rA');


   writeln(MyWord.ToString);
   writeln(MyWord2.ToString);
   writeln(Goo.ToString);
   writeln;

   Goo.Load(MyWord2, 1, 3);
   writeln(Goo.ToString);
   writeln;

   Goo.Load(MyWord2, 0, 5);
   writeln(Goo.ToString);
   writeln;


   Goo.Load(MyWord2, 0, 0);
   writeln(Goo.ToString);
   writeln;


   Knuth := TMIX.Create;

   writeln('test peek, poke');
   Knuth.PokeBytes(6,5,4,3,2,1, 3);
   Knuth.PokeWord(MyWord2, 2);
   writeln((Knuth.Peek(2)).ToString);

   Knuth.Show;

   Knuth.Reboot;

   Knuth.show;

   }




   MyWord.Free;
   MyWord2.Free;
   Goo.Free;
   Knuth.Free;
end.


