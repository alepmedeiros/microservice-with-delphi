unit cadastroapi.backend.controller.produto;

interface

uses
  Horse,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  commons.backend.services,
  cadastroapi.backend.utils,
  cadastroapi.backend.dto.categoria,
  cadastroapi.backend.dto.produto,
  cadastroapi.backend.model.entity.categoria,
  cadastroapi.backend.model.entity.produto;

procedure Registery(App: THorse);

implementation

function CarregaListaProdutoDTO(Value: TObjectList<TProduto>): TObjectList<TProdutoDTO>;
var
  lProduto: TProduto;
begin
  Result := TObjectList<TProdutoDTO>.Create;
  for lProduto in Value do
    Result.Add(lProduto.Convert(TServices<TCategoria>.New.Find(lProduto.Categoria)));
end;

procedure ListarTodos(Req: THorseRequest; Res: THorseResponse);
var
  lDto: TObjectList<TProdutoDTO>;
  lProdutos: TObjectList<TProduto>;
begin
  try
    lProdutos := TServices<TProduto>.New.FindAll;

    LDTO := CarregaListaProdutoDTO(lProdutos);

    Res.Send<TJSONArray>(TProdutoDTO.New.ListToJsonArray(lDto));
  except
    Res.Status(404);
  end;
end;

procedure ListarPorCodigo(Req: THorseRequest; Res: THorseResponse);
var
  lProduto: TProduto;
begin
  lProduto := TServices<TProduto>.New.Find(Req.Params['id'].ToInteger);
  Res.Send<TJSONObject>(lProduto.Convert(TServices<TCategoria>.New.Find(lProduto.Categoria)).ToJson);
end;

procedure ListarPorCategoria(Req: THorseRequest; Res: THorseResponse);
var
  lDTO: TObjectList<TProdutoDTO>;
  lProdutos: TObjectList<TProduto>;
begin
  lProdutos := TServices<TProduto>.New
                .FindWhere('id_categoria',Req.Params['categoria'].ToInteger);
  lDTO := CarregaListaProdutoDTO(lProdutos);

  Res.Send<TJSONArray>(TProdutoDTO.New.ListToJsonArray(lDto));
end;

procedure NovoProduto(Req: THorseRequest; Res: THorseResponse);
var
  lDTO: TProdutoDTO;
  lCategoria: TCategoria;
begin
  lDTO := TProdutoDTO.New.JsonToObject(Req.Body);
  lCategoria := TServices<TCategoria>.New.Find(ldto.Categoria.Id);
  if lCategoria.Descricao.IsEmpty then begin
    lCategoria := TServices<TCategoria>.New.Insert(lDTO.Categoria.Convert);
    lDTO.Categoria.Id := lCategoria.Id;
  end;
  lDTo.Id := TServices<TProduto>.New.Insert(lDTO.Convert).Id;
  Res.Send<TJSONObject>(ldto.ToJson);
end;

procedure AtualizarEstoque(Req: THorseRequest; Res: THorseResponse);
var
  lProduto: TProduto;
  lDTO: TProdutoDTO;
begin
  try
    lDTO := TProdutoDTO.New.JsonToObject(Req.Body);
    lProduto := TServices<TProduto>.New.Find(lDTO.Id);
    lProduto.EstoqueAtual := (lProduto.EstoqueAtual - lDTO.EstoqueAtual);
    TServices<TProduto>.New.Update(lProduto);
    Res.Status(202);
  except
    Res.Send('Não foi possivel atualizar o estoque do produto atual').Status(404);
  end;
end;

procedure Excluir(Req: THorseRequest; Res: THorseResponse);
begin
  try
    TServices<TProduto>.New.Delete(Req.Params['id']);
    Res.Status(202);
  except
    Res.Status(404);
  end;
end;

procedure Registery(App: THorse);
begin
  App.Get('/produtos', ListarTodos);
  App.Get('/produtos/:id', ListarPorCodigo);
  App.Get('/produtos/:categoria/categoria', ListarPorCategoria);
  App.Post('/produtos', NovoProduto);
  App.Post('/produtos/atualziarestoque', AtualizarEstoque);
  App.Delete('/produtos/:id/excluir',Excluir);
end;

end.
