unit cadastroapi.backend.model.entity.categoria;

interface

uses
  SimpleAttributes;

type
  [Tabela('CATEGORIA')]
  TCategoria = class
  private
    FId: Integer;
    FDescricao: String;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('DESCRICAO')]
    property Descricao: String read FDescricao write FDescricao;

    class function New: TCategoria;
  end;

implementation

{ TCategoria }

class function TCategoria.New: TCategoria;
begin
  Result := Self.Create;
end;

end.
