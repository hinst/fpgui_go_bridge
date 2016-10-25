unit restServerU;

interface

uses
  fphttpserver, fpg_main,
  RestWorkerU, SynchronizerU;

type

  { TRestServer }

  TRestServer = class(TFPHttpServer)
  public
    ClientPort: Integer;
    Worker: TRestWorker;
    procedure HandleRequest(var ARequest: TFPHTTPConnectionRequest;
      var AResponse: TFPHTTPConnectionResponse); override;
  end;

implementation

{ TRestServer }

procedure TRestServer.HandleRequest(var ARequest: TFPHTTPConnectionRequest;
  var AResponse: TFPHTTPConnectionResponse);
begin
  if Worker = nil then
    Worker := TRestWorker.Create;
  Worker.Clear;
  Worker.Request := ARequest;
  Worker.Response := AResponse;
  MainSynchronizer.Sync(Worker);
  if Worker.Quit then
  begin
    MainSynchronizer.Active := False;
    StopServerSocket;
  end;
end;

end.

