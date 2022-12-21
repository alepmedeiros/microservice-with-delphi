unit cadastroapi.backend.utils;

interface

uses
  System.Json,
  System.SysUtils,
  System.TypInfo,
  GBJSON.Interfaces,
  System.Generics.Collections,
  cadastroapi.backend.model.enums,
  cadastroapi.backend.dto.cliente,
  cadastroapi.backend.dto.contato,
  cadastroapi.backend.dto.endereco,
  cadastroapi.backend.dto.categoria,
  cadastroapi.backend.dto.produto,
  cadastroapi.backend.model.entity.cliente,
  cadastroapi.backend.model.entity.contatos,
  cadastroapi.backend.model.entity.endereco,
  cadastroapi.backend.model.entity.pessoa,
  cadastroapi.backend.model.entity.categoria,
  cadastroapi.backend.model.entity.produto;

type
  TTipoPessoaHelper = record helper for TTipoPessoa
    function ToEnum(Value: String): TTipoPessoa;
    function ToString: String;
  end;

  TTipoContatoHelper = record helper for TTipoContato
    function ToEnum(Value: String): TTipoContato;
    function ToString: String;
  end;

  TClienteDTOHelper = class helper for TClienteDTO
    procedure Convert(var pessoa: TPessoa; var cliente: TCliente;
      var listContato: TObjectList<TContatos>;
      var listEndereco: TObjectList<TEndereco>);
    function ToJson: TJSONObject;
    function JsonToObject(Value: String): TClienteDTO;
    function ListToJsonArray(Value: TObjectList<TClienteDTO>): TJSONArray;
  end;

  TClienteHelper = class helper for TCliente
    function Convert(pessoa: TPessoa;
          listaContato: TObjectList<TContatos>;
          listaEndereco: TObjectList<TEndereco>): TClienteDTO;
  end;

  TContatoDTOHelper = class helper for TContatoDTO
    function Convert: TContatos;
  end;

  TContatoHelper = class helper for TContatos
    function Convert: TContatoDTO;
  end;

  TEnderecoDTOHelper = class helper for TEnderecoDTO
    function Convert: TEndereco;
  end;

  TEnderecoHelper = class helper for TEndereco
    function Convert: TEnderecoDTO;
  end;

  TCategoriaDTOHelper = class helper for TCategoriaDTO
    function Convert: TCategoria; overload;
    function Convert(Value: TObjectList<TCategoriaDTO>): TObjectList<TCategoria>; overload;
    function ToJson: TJSONObject;
    function JsonToObject(Value: String): TCategoriaDTO;
    function ListToJsonArray(Value: TObjectList<TCategoriaDTO>): TJSONArray;
  end;

  TCatetoriaHelper = class helper for TCategoria
    function Convert: TCategoriaDTO; overload;
    function Convert(Value: TObjectList<TCategoria>): TObjectList<TCategoriaDTO>; overload;
  end;

  TProdutoDTOHelper = class helper for TProdutoDTO
    function Convert: TProduto;
    function ToJson: TJSONObject;
    function JsonToObject(Value: String): TProdutoDTO;
    function ListToJsonArray(Value: TObjectList<TProdutoDTO>): TJSONArray;
  end;

  TProdutoHelper = class helper for TProduto
    function Convert(Value: TCategoria): TProdutoDTO; overload;
    function Convert(aCategoria: TCategoria; Value: TObjectList<TProduto>): TObjectList<TProdutoDTO>; overload;
  end;


implementation

{ TTipoPessoaHelper }

function TTipoPessoaHelper.ToEnum(Value: String): TTipoPessoa;
begin
  Result := TTipoPessoa(GetEnumValue(TypeInfo(TTipoPessoa), UpperCase(Value)));
end;

function TTipoPessoaHelper.ToString: String;
begin
  Result := GetEnumName(TypeInfo(TTipoPessoa), Integer(Self));
end;

{ TTipoContatoHelper }

function TTipoContatoHelper.ToEnum(Value: String): TTipoContato;
begin
  Result := TTipoContato(GetEnumValue(TypeInfo(TTipoContato),
    UpperCase(Value)));
end;

function TTipoContatoHelper.ToString: String;
begin
  Result := GetEnumName(TypeInfo(TTipoContato), Integer(Self));
end;

{ TClienteDTOHelper }

procedure TClienteDTOHelper.Convert(var pessoa: TPessoa; var cliente: TCliente;
  var listContato: TObjectList<TContatos>;
  var listEndereco: TObjectList<TEndereco>);
var
  lContato: TContatoDTO;
  lEndereco: TEnderecoDTO;
begin
  pessoa := TPessoa.New;
  cliente := TCliente.New;

  pessoa.Id := Self.Id;
  pessoa.Nome := Self.Nome;
  pessoa.Tipo := Self.Tipo.ToString;

  cliente.IdPessoa := Self.Id;
  cliente.CPFCNPJ := Self.CPFCNPJ;

  listContato := TObjectList<TContatos>.Create;
  for lContato in Self.contato do
    listContato.Add(lContato.Convert);

  listEndereco := TObjectList<TEndereco>.Create;
  for lEndereco in Self.endereco do
    listEndereco.Add(lEndereco.Convert);
end;

function TClienteDTOHelper.JsonToObject(Value: String): TClienteDTO;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TClienteDTO>.JsonStringToObject(Value);
end;

function TClienteDTOHelper.ListToJsonArray(Value: TObjectList<TClienteDTO>): TJSONArray;
begin
  Result := TJSONArray.Create;
  for Self in Value do
    Result.Add(Self.ToJson);
end;

function TClienteDTOHelper.ToJson: TJSONObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TClienteDTO>.ObjectToJsonObject(Self);
end;

{ TContatoDTOHelper }

function TContatoDTOHelper.Convert: TContatos;
begin
  Result := TContatos.New;
  Result.IdPessoa := Self.Id;
  Result.Email := Self.Email;
  Result.Telefone := Self.Telefone;
  Result.Tipo := Self.Tipo.ToString;
end;

{ TEnderecoDTOHelper }

function TEnderecoDTOHelper.Convert: TEndereco;
begin
  Result := TEndereco.New;
  Result.IdPessoa := Self.Id;
  Result.Logradouro := Self.Logradouro;
  Result.Numero := Self.Numero;
  Result.Complemento := Self.Complemento;
  Result.Cep := Self.Cep;
  Result.Bairro := Self.Bairro;
  Result.Cidade := Self.Cidade;
  Result.Estado := Self.Estado;
  Result.Tipo := Self.Tipo.ToString;
end;

{ TCategoriaDTOHelper }

function TCategoriaDTOHelper.Convert: TCategoria;
begin
  Result := TCategoria.New;
  Result.Id := Self.Id;
  Result.Descricao := Self.Descricao;
end;

function TCategoriaDTOHelper.Convert(
  Value: TObjectList<TCategoriaDTO>): TObjectList<TCategoria>;
var
  lCategoria: TCategoriaDTO;
begin
  Result := TObjectList<TCategoria>.Create;
  for lCategoria in Value do
    Result.Add(lCategoria.Convert);
end;

function TCategoriaDTOHelper.JsonToObject(Value: String): TCategoriaDTO;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TCategoriaDTO>.JsonStringToObject(Value);
end;

function TCategoriaDTOHelper.ListToJsonArray(
  Value: TObjectList<TCategoriaDTO>): TJSONArray;
begin
  Result := TJSONArray.Create;
  for Self in Value do
    Result.Add(Self.ToJson);
end;

function TCategoriaDTOHelper.ToJson: TJSONObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TCategoriaDTO>.ObjectToJsonObject(Self);
end;

{ TProdutoDTOHelper }

function TProdutoDTOHelper.Convert: TProduto;
begin
  Result := TProduto.New;
  Result.Id := Self.Id;
  Result.Descricao := Self.Descricao;
  Result.Preco := Self.Preco;
  Result.EstoqueMinimo := Self.EstoqueMinimo;
  Result.EstoqueMaximo := Self.EstoqueMaximo;
  Result.EstoqueAtual := Self.EstoqueAtual;
  Result.Categoria := Self.Categoria.Id;
end;

function TProdutoDTOHelper.JsonToObject(Value: String): TProdutoDTO;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TProdutoDTO>.JsonStringToObject(Value);
end;

function TProdutoDTOHelper.ListToJsonArray(
  Value: TObjectList<TProdutoDTO>): TJSONArray;
begin
  Result := TJSONArray.Create;
  for Self in Value do
    Result.Add(Self.ToJson);
end;

function TProdutoDTOHelper.ToJson: TJSONObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TProdutoDTO>.ObjectToJsonObject(Self);
end;

{ TClienteHelper }

function TClienteHelper.Convert(pessoa: TPessoa;
  listaContato: TObjectList<TContatos>;
  listaEndereco: TObjectList<TEndereco>): TClienteDTO;
var
  lContato: TContatos;
  lEndereco: TEndereco;
  lTipo: TTipoPessoa;
begin
  Result := TClienteDTO.New;
  Result.Id := Self.IdPessoa;
  Result.Nome := pessoa.Nome;
  Result.Tipo := lTipo.ToEnum(pessoa.Tipo);
  Result.CPFCNPJ := self.CPFCNPJ;

  for lContato in listaContato do
    Result.Contato.Add(lContato.Convert);

  for lEndereco in listaEndereco do
    Result.Endereco.Add(lEndereco.Convert);
end;

{ TContatoHelper }

function TContatoHelper.Convert: TContatoDTO;
var
  lTipo: TTipoContato;
begin
  Result := TContatoDTO.New;

  Result.Id := Self.IdPessoa;
  Result.Email := Self.Email;
  Result.Telefone := Self.Telefone;
  Result.Tipo := lTipo.ToEnum(Self.Tipo);
end;

{ TEnderecoHelper }

function TEnderecoHelper.Convert: TEnderecoDTO;
var
  lTipo: TTipoContato;
begin
  Result := TEnderecoDTO.New;
  Result.Id := Self.IdPessoa;
  Result.Logradouro := Self.Logradouro;
  Result.Numero := Self.Numero;
  Result.Complemento := Self.Complemento;
  Result.Cep := Self.Cep;
  Result.Bairro := Self.Bairro;
  Result.Cidade := Self.Cidade;
  Result.Estado := Self.Estado;
  Result.Tipo := lTipo.ToEnum(Self.Tipo);
end;

{ TCatetoriaHelper }

function TCatetoriaHelper.Convert: TCategoriaDTO;
begin
  Result := TCategoriaDTO.New;
  Result.Id := Self.Id;
  Result.Descricao := Self.Descricao;
end;

function TCatetoriaHelper.Convert(
  Value: TObjectList<TCategoria>): TObjectList<TCategoriaDTO>;
var
  lCategoria: TCategoria;
begin
  Result := TObjectList<TCategoriaDTO>.Create;
  for lCategoria in Value do
    Result.Add(lCategoria.Convert);
end;

{ TProdutoHelper }

function TProdutoHelper.Convert(aCategoria: TCategoria;
  Value: TObjectList<TProduto>): TObjectList<TProdutoDTO>;
var
  lProduto: TProduto;
begin
  Result := TObjectList<TProdutoDTO>.Create;
  for lProduto in Value do
    Result.Add(lProduto.Convert(aCategoria));
end;

function TProdutoHelper.Convert(Value: TCategoria): TProdutoDTO;
begin
  Result := TProdutoDTO.New;

  Result.Id := Self.Id;
  Result.Descricao := Self.Descricao;
  Result.Preco := Self.Preco;
  Result.EstoqueMinimo := Self.EstoqueMinimo;
  Result.EstoqueMaximo := Self.EstoqueMaximo;
  Result.EstoqueAtual := Self.EstoqueAtual;
  Result.Categoria := Value.Convert;
end;

end.
