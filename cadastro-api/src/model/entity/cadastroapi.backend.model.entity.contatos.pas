unit cadastroapi.backend.model.entity.contatos;

interface

uses
  SimpleAttributes;

type
  [Tabela('CONTATOS')]
  TContatos = class
  private
    FId: Integer;
    FEmail: String;
    FTelefone: String;
    FTipo: String;
    FIdPessoa: Integer;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('ID_PESSOA'), FK]
    property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    [Campo('EMAIL')]
    property Email: String read FEmail write FEmail;
    [Campo('TELEFONE')]
    property Telefone: String read FTelefone write FTelefone;
    [Campo('TIPO')]
    property Tipo: String read FTipo write FTipo;

    class function New: TContatos;
  end;

implementation

{ TContatos }

class function TContatos.New: TContatos;
begin
  Result := Self.Create;
end;

end.
