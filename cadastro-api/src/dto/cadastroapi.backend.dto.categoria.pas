unit cadastroapi.backend.dto.categoria;

interface

uses
  System.Generics.Collections;

type
  TCategoriaDTO = class
  private
    FId: Integer;
    FDescricao: String;
  public
    property Id: Integer read FId write FId;
    property Descricao: String read FDescricao write FDescricao;

    class function New: TCategoriaDTO;
  end;

implementation

{ TCategoriaDTO }

class function TCategoriaDTO.New: TCategoriaDTO;
begin
  Result := Self.Create;
end;

end.
