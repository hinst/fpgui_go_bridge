program gui_app;

uses SysUtils, restServerU, restThreadU, SynchronizerU, WorkerU, RestWorkerU,
  LogU;

var
  restThread: TRestThread;
begin
  WriteLog('STARTING...');
  MainSynchronizer := TSynchronizer.Create;
  restThread := TRestThread.Create(False);
  if ParamCount >= 1 then
    TryStrToInt(ParamStr(1), restThread.ClientPort);
  WriteLog('Client port is ' + IntToStr(restThread.ClientPort));
  MainSynchronizer.Run;
  MainSynchronizer.Free;
  restThread.WaitFor;
  restThread.Free;
end.

