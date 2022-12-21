unit cadastroapi.backend.dto.endereco;

interface

uses
  cadastroapi.backend.model.enums;

type
  TEnderecoDTO = class
  private
    FId: Integer;
    FLogradouro: String;
    FNumero: String;
    FComplemento: String;
    FCep: String;
    FEstado: String;
    FBairro: String;
    FCidade: String;
    FTipo: TTipoContato;
  public
    property Id: Integer read FId write FId;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Numero: String read FNumero write FNumero;
    property Complemento: String read FComplemento write FComplemento;
    property Cep: String read FCep write FCep;
    property Bairro: String read FBairro write FBairro;
    property Cidade: String read FCidade write FCidade;
    property Estado: String read FEstado write FEstado;
    property Tipo: TTipoContato read FTipo write FTipo;

    class function New: TEnderecoDTO;
  end;

implementation

{ TEnderecoDTO }

class function TEnderecoDTO.New: TEnderecoDTO;
begin
  Result := Self.Create;
end;

end.
