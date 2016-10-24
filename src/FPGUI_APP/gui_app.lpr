program gui_app;

uses httpServerU;

var
  server: TRestServer;
begin
  server := TRestServer.Create(nil);
  server.Port := 6000;
  server.Active := True;
  server.Free;
end.

