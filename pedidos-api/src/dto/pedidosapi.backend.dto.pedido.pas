unit pedidosapi.backend.dto.pedido;

interface

uses
  System.Generics.Collections,
  pedidosapi.backend.dto.pedidoitens;

type
  TPedidosDTO = class
  private
    FId: Integer;
    FCliente: Integer;
    FProduto: TObjectList<TPedidoItensDTO>;
    FTotal: Currency;
  public
    property Id: Integer read FId write FId;
    property Cliente: Integer read FCliente write FCliente;
    property Produto: TObjectList<TPedidoItensDTO> read FProduto write FProduto;
    property Total: Currency read FTotal write FTotal;

    constructor Create;
    destructor Destroy; override;
    class function New: TPedidosDTO;
  end;

implementation

{ TPedidosDTO }

constructor TPedidosDTO.Create;
begin
  FProduto:= TObjectList<TPedidoItensDTO>.Create;
end;

destructor TPedidosDTO.Destroy;
begin
  FProduto.DisposeOf;
  inherited;
end;

class function TPedidosDTO.New: TPedidosDTO;
begin
  Result := Self.Create;
end;

end.
