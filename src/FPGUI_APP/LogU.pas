unit LogU;

interface

uses
  Classes, SysUtils;

procedure WriteLog(s: string);

implementation

var
  GlobalLog: TFileStream;
  GlobalLogFilePath: string;

procedure WriteLog(s: string);
begin
  s := FormatDateTime('yyyy-mm-dd_hh:nn:ss.zzz', Now) + ': ' + s + LineEnding;
  GlobalLog.Write(s[1], Length(s));
end;

initialization
  GlobalLogFilePath := 'gui_app.txt';
  GlobalLog := TFileStream.Create(GlobalLogFilePath, fmCreate);
  GlobalLog.Free;
  GlobalLog := TFileStream.Create(GlobalLogFilePath, fmOpenWrite or fmShareDenyNone);
finalization
  GlobalLog.Free;
end.

