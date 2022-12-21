unit userapi.backend.utils;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  GBJSON.Interfaces,
  userapi.backend.dto.usuario,
  userapi.backend.model.entity.usuarios;

type
  TUsuarioDTOHelper = class helper for TUsuarioDTO
    function Convert: TUsuarios;
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TUsuarioDTO;
  end;

  TUsuariosHelper = class helper for TUsuarios
    function Convert: TUsuarioDTO;
    function ToJson: TJsonObject;
    function JsonToObject(Value: String): TUsuarios;
  end;

implementation

{ TUsuarioDTOHelper }

function TUsuarioDTOHelper.Convert: TUsuarios;
begin
  Result := TUsuarios.New;
  Result.Id := Self.Id;
  Result.Nome := Self.Nome;
  Result.Email := Self.Email;
  Result.Senha := Self.Senha;
end;

function TUsuarioDTOHelper.JsonToObject(Value: String): TUsuarioDTO;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TUsuarioDTO>.JsonStringToObject(Value);
end;

function TUsuarioDTOHelper.ToJSON: TJSONObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TUsuarioDTO>.ObjectToJsonObject(Self);
end;

{ TUsuariosHelper }

function TUsuariosHelper.Convert: TUsuarioDTO;
begin
  Result := TUsuarioDTO.New;
  Result.Id := Self.Id;
  Result.Nome := Self.Nome;
  Result.Email := Self.Email;
  Result.Senha := Self.Senha;
end;

function TUsuariosHelper.JsonToObject(Value: String): TUsuarios;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TUsuarios>.JsonStringToObject(Value);
end;

function TUsuariosHelper.ToJson: TJsonObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TUsuarios>.ObjectToJsonObject(Self);
end;

end.
