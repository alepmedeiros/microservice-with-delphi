unit pedidosapi.backend.utils;

interface

uses
  System.Json,
  System.SysUtils,
  System.TypInfo,
  GBJSON.Interfaces,
  System.Generics.Collections,
  pedidosapi.backend.model.entity.pedido,
  pedidosapi.backend.model.entity.pedidoitens,
  pedidosapi.backend.dto.pedido,
  pedidosapi.backend.dto.pedidoitens;

type
  TBaseURL = (AUTENTICACAO, CADASTRO);

  TBaseURLHelper = record helper for TBaseURL
    function ToBase: String;
  end;

  TPedidosHelper = class helper for TPedidos
    function Convert(Value: TObjectList<TPedidoItens>): TPedidosDTO;
  end;

  TPedidosDTOHelper = class helper for TPedidosDTO
    function Convert(var aItens: TObjectList<TPedidoItens>): TPedidos;
    function ToJson: TJSONObject;
    function JsonToObject(Value: String): TPedidosDTO;
    function ListToJSONArray(Value: TObjectList<TPedidosDTO>): TJSONArray;
  end;

  TPedidoItensHelper = class helper for TPedidoItens
    function Convert: TPedidoItensDTO;
  end;

  TPedidoItensDTOHelper = class helper for TPedidoItensDTO
    function Convert: TPedidoItens;
  end;

  TProdutoDTOHelper = class helper for TProdutoDTO
    function ToJson: TJSONObject;
    function JsonToObject(Value: String): TProdutoDTO;
    function ListToJsonArray(Value: TObjectList<TProdutoDTO>): TJSONArray;
    function JsonArrayToList(Value: String): TObjectList<TProdutoDTO>;
  end;

implementation

{ TBaseURLHelper }

function TBaseURLHelper.ToBase: String;
var
  lBase: TBaseURL;
begin
  case lbase of
    AUTENTICACAO:
    {$IFDEF MSWINDOWS}
      Result := 'http://localhost:9000/usuarios';
    {$ELSE}
      Result := GetEnvironmentVariable('AUTENTICATION_HOST')+'/usuarios';
    {$ENDIF}
    CADASTRO:
      {$IFDEF MSWINDOWS}
        Result := 'http://localhost:9001';
      {$ELSE}
        Result := GetEnvironmentVariable('CADASTRO_HOST');
      {$ENDIF}
  end;
end;

{ TPedidosHelper }

function TPedidosHelper.Convert(Value: TObjectList<TPedidoItens>): TPedidosDTO;
var
  lItem: TPedidoItens;
begin
  Result := TPedidosDTO.New;
  Result.Id := Self.Id;
  Result.Cliente := Self.Cliente;
  for lItem in Value do
    Result.Produto.Add(lItem.Convert);
  Result.Total := Self.Total;
end;

{ TPedidoItensHelper }

function TPedidoItensHelper.Convert: TPedidoItensDTO;
begin
  Result := TPedidoItensDTO.New;
  Result.Id := Self.Id;
  Result.Item := Self.Item;
  Result.Produto.Id := Self.Produto;
  Result.Quantidade := Self.Quantidade;
  Result.Unitario := Self.ValorUnitario;
end;

{ TPedidosDTOHelper }

function TPedidosDTOHelper.Convert(
  var aItens: TObjectList<TPedidoItens>): TPedidos;
var
  lItem: TPedidoItens;
  lItemDTO: TPedidoItensDTO;
begin
  Result := TPedidos.New;
  Result.Id := Self.Id;
  Result.Cliente := Self.Cliente;
  Result.Total := Self.Total;

  aItens:= TObjectList<TPedidoItens>.Create;
  for lItemDTO in Self.Produto do
  begin
    lItem := lItemDTO.Convert;
    aItens.Add(lItem);
  end;
end;

function TPedidosDTOHelper.JsonToObject(Value: String): TPedidosDTO;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TPedidosDTO>.JsonStringToObject(Value);
end;

function TPedidosDTOHelper.ListToJSONArray(
  Value: TObjectList<TPedidosDTO>): TJSONArray;
begin
  Result := TJSONArray.Create;
  for Self in Value do
    Result.Add(Self.ToJson);
end;

function TPedidosDTOHelper.ToJson: TJSONObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TPedidosDTO>.ObjectToJsonObject(Self);
end;

{ TProdutoDTOHelper }

function TProdutoDTOHelper.JsonArrayToList(
  Value: String): TObjectList<TProdutoDTO>;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TProdutoDTO>.JsonStringToList(Value);
end;

function TProdutoDTOHelper.JsonToObject(Value: String): TProdutoDTO;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TProdutoDTO>.JsonStringToObject(Value);
end;

function TProdutoDTOHelper.ListToJsonArray(
  Value: TObjectList<TProdutoDTO>): TJSONArray;
begin
  Result := TJSONArray.Create;
  for Self in Value do
    Result.Add(Self.ToJson);
end;

function TProdutoDTOHelper.ToJson: TJSONObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TProdutoDTO>.ObjectToJsonObject(Self);
end;

{ TPedidoItensDTOHelper }

function TPedidoItensDTOHelper.Convert: TPedidoItens;
begin
  Result := TPedidoItens.New;
  Result.Id := Self.Id;
  Result.Item := Self.Item;
  Result.Produto := Self.Produto.Id;
  Result.Quantidade := Self.Quantidade;
  Result.ValorUnitario := Self.Unitario;
  Result.Total := Self.Total;
end;

end.
