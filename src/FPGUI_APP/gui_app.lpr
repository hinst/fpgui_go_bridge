program gui_app;

uses restServerU, restThreadU;

var
  server: TRestServer;
begin
  server := TRestServer.Create(nil);
  server.Port := 8600;
  server.Active := True;
  server.Free;
end.

