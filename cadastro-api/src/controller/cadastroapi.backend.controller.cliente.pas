unit cadastroapi.backend.controller.cliente;

interface

uses
  Horse,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  cadastroapi.backend.utils,
  commons.backend.services,
  cadastroapi.backend.dto.cliente,
  cadastroapi.backend.model.entity.cliente,
  cadastroapi.backend.model.entity.pessoa,
  cadastroapi.backend.model.entity.endereco,
  cadastroapi.backend.model.entity.contatos;

procedure Registery(App: THorse);

implementation

procedure GravarCliente(lDTO: TClienteDTO);
var
  lCliente: TCliente;
begin
  lCliente.IdPessoa := lDTO.Id;
  TServices<TCliente>.New.Insert(lCliente);
end;

procedure GravarContato(aIdPessoa: Integer; Value: TObjectList<TContatos>);
var
  lContato: TContatos;
begin
  for lContato in value do
  begin
    lContato.IdPessoa := aIdPessoa;
    TServices<TContatos>.New.Insert(lContato);
  end;
end;

procedure GravarEndereco(aIdPessoa: Integer; Value: TObjectList<TEndereco>);
var
  lEndereco: TEndereco;
begin
  for lEndereco in Value do
  begin
    lEndereco.IdPessoa := aIdPessoa;
    TServices<TEndereco>.New.Insert(lEndereco);
  end;
end;

procedure BuscarPorId(Req: THorseRequest; Res: THorseResponse);
var
  lPessoa: TPessoa;
  lEndereco: TObjectList<TEndereco>;
  lContato: TObjectList<TContatos>;
  lCliente: TClienteDTO;
begin
  lPessoa := TServices<TPessoa>.New.Find(Req.Params['id'].ToInteger);
  lContato := TServices<TContatos>.New.FindWhere('id_pessoa', Req.Params['id'].ToInteger);
  lEndereco := TServices<TEndereco>.New.FindWhere('id_pessoa',Req.Params['id'].ToInteger);

  lCliente := TServices<TCliente>.New
                .FindWhere('id_pessoa',Req.Params['id'])
                  .Convert(lPessoa, lContato, lEndereco);
  Res.Send<TJSONObject>(lCliente.ToJson);
end;

procedure ListarTodos(Req: THorseRequest; Res: THorseResponse);
var
  lDto: TObjectList<TClienteDTO>;
  lClientes: TObjectList<TCliente>;
  lCliente: TCliente;
begin
  lDTO := TObjectList<TClienteDTO>.Create;
  lClientes := TServices<TCliente>.New.FindAll;
  for lCliente in lClientes do
    lDto.Add(lCliente
                .Convert(TServices<TPessoa>.New.Find(lCliente.IdPessoa),
                         TServices<TContatos>.New.FindWhere('id_pessoa',lCliente.IdPessoa),
                         TServices<TEndereco>.New.FindWhere('id_pessoa', lCliente.IdPessoa)));
  Res.Send<TJsonArray>(TClienteDTO.New.ListToJsonArray(lDto));
end;

procedure Novo(Req: THorseRequest; Res: THorseResponse);
var
  lDTO: TClienteDTO;
  lPessoa: TPessoa;
  lContatos: TObjectList<TContatos>;
  lEnderecos: TObjectList<TEndereco>;
  lCliente: TCliente;
begin
  lDTO := TClienteDTO.New.JsonToObject(Req.Body);
  lDTO.Convert(lPessoa,lCliente,lContatos,lEnderecos);

  lPessoa := TServices<TPessoa>.New.Insert(lPessoa);
  lDTO.Id := lPessoa.Id;

  GravarCliente(lDTO);
  GravarContato(lDTO.Id,lContatos);
  GravarEndereco(lDTO.Id, lEnderecos);

  Res.Send<TJSONObject>(lDTO.ToJson);
end;

procedure Excluir(Req: THorseRequest; Res: THorseResponse);
begin
  try
    TServices<TPessoa>.New.Delete(Req.Params['id']);
    Res.Status(204);
  except
    Res.Status(400);
  end;
end;

procedure Registery(App: THorse);
begin
  App.Get('/clientes/:id', BuscarPorId);
  App.Get('/clientes', ListarTodos);
  App.Post('/clientes', Novo);
  App.Delete('/clientes/:id/excluir', Excluir);
end;

end.
