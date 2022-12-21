unit cadastroapi.backend.model.entity.endereco;

interface

uses
  SimpleAttributes;

type
  [Tabela('ENDERECO')]
  TEndereco = class
  private
    FIdPessoa: Integer;
    FLogradouro: String;
    FNumero: String;
    FComplemento: String;
    FCidade: String;
    FEstado: String;
    FCep: String;
    FBairro: String;
    FTipo: String;
    FId: Integer;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('ID_PESSOA'), FK]
    property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    [Campo('LOGRADOURO')]
    property Logradouro: String read FLogradouro write FLogradouro;
    [Campo('NUMERO')]
    property Numero: String read FNumero write FNumero;
    [Campo('COMPLEMENTO')]
    property Complemento: String read FComplemento write FComplemento;
    [Campo('CEP')]
    property Cep: String read FCep write FCep;
    [Campo('BAIRRO')]
    property Bairro: String read FBairro write FBairro;
    [Campo('CIDADE')]
    property Cidade: String read FCidade write FCidade;
    [Campo('ESTADO')]
    property Estado: String read FEstado write FEstado;
    [Campo('TIPO')]
    property Tipo: String read FTipo write FTipo;

    class function New: TEndereco;
  end;

implementation

{ TEndereco }

class function TEndereco.New: TEndereco;
begin
  Result := Self.Create;
end;

end.
