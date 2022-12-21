unit cadastroapi.backend.model.entity.cliente;

interface

uses
  SimpleAttributes;

type
  [Tabela('CLIENTE')]
  TCliente = class
  private
    FId: Integer;
    FIdPessoa: Integer;
    FCPFCNPJ: String;
  public
    [Campo('ID'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('ID_PESSOA'), FK]
    property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    [Campo('CPFCNPJ')]
    property CPFCNPJ: String read FCPFCNPJ write FCPFCNPJ;

    class function New: TCliente;
  end;

implementation

{ TCliente }

class function TCliente.New: TCliente;
begin
  Result := Self.Create;
end;

end.
