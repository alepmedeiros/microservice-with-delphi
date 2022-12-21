unit cadastroapi.backend.dto.cliente;

interface

uses
  System.Generics.Collections,
  cadastroapi.backend.model.enums,
  cadastroapi.backend.dto.endereco,
  cadastroapi.backend.dto.contato;

type
  TClienteDTO = class
  private
    FNome: String;
    FId: Integer;
    FTipo: TTipoPessoa;
    FCPFCNPJ: String;
    FEndereco: TObjectList<TEnderecoDTO>;
    FContato: TObjectList<TContatoDTO>;
  public
    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
    property Tipo: TTipoPessoa read FTipo write FTipo;
    property CPFCNPJ: String read FCPFCNPJ write FCPFCNPJ;
    property Endereco: TObjectList<TEnderecoDTO> read FEndereco write FEndereco;
    property Contato: TObjectList<TContatoDTO> read FContato write FContato;

    constructor Create;
    destructor Destroy; override;
    class function New: TClienteDTO;
  end;

implementation

{ TClienteDTO }

constructor TClienteDTO.Create;
begin
  FEndereco := TObjectList<TEnderecoDTO>.Create;
  FContato := TObjectList<TContatoDTO>.Create;
end;

destructor TClienteDTO.Destroy;
begin
  FEndereco.DisposeOf;
  FContato.DisposeOf;
  inherited;
end;

class function TClienteDTO.New: TClienteDTO;
begin
  Result := Self.Create;
end;

end.
