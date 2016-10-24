unit restServerU;

interface

uses
  fphttpserver, fpg_main;

type

  { TRestServer }

  TRestServer = class(TFPHttpServer)
  public
    procedure HandleRequest(var ARequest: TFPHTTPConnectionRequest;
      var AResponse: TFPHTTPConnectionResponse); override;
  end;

implementation

{ TRestServer }

procedure TRestServer.HandleRequest(var ARequest: TFPHTTPConnectionRequest;
  var AResponse: TFPHTTPConnectionResponse);
var
  queryString: string;
begin
  queryString := ARequest.QueryString;
  if queryString = 'start' then
    fpgApplication.Initialize;
  WriteLN(ARequest.QueryString);
end;

end.

