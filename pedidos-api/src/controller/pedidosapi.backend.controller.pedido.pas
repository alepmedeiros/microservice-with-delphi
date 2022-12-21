unit pedidosapi.backend.controller.pedido;

interface

uses
  Horse,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  commons.backend.services,
  pedidosapi.backend.utils,
  pedidosapi.backend.dto.pedido,
  pedidosapi.backend.dto.pedidoitens,
  pedidosapi.backend.model.entity.pedido,
  pedidosapi.backend.model.entity.pedidoitens,
  pedidosapi.bachend.auth.impl.httpclient,
  Data.DB;

procedure Registery(App: THorse);

implementation

//function ListarTodosProdutos(aToken: String): TObjectList<TProdutoDTO>;
//var
//  lContent: String;
//begin
//  THttpClient.New(CADASTRO.ToBase)
//    .Token(aToken)
//    .GetAll('produtos')
//    .Content(lContent);
//
//   Result := TProdutoDTO.New.JsonArrayToList(lContent);
//end;

procedure ListarTodos(Req: THorseRequest; Res: THorseResponse);
var
  lToken: String;
  lPedidos: TObjectList<TPedidos>;
  lPedido: TPedidos;
  lItens: TObjectList<TPedidoItens>;
  lDTO : TObjectList<TPedidosDTO>;
begin
  lToken := Req.Headers[LowerCase('Authorization')].Replace('bearer ', '',
    [rfIgnoreCase]);

  lPedidos := TServices<TPedidos>.New.FindAll;

  lDTO := TObjectList<TPedidosDTO>.Create;
  for lPedido in lPedidos do
    lDTO.Add(lPedido.Convert(TServices<TPedidoItens>.New.FindWhere('id',lPedido.id)));

  Res.Send<TJSONArray>(TPedidosDTO.New.ListToJSONArray(lDTO));
end;

procedure ListarPor(Req: THorseRequest; Res: THorseResponse);
var
  lItens: TObjectList<TPedidoItens>;
begin
  lItens := TServices<TPedidoItens>.New.FindWhere('id', Req.Params['id'].ToInteger);
  Res.Send<TJSONObject>(TServices<TPedidos>.New
    .Find(Req.Params['id'].ToInteger).Convert(lItens).ToJson);
end;

procedure Novo(Req: THorseRequest; Res: THorseResponse);
var
  lDTO: TPedidosDTO;
  lItensDTO: TPedidoItensDTO;
  lPedido: TPedidos;
  lItens: TObjectList<TPedidoItens>;
  lItem: TPedidoItens;
  I: Integer;
begin
  lDTO:= TPedidosDTO.New.JsonToObject(Req.Body);

  lPedido := TServices<TPedidos>.New.Insert(lDTO.Convert(lItens));
  for lItem in lItens do
  begin
    lItem.Id := lPedido.Id;
    TServices<TPedidoItens>.New.Insert(lItem);
  end;

  lDTO.Id := lPedido.Id;
  for I := 0 to Pred(lDTO.Produto.Count) do
    lDTO.Produto[I].Id := lPedido.id;

  Res.Send<TJSONObject>(lDTO.ToJson);
end;

procedure Excluir(Req: THorseRequest; Res: THorseResponse);
begin
  try
    TServices<TPedidos>.New.Delete(Req.Params['id']);
    Res.Status(202);
  except
    Res.Status(404);
  end;
end;

procedure Registery(App: THorse);
begin
  App.Get('/pedidos', ListarTodos);
  App.Get('/pedidos/:id', ListarPor);
  App.Post('/pedidos', Novo);
  App.Delete('/pedidos/:id/excluir', Excluir);
end;

end.
