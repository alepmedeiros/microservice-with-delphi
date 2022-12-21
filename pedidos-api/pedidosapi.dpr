program pedidosapi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.cors,
  Horse.jhonson,
  System.SysUtils,
  commons.backend.connect in '..\commons\commons.backend.connect.pas',
  commons.backend.services in '..\commons\commons.backend.services.pas',
  Commons.Middleware.Authentication in '..\commons\Commons.Middleware.Authentication.pas',
  pedidosapi.backend.model.entity.pedido in 'src\model\entity\pedidosapi.backend.model.entity.pedido.pas',
  pedidosapi.backend.model.entity.pedidoitens in 'src\model\entity\pedidosapi.backend.model.entity.pedidoitens.pas',
  pedidosapi.backend.dto.pedido in 'src\dto\pedidosapi.backend.dto.pedido.pas',
  pedidosapi.backend.dto.pedidoitens in 'src\dto\pedidosapi.backend.dto.pedidoitens.pas',
  pedidosapi.backend.controller.pedido in 'src\controller\pedidosapi.backend.controller.pedido.pas',
  pedidosapi.bachend.auth.interfaces in 'src\auth\pedidosapi.bachend.auth.interfaces.pas',
  pedidosapi.bachend.auth.impl.httpclient in 'src\auth\impl\pedidosapi.bachend.auth.impl.httpclient.pas',
  pedidosapi.backend.utils in 'src\utils\pedidosapi.backend.utils.pas';

procedure IniciarHorse;
var
  lApp: THorse;
  lPort: Integer;
begin
  {$IFDEF MSWINDOWS}
  lPort := 9002;
  {$ELSE}
  lPort := StrToInt(GetEnvironmentVariable('PORT'));
  {$ENDIF}

  ServerAutentication := pedidosapi.backend.utils.AUTENTICACAO.ToBase;

  lApp := THorse.Create;
  lApp
    .use(cors)
    .use(jhonson)
    .use(AuthHandler);

  pedidosapi.backend.controller.pedido.Registery(lApp);

  lApp.Listen(lPort,
  procedure (Horse:THorse)
  begin
    System.Writeln(Format('Servidor de pedidos rodando, porta %d',[Horse.Port]));
    System.Readln;
  end);
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  IniciarHorse;
end.
