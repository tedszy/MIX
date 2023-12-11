{$mode objfpc}{$R+}{$H+}

{
   Very simple testing framework, to test behavior 
   of machine instructions.
}

unit testing_new;

interface

uses
   mix_word, SysUtils;

var
   Passed: integer = 0;
   Failed: integer = 0;
   Width: integer = 25;

procedure MakeTitle(Name: string; N: integer);
procedure DisplayWord(Name: string; W: TMIXWord);
procedure DisplaylnWord(Name: string; W: TMIXWord);
procedure RecordTestResult(Res: boolean);
function EqualWords(W1, W2: TMIXWord): boolean;
procedure ReportTests;

implementation

procedure MakeTitle(Name: string; N: integer);
begin
   writeln(format('test: %s %d ...', [Name, N]));
end;

procedure DisplayWord(Name: string; W: TMIXWord);
begin
   write(format('%s => ', [Name]):Width, W.ToString);
end;

procedure DisplaylnWord(Name: string; W: TMIXWord);
begin
   writeln(format('%s => ', [Name]):Width, W.ToString);
end;

procedure RecordTestResult(Res: boolean);
begin
   if Res then
      Passed := Passed + 1
   else
      Failed := Failed + 1;
   writeln(' ==> ', Res);
   writeln;
end;

function EqualWords(W1, W2: TMIXWord): boolean;
var
   I: Integer;
begin
   EqualWords := true;
   for I := 1 to 5 do
      EqualWords := EqualWords and (W1.Data[I]=W2.Data[I]);
   EqualWords := EqualWords and (W1.Sign = W2.Sign);
end;

procedure ReportTests;
begin
   writeln('----------');
   writeln('Passed: ', Passed);
   writeln('Failed: ', Failed);
end;




end.
