program cadastroapi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.cors,
  Horse.jhonson,
  System.SysUtils,
  cadastroapi.backend.model.entity.pessoa in 'src\model\entity\cadastroapi.backend.model.entity.pessoa.pas',
  cadastroapi.backend.model.entity.contatos in 'src\model\entity\cadastroapi.backend.model.entity.contatos.pas',
  cadastroapi.backend.model.entity.endereco in 'src\model\entity\cadastroapi.backend.model.entity.endereco.pas',
  cadastroapi.backend.model.entity.cliente in 'src\model\entity\cadastroapi.backend.model.entity.cliente.pas',
  cadastroapi.backend.model.entity.produto in 'src\model\entity\cadastroapi.backend.model.entity.produto.pas',
  cadastroapi.backend.model.entity.categoria in 'src\model\entity\cadastroapi.backend.model.entity.categoria.pas',
  cadastroapi.backend.model.enums in 'src\model\cadastroapi.backend.model.enums.pas',
  cadastroapi.backend.controller.cliente in 'src\controller\cadastroapi.backend.controller.cliente.pas',
  cadastroapi.backend.controller.categoria in 'src\controller\cadastroapi.backend.controller.categoria.pas',
  cadastroapi.backend.controller.produto in 'src\controller\cadastroapi.backend.controller.produto.pas',
  Commons.Middleware.Authentication in '..\commons\Commons.Middleware.Authentication.pas',
  commons.backend.services in '..\commons\commons.backend.services.pas',
  commons.backend.connect in '..\commons\commons.backend.connect.pas',
  cadastroapi.backend.utils in 'src\utils\cadastroapi.backend.utils.pas',
  cadastroapi.backend.dto.categoria in 'src\dto\cadastroapi.backend.dto.categoria.pas',
  cadastroapi.backend.dto.cliente in 'src\dto\cadastroapi.backend.dto.cliente.pas',
  cadastroapi.backend.dto.contato in 'src\dto\cadastroapi.backend.dto.contato.pas',
  cadastroapi.backend.dto.endereco in 'src\dto\cadastroapi.backend.dto.endereco.pas',
  cadastroapi.backend.dto.produto in 'src\dto\cadastroapi.backend.dto.produto.pas';

procedure IniciarHorse;
var
  lApp: THorse;
  lPort: Integer;
begin
  {$IFDEF MSWINDOWS}
  lPort := 9001;
  ServerAutentication := 'http://localhost:9000/usuarios';
  {$ELSE}
  lPort := StrToInt(GetEnvironmentVariable('PORT'));
  ServerAutentication := GetEnvironmentVariable('AUTENTICATION_HOST');
  {$ENDIF}

  lApp := THorse.Create;
  lApp
    .use(cors)
    .use(jhonson)
    .use(AuthHandler);

  cadastroapi.backend.controller.cliente.Registery(lApp);
  cadastroapi.backend.controller.categoria.Registery(lApp);
  cadastroapi.backend.controller.produto.Registery(lApp);

  lApp.Listen(lPort,
  procedure (Horse: THorse)
  begin
    System.Writeln(Format('Servidor de cadastro rodando, porta %d',[lPort]));
    System.Readln;
  end);
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  IniciarHorse;
end.
