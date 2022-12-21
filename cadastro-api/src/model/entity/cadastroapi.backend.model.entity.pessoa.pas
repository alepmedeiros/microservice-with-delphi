unit cadastroapi.backend.model.entity.pessoa;

interface

uses
  SimpleAttributes;

type
  [Tabela('PESSOA')]
  TPessoa = class
  private
    FId: Integer;
    FNome: String;
    FTipo: String;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('NOME')]
    property Nome: String read FNome write FNome;
    [Campo('TIPO')]
    property Tipo: String read FTipo write FTipo;

    class function New: TPessoa;
  end;

implementation

{ TPessoa }

class function TPessoa.New: TPessoa;
begin
  Result := Self.Create;
end;

end.
