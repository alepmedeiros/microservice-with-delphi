unit userapi.backend.resource.connect;

interface

uses
  System.JSON,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  Firedac.Phys.SQLite,
  Firedac.Phys.SQLiteDef,
  FireDAC.Comp.UI;


var
  FConnList : TObjectList<TFDConnection>;

function Connected : Integer;
procedure Disconnected(IndexConn : Integer);

implementation

function Connected : Integer;
var
  IndexConn : Integer;
  lDataBase: String;
begin
  {$IFDEF MSWINDOWS}
  lDataBase := '..\..\db\dados.sdb';
  {$ELSE}
  lDataBase := GetEnvironmentVariable('DATABASE');
  {$ENDIF}

  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

    FConnList.Add(TFDConnection.Create(nil));
    IndexConn := Pred(FConnList.Count);
    FConnList.Items[IndexConn].Params.DriverID := 'SQLite';

    FConnList.Items[IndexConn].Params.Database := lDataBase;
    FConnList.Items[IndexConn].Params.Add('LockingMode=Normal');
    FConnList.Items[IndexConn].Connected;
  Result := IndexConn;
end;

procedure Disconnected(IndexConn : Integer);
begin
  FConnList.Items[IndexConn].Connected := false;
  FConnList.Items[IndexConn].Free;
  FConnList.TrimExcess;
end;

end.
