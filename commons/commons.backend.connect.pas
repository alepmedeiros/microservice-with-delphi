unit commons.backend.connect;

interface

uses
  System.JSON,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  Firedac.Phys.SQLite,
  Firedac.Phys.SQLiteDef,
  FireDAC.Phys.SQLiteWrapper.Stat,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Comp.UI, System.SysUtils;


var
  FConnList : TObjectList<TFDConnection>;
  FDriver: TFDPhysSQLiteDriverLink;

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

  try
    FConnList.Add(TFDConnection.Create(nil));
    FDriver:= TFDPhysSQLiteDriverLink.Create(nil);
    IndexConn := Pred(FConnList.Count);
    FConnList.Items[IndexConn].Params.DriverID := 'SQLite';

    FConnList.Items[IndexConn].Params.Database := lDataBase;
    FConnList.Items[IndexConn].Params.Add('LockingMode=Normal');
    FConnList.Items[IndexConn].Connected;
    Result := IndexConn;
  except
    raise Exception.Create('Erro ao tentar conectar ao banco de dados');
  end;
end;

procedure Disconnected(IndexConn : Integer);
begin
  FConnList.Items[IndexConn].Connected := false;
  FConnList.Items[IndexConn].Free;
  FConnList.TrimExcess;
end;

end.
