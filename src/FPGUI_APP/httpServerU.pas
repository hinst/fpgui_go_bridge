unit httpServerU;

interface

uses
  fphttpserver;

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
begin
  WriteLN(ARequest.QueryString);
end;

end.

