unit userapi.backend.services;

interface

uses
  SimpleInterface,
  SimpleDAO,
  SimpleAttributes,
  SimpleQueryFiredac,
  GBJSON.Helper,
  GBJSON.Interfaces,
  System.JSON,
  REST.JSON,
  System.SysUtils,
  System.Classes,
  FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.ConsoleUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  System.Generics.Collections,
  userapi.backend.resource.connect;

type
  iServices<T: class> = interface
    function Find(aId: Integer): T;
    function FindAll: TObjectList<T>;
    function FindWhere(aKey: String; aValue: Variant): T; overload;
    function FindWhere(aKey: String; aValue: Integer): TObjectList<T>; overload;
    function Insert(Value: T): T;
    function Update(Value: T): T;
    function Delete(Value: T): iServices<T>; overload;
    function Delete(Value: Variant): iServices<T>; overload;
  end;

  TServices<T: class, constructor> = class(TInterfacedObject, iServices<T>)
  private
    FIndexConn: Integer;
    FConn: iSimpleQuery;
    FDAO: iSimpleDAO<T>;
    FDataSource: TDataSource;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iServices<T>;
    function Find(aId: Integer): T;
    function FindAll: TObjectList<T>;
    function FindWhere(aKey: String; aValue: Variant): T; overload;
    function FindWhere(aKey: String; aValue: Integer): TObjectList<T>; overload;
    function Insert(Value: T): T;
    function Update(Value: T): T;
    function Delete(Value: T): iServices<T>; overload;
    function Delete(Value: Variant): iServices<T>; overload;
  end;

implementation

constructor TServices<T>.Create;
begin
  FDataSource := TDataSource.Create(nil);
  FIndexConn := userapi.backend.resource.connect.Connected;
  FConn := TSimpleQueryFiredac.New(userapi.backend.resource.connect.FConnList.Items
    [FIndexConn]);
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndNone;
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
end;

function TServices<T>.Delete(Value: T): iServices<T>;
begin
  Result := Self;
  FDAO.Delete(Value);
end;

function TServices<T>.Delete(Value: Variant): iServices<T>;
begin
  Result := Self;
  FDAO.Delete('id', Value);
end;

destructor TServices<T>.Destroy;
begin
  FDataSource.Free;
  userapi.backend.resource.connect.Disconnected(FIndexConn);
  inherited;
end;

function TServices<T>.Find(aId: Integer): T;
begin
  Result := FDAO.Find(aId);
end;

function TServices<T>.FindAll: TObjectList<T>;
begin
  Result := TObjectList<T>.create;
  FDAO.Find(Result);
end;

function TServices<T>.FindWhere(aKey: String; aValue: Integer): TObjectList<T>;
begin
  FDAO.Find(aKey,aValue);
  Result := TGBJSONDefault.Serializer<T>.JsonArrayToList(FDataSource.DataSet.ToJSONArray);
end;

function TServices<T>.FindWhere(aKey: String; aValue: Variant): T;
begin
  FDAO.Find(aKey, aValue);
  Result := TGBJSONDefault.serializer<T>.JsonObjectToObject(FDataSource.DataSet.ToJSONObject);
end;

function TServices<T>.Insert(Value: T): T;
begin
  FDAO.Insert(Value);
  Result := TGBJSONDefault.Serializer<T>.JsonObjectToObject(FDataSource.DataSet.ToJSONObject);
end;

class function TServices<T>.New: iServices<T>;
begin
  Result := Self.Create;
end;

function TServices<T>.Update(Value: T): T;
begin
  FDAO.Update(Value);
  Result := TGBJSONDefault.Serializer<T>.JsonObjectToObject(FDataSource.DataSet.ToJSONObject);
end;

end.
