{$mode objfpc}{$R+}{$H+}

unit mix_exec;

interface

uses
   mix_machine;

procedure Execute(Instruction: MIXWord);

implementation



procedure Execute(Instruction: MIXWord);
begin
   case Instruction[5] of

      8: writeln('LDA');

   else
      writeln('Instruction not implemented yet.');      
   end;
end;



end.
