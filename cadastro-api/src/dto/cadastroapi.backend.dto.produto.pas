unit cadastroapi.backend.dto.produto;

interface

uses
  cadastroapi.backend.dto.categoria;

type
  TProdutoDTO = class
  private
    FId: Integer;
    FDescricao: String;
    FPreco: Currency;
    FEstoqueMinimo: Double;
    FEstoqueMaximo: Double;
    FEstoqueAtual: Double;
    FCategoria: TCategoriaDTO;
  public
    property Id: Integer read FId write FId;
    property Descricao: String read FDescricao write FDescricao;
    property Preco: Currency read FPreco write FPreco;
    property EstoqueMinimo: Double read FEstoqueMinimo write FEstoqueMinimo;
    property EstoqueMaximo: Double read FEstoqueMaximo write FEstoqueMaximo;
    property EstoqueAtual: Double read FEstoqueAtual write FEstoqueAtual;
    property Categoria: TCategoriaDTO read FCategoria write FCategoria;

    constructor Create;
    destructor Destroy; override;
    class function New: TProdutoDTO;
  end;

implementation

{ TProdutoDTO }

constructor TProdutoDTO.Create;
begin
  FCategoria := TCategoriaDTO.New;
end;

destructor TProdutoDTO.Destroy;
begin
  FCategoria.DisposeOf;
  inherited;
end;

class function TProdutoDTO.New: TProdutoDTO;
begin
  Result := Self.Create;
end;

end.
