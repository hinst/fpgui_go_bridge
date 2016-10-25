unit restServerU;

interface

uses
  SysUtils,
  fphttpserver, fphttpclient,
  fpg_main,
  RestWorkerU, SynchronizerU, LogU;

type

  { TRestServer }

  TRestServer = class(TFPHttpServer)
  protected
    FClient: TFPHttpClient;
    function GetClient: TFPHttpClient;
    function GetClientURL: string;
  public
    ClientPort: Integer;
    Worker: TRestWorker;
    destructor Destroy; override;
    procedure HandleRequest(var ARequest: TFPHTTPConnectionRequest;
      var AResponse: TFPHTTPConnectionResponse); override;
    procedure SendLog(s: string);
    property Client: TFPHttpClient read GetClient;
    property ClientURL: string read GetClientURL;
  end;

implementation

{ TRestServer }

function TRestServer.GetClientURL: string;
begin
  result := 'http://localhost:' + IntToStr(ClientPort);
end;

function TRestServer.GetClient: TFPHttpClient;
begin
  if FClient = nil then
  begin
    FClient := TFPHttpClient.Create(nil);
  end;
  result := FClient;
end;

destructor TRestServer.Destroy;
begin
  FClient.Free;
  FClient := nil;
  inherited Destroy;
end;

procedure TRestServer.HandleRequest(var ARequest: TFPHTTPConnectionRequest;
  var AResponse: TFPHTTPConnectionResponse);
begin
  WriteLog(ARequest.URL);
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

procedure TRestServer.SendLog(s: string);
var
  url: string;
begin
  s := FormatDateTime('yyyy-mm-dd_hh:nn:ss.zzz', Now) + ' ' + IntToStr(GetCurrentThreadId) + ': ' + s;
  url := ClientURL + '/log?text=' + EncodeURLElement(s);
  WriteLog(url);
  try
    Client.Get(url);
  except
    on e: Exception do
      WriteLog(e.Message);
  end;
  WriteLog('sent');
end;

end.

