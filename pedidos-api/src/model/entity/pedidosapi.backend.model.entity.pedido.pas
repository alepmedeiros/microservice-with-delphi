unit pedidosapi.backend.model.entity.pedido;

interface

uses
  SimpleAttributes;

type
  [Tabela('PEDIDOS')]
  TPedidos = class
  private
    FId: Integer;
    FCliente: Integer;
    FTotal: Currency;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('ID_CLIENTE'), FK]
    property Cliente: Integer read FCliente write FCliente;
    [Campo('TOTAL')]
    property Total: Currency read FTotal write FTotal;

    class function New: TPedidos;
  end;

implementation

{ TPedidos }

class function TPedidos.New: TPedidos;
begin
  Result := Self.Create;
end;

end.
