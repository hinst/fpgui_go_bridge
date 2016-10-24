program gui_app;

uses SysUtils, restServerU, restThreadU, SynchronizerU, WorkerU, RestWorkerU;

var
  restThread: TRestThread;
  portNumber: Integer;
begin
  portNumber := 8600;
  if ParamCount >= 1 then
    TryStrToInt(ParamStr(1), portNumber);
  restThread := TRestThread.Create(False);
  restThread.Port := portNumber;
  MainSynchronizer := TSynchronizer.Create;
  MainSynchronizer.Run;
  MainSynchronizer.Free;
  restThread.WaitFor;
  restThread.Free;
end.

