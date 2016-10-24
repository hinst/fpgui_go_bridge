program gui_app;

uses restServerU, restThreadU, SynchronizerU, WorkerU, RestWorkerU;

var
  restThread: TRestThread;
begin
  restThread := TRestThread.Create(False);
  MainSynchronizer := TSynchronizer.Create;
  MainSynchronizer.Run;
  MainSynchronizer.Free;
  restThread.WaitFor;
  restThread.Free;
end.

