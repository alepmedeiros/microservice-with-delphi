unit cadastroapi.backend.controller.categoria;

interface

uses
  Horse,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  commons.backend.services,
  cadastroapi.backend.dto.categoria,
  cadastroapi.backend.model.entity.categoria,
  cadastroapi.backend.utils;

procedure Registery(App: THorse);

implementation

procedure ListarTodos(Req: THorseRequest; Res: THorseResponse);
var
  lDTO: TObjectList<TCategoriaDTO>;
  lCategoria: TObjectList<TCategoria>;
begin
  lCategoria := TServices<TCategoria>.New.FindAll;
  lDTO := TCategoria.New.Convert(lCategoria);
  Res.Send<TJSONArray>(TCategoriaDTO.New.ListToJsonArray(lDTO));
end;

procedure ListarPorId(Req: THorseRequest; Res: THorseResponse);
var
  lCategoria: TCategoriaDTO;
begin
  lCategoria := TServices<TCategoria>.New.Find(Req.Params['id'].ToInteger).Convert;
  Res.Send<TJSONObject>(lCategoria.ToJson);
end;

procedure NovaCategoria(Req: THorseRequest; Res: THorseResponse);
var
  lCategoria: TCategoriaDTO;
begin
  try
    lCategoria := TCategoriaDTO.New.JsonToObject(Req.Body);
    Res.Send<TJSONObject>(TServices<TCategoria>.New.Insert(lCategoria.Convert).Convert.ToJson);
  except
    Res.Status(404);
  end;
end;

procedure ExcluirCategoria(Req: THorseRequest; Res: THorseResponse);
begin
  try
    TServices<TCategoria>.New.Delete(Req.Params['id'].ToInteger);
    Res.Status(204);
  except
    Res.Status(401);
  end;
end;

procedure Registery(App: THorse);
begin
  App.Get('/categorias', ListarTodos);
  App.Get('/categorias/:id', ListarPorId);
  App.Post('/categorias', NovaCategoria);
  App.Delete('/categorias/:id/excluir', ExcluirCategoria);
end;

end.
