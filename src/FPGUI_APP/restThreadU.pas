unit restThreadU;

interface

uses
  Classes, SysUtils,
  restServerU;

type

  { TRestThread }

  TRestThread = class(TThread)
  protected
    procedure Execute; override;
  public
    Server: TRestServer;
    Port, ClientPort: Integer;
  end;

implementation

{ TRestThread }

procedure TRestThread.Execute;
begin
  Server := TRestServer.Create(nil);
  Server.Port := Port;
  Server.ClientPort := ClientPort;
  Server.SendLog('Now starting server...');
  Server.Active := True;
  Server.Free;
end;

end.

