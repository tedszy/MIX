{$mode objfpc}{$R+}{$H+}

{
   Very simple testing framework, to test behavior 
   of machine instructions.
}

unit testing;

interface

uses
   mix;

var
   Passed: integer = 0;
   Failed: integer = 0;

function RecordTestResult(Res: boolean): boolean;
function EqualWords(W1, W2: TMIXWord): boolean;
procedure ReportTests;

implementation

function RecordTestResult(Res: boolean): boolean;
begin
   if Res then
      Passed := Passed + 1
   else
      Failed := Failed + 1;
   RecordTestResult := Res;
end;

function EqualWords(W1, W2: TMIXWord): boolean;
var
   I: Integer;
begin
   EqualWords := true;
   for I := 0 to 5 do
      EqualWords := EqualWords and (W1.ByteVal[I]=W2.ByteVal[I]);
end;

procedure ReportTests;
begin
   writeln('----------');
   writeln('Passed: ', Passed);
   writeln('Failed: ', Failed);
end;




end.
