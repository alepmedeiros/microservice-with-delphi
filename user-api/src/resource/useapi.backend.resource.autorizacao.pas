unit useapi.backend.resource.autorizacao;

interface

uses
  System.SysUtils,
  Horse,
  Horse.JWT,
  JOSE.Core.JWT,
  JOSE.Core.Builder,
  commons.backend.services,
  userapi.backend.model.entity.usuarios,
  userapi.backend.dto.usuario;

function Autorizacao: THorseCallBack;
function ValidarAutorizacao(aUsuario, aSenha: String): Boolean;

implementation

function ValidarAutorizacao(aUsuario, aSenha: String): Boolean;
begin
  Result := not (TServices<TUsuarios>.New.FindWhere('nome', aUsuario).Nome.IsEmpty and
    TServices<TUsuarios>.New.FindWhere('senha', aSenha).senha.IsEmpty);
end;

function Autorizacao: THorseCallBack;
begin
  Result := HorseJWT('Alessandro');
end;

end.
