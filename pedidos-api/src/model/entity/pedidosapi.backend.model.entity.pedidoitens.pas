unit pedidosapi.backend.model.entity.pedidoitens;

interface

uses
  SimpleAttributes;

type
  [Tabela('PEDIDOITENS')]
  TPedidoItens = class
  private
    FId: Integer;
    FItem: Integer;
    FProduto: Integer;
    FQuantidade: Double;
    FValorUnitario: Currency;
    FTotal: Currency;
  public
    [Campo('ID'), FK]
    property Id: Integer read FId write FId;
    [Campo('ITEM')]
    property Item: Integer read FItem write FItem;
    [Campo('ID_PRODUTO'), FK]
    property Produto: Integer read FProduto write FProduto;
    [Campo('QUANTIDADE')]
    property Quantidade: Double read FQuantidade write FQuantidade;
    [Campo('VALORUNITARIO')]
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    [Campo('TOTAL')]
    property Total: Currency read FTotal write FTotal;

    class function New: TPedidoItens;
  end;

implementation

{ TPedidoItens }

class function TPedidoItens.New: TPedidoItens;
begin
  Result := Self.Create;
end;

end.
