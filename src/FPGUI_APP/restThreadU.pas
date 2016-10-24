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
    Port: Integer;
  end;

implementation

{ TRestThread }

procedure TRestThread.Execute;
begin
  Server := TRestServer.Create(nil);
  Server.Port := Port;
  Server.Active := True;
  Server.Free;
end;

end.

