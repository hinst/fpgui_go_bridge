unit restThreadU;

interface

uses
  Classes, SysUtils,
  restServerU;

type

  { TRestThread }

  TRestThread = class(TThread)
  protected
    Server: TRestServer;
    procedure Execute; override;
  public
    Port, ClientPort: Integer;
  end;

implementation

{ TRestThread }

procedure TRestThread.Execute;
begin
  Server := TRestServer.Create(nil);
  Server.Port := Port;
  Server.ClientPort := ClientPort;
  Server.Active := True;
  Server.Free;
end;

end.

