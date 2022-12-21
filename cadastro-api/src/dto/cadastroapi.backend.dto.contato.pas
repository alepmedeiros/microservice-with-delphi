unit cadastroapi.backend.dto.contato;

interface

uses
  cadastroapi.backend.model.enums;

type
  TContatoDTO = class
  private
    FId: Integer;
    FEmail: String;
    FTelefone: String;
    FTipo: TTipoContato;
  public
    property Id: Integer read FId write FId;
    property Email: String read FEmail write FEmail;
    property Telefone: String read FTelefone write FTelefone;
    property Tipo: TTipoContato read FTipo write FTipo;

    class function New: TContatoDTO;
  end;

implementation

{ TContatoDTO }

class function TContatoDTO.New: TContatoDTO;
begin
  Result := Self.Create;
end;

end.
