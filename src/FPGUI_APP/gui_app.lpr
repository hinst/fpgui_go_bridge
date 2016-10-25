program gui_app;

uses SysUtils, restServerU, restThreadU, SynchronizerU, WorkerU, RestWorkerU;

var
  restThread: TRestThread;
begin
  restThread := TRestThread.Create(False);
  if ParamCount >= 1 then
    TryStrToInt(ParamStr(1), restThread.Port);
  if ParamCount >= 2 then
    TryStrToInt(ParamStr(2), restThread.ClientPort);
  MainSynchronizer := TSynchronizer.Create;
  MainSynchronizer.Run;
  MainSynchronizer.Free;
  restThread.WaitFor;
  restThread.Free;
end.

