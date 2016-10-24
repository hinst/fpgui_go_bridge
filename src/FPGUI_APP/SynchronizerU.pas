unit SynchronizerU;

interface

uses
  Classes, SysUtils, contnrs, SyncObjs,
  WorkerU;

type

  { TSynchronizer }

  TSynchronizer = class
  protected
    QueueLocker: TCriticalSection;
    Queue: TObjectQueue;
  public
    Active: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Sync(a: TWorker);
    procedure Run;
  end;

var
  MainSynchronizer: TSynchronizer;

implementation

{ TSynchronizer }

constructor TSynchronizer.Create;
begin
  inherited Create;
  Active := True;
  QueueLocker := TCriticalSection.Create;
  Queue := TObjectQueue.Create;
end;

destructor TSynchronizer.Destroy;
begin
  QueueLocker.Free;
  Queue.Free;
  inherited Destroy;
end;

procedure TSynchronizer.Sync(a: TWorker);
begin
  QueueLocker.Enter;
  Queue.Push(a);
  QueueLocker.Leave;
  a.Event.WaitFor(INFINITE);
end;

procedure TSynchronizer.Run;
var
  worker: TWorker;
begin
  while Active do
  begin
    QueueLocker.Enter;
    if Queue.Count > 0 then
      worker := TWorker(Queue.Pop)
    else
      worker := nil;
    QueueLocker.Leave;;
    if worker <> nil then
    begin
      worker.Run;
      worker.Event.SetEvent;
    end
    else
      Sleep(10);
  end;
end;

end.

