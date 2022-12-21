unit userapi.backend.controller;

interface

uses
  System.SysUtils,
  System.JSON,
  System.DateUtils,
  Horse,
  JOSE.Core.JWT,
  JOSE.Core.Builder,
  userapi.backend.utils,
  commons.backend.services,
  useapi.backend.resource.autorizacao,
  userapi.backend.dto.usuario,
  userapi.backend.model.entity.usuarios;

procedure Registery(App: THorse);
function Logar(aUsuario, aSenha: String): TJSONObject;

implementation

function Logar(aUsuario, aSenha: String): TJSONObject;
var
  JWT: TJWT;
  Claims: TJWTClaims;
  lHora: integer;
  lJson: TJSONObject;
begin
  JWT := TJWT.Create;
  Claims := JWT.Claims;
  Claims.JSON := TJSONObject.Create;
  Claims.IssuedAt := Now;
  Claims.Expiration := IncHour(Now,1);
  lHora := trunc(Claims.Expiration);
  if not ValidarAutorizacao(aUsuario, aSenha) then
  begin
    Result := TJSONObject.Create.AddPair('error','Erro ao tentar validar o acesso');
    exit;
  end;
  lJson := TJSONObject.Create;
  lJson.AddPair('horas', TJSONNumber.Create(lHora));
  lJson.AddPair('token', TJOSE.SHA256CompactToken('Alessandro', JWT));
  Result := lJson;
end;

procedure Autorizado(Req: THorseRequest; Res: THorseResponse);
begin
  Res.Status(204);
end;

procedure Login(Req: THorseRequest; Res: THorseResponse);
var
  lUsuario: TUsuarioDTO;
begin
  lUsuario := TUsuarioDTO.New.JsonToObject(Req.Body);

  Res.Send<TJsonObject>(Logar(lUsuario.Nome, lUsuario.Senha));
end;

procedure Cadastrar(Req: THorseRequest; Res: THorseResponse);
var
  lUsuario: TUsuarioDTO;
  lUser: TUsuarios;
  lJson: TJsonObject;
begin
  lUsuario := TUsuarioDTO.New.JsonToObject(Req.Body);
  lUsuario.id := TServices<TUsuarios>.New.Insert(lUsuario.Convert).Id;

  Res.Send<TJsonObject>(Logar(lUsuario.Nome, lUsuario.Senha));
end;

procedure BuscarPorId(Req: THorseRequest; Res: THorseResponse);
var
  lDto: TUsuarioDTO;
begin
  lDto := TServices<TUsuarios>.New.Find(Req.Params['id'].ToInteger).Convert;
  Res.Send<TJSONObject>(lDTO.ToJSON);
end;

procedure Registery(App: THorse);
begin
  App.Post('/usuarios/login', Login);
  App.AddCallback(Autorizacao()).Get('/usuarios/autorizado', Autorizado);
  App.AddCallback(Autorizacao()).Get('/usuarios/:id', BuscarPorId);
  App.Post('/usuarios', Cadastrar);
end;

end.
