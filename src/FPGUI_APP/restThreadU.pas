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
  end;

implementation

{ TRestThread }

procedure TRestThread.Execute;
begin
  Server := TRestServer.Create(nil);
  Server.Port := 8600;
  Server.Active := True;
  Server.Free;
end;

end.

