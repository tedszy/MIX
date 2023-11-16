{$mode objfpc}{$R+}{$H+}

program test_setup;

uses
   mix_machine, mix_show, mix_exec, SysUtils; 

begin
   
   ShowMIXSizes;
   ShowMIXCharTable;
   InitMix;
   ShowMIXState;
   ShowMIXMemory(0, 5);
   
end.

