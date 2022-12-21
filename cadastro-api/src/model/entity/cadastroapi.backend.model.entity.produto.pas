unit cadastroapi.backend.model.entity.produto;

interface

uses
  SimpleAttributes;

type
  [Tabela('PRODUTO')]
  TProduto = class
  private
    FId: Integer;
    FDescricao: String;
    FPreco: Currency;
    FEstoqueMinimo: Double;
    FEstoqueMaximo: Double;
    FEstoqueAtual: Double;
    FCategoria: Integer;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('DESCRICAO')]
    property Descricao: String read FDescricao write FDescricao;
    [Campo('PRECO')]
    property Preco: Currency read FPreco write FPreco;
    [Campo('ESTOQUEMINIMO')]
    property EstoqueMinimo: Double read FEstoqueMinimo write FEstoqueMinimo;
    [Campo('ESTOQUEMAXIMO')]
    property EstoqueMaximo: Double read FEstoqueMaximo write FEstoqueMaximo;
    [Campo('ESTOQUEATUAL')]
    property EstoqueAtual: Double read FEstoqueAtual write FEstoqueAtual;
    [Campo('ID_CATEGORIA')]
    property Categoria: Integer read FCategoria write FCategoria;

    class function New: TProduto;
  end;

implementation

{ TProduto }

class function TProduto.New: TProduto;
begin
  Result := Self.Create;
end;

end.
