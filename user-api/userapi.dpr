program userapi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.cors,
  Horse.jhonson,
  System.SysUtils,
  userapi.backend.model.entity.usuarios in 'src\model\entity\userapi.backend.model.entity.usuarios.pas',
  userapi.backend.controller in 'src\controller\userapi.backend.controller.pas',
  useapi.backend.resource.autorizacao in 'src\resource\useapi.backend.resource.autorizacao.pas',
  commons.backend.connect in '..\commons\commons.backend.connect.pas',
  commons.backend.services in '..\commons\commons.backend.services.pas',
  userapi.backend.utils in 'src\utils\userapi.backend.utils.pas',
  userapi.backend.dto.usuario in 'src\dto\userapi.backend.dto.usuario.pas';

procedure IniciarHorse;
var
  lApp: THorse;
  lPort: Integer;
begin
  {$IFDEF MSWINDOWS}
  lPort := 9000;
  {$ELSE}
  lPort := StrToInt(GetEnvironmentVariable('PORT'));
  {$ENDIF}

  lApp := THorse.Create;
  lApp
    .use(cors)
    .use(jhonson);

  userapi.backend.controller.Registery(lApp);

  lApp.Listen(lPort,
  procedure (Horse:THorse)
  begin
    System.Writeln(Format('Servidor de autenticacao rodando, porta %d',[Horse.Port]));
    System.Readln;
  end);
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  IniciarHorse;
end.
