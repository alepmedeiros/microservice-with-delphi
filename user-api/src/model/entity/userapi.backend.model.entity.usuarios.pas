unit userapi.backend.model.entity.usuarios;

interface

uses
  SimpleAttributes;

type
  [Tabela('USUARIOS')]
  TUsuarios = class
  private
    FId: Integer;
    FUsuario: String;
    FEmail: String;
    FSenha: String;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('NOME')]
    property Nome: String read FUsuario write FUsuario;
    [Campo('EMAIL')]
    property Email: String read FEmail write FEmail;
    [Campo('SENHA')]
    property Senha: String read FSenha write FSenha;

    class function New: TUsuarios;
  end;

implementation

{ TUsuarios }

class function TUsuarios.New: TUsuarios;
begin
  Result := Self.Create;
end;

end.
