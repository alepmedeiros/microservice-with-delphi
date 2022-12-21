unit pedidosapi.backend.dto.produto;

interface

type
  TProdutoDTO = class
  private
    FId: Integer;
    FDescricao: String;
    FEstoqueAtual: Double;
  public
    property Id: Integer read FId write FId;
    property Descricao: String read FDescricao write FDescricao;
    property EstoqueAtual: Double read FEstoqueAtual write FEstoqueAtual;

    class function New: TProdutoDTO;
  end;

implementation

{ TProdutoDTO }

class function TProdutoDTO.New: TProdutoDTO;
begin
  Result := Self.Create;
end;

end.
