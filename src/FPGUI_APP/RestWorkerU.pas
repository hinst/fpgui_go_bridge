unit RestWorkerU;

interface

uses
  Classes, SysUtils,
  fphttpserver,
  WorkerU, SynchronizerU;

type

  { TRestWorker }

  TRestWorker = class(TWorker)
  protected
    QueryString: string;
  public
    Request: TFPHTTPConnectionRequest;
    Response: TFPHTTPConnectionResponse;
    Quit: Boolean;
    procedure Run; override;
  end;

implementation

{ TRestWorker }

procedure TRestWorker.Run;
begin
  QueryString := Request.QueryString;
  if QueryString = 'quit' then
    self.Quit := True;
end;

end.

