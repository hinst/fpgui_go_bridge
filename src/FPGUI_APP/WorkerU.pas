unit WorkerU;

interface

uses
  Classes, SysUtils, syncobjs;

type

  { TWorker }

  TWorker = class
  public
    Event: TSimpleEvent;
    constructor Create;
    destructor Destroy; override;
    procedure Run; virtual;
    procedure Clear;
  end;

implementation

{ TWorker }

constructor TWorker.Create;
begin
  inherited Create;
  Event := TSimpleEvent.Create;
end;

destructor TWorker.Destroy;
begin
  Event.Free;
  inherited Destroy;
end;

procedure TWorker.Run;
begin
end;

procedure TWorker.Clear;
begin
  Event.ResetEvent;
end;

end.

