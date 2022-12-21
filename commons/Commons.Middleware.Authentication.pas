unit Commons.Middleware.Authentication;

interface

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Horse.Commons,
  RestRequest4D;

type
  TValidationLogin = reference to function (const aUser, aPasswor: String): Boolean;

var
  ServerAutentication: String;

function AuthHandler: THorseCallback; 
procedure Middleware(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

function AuthHandler: THorseCallback;
begin
  Result := Middleware;
end;

procedure Middleware(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lToken: String;
  lServer: String;
  lReq : IRequest;
  lResp : IResponse;
begin
  //http%3A%2F%2Flocalhost%3A9000
  //Req.Headers[LowerCase('servidor')].Replace('%3A',':',[rfReplaceAll,rfIgnoreCase]).Replace('%2F','/',[rfReplaceAll,rfIgnoreCase]);
  lToken := Req.Headers[LowerCase('Authorization')].Replace('bearer ', '', [rfIgnoreCase]);
  lServer := ServerAutentication;
  lReq := TRequest.new.BaseURL(lServer);
  if not lToken.Trim.IsEmpty then
  begin
    try
      lReq.Resource('autorizado').TokenBearer(lToken).Get;
      Next;
    except
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('error','Token inválido')).Status(401);
      raise EHorseCallbackInterrupted.Create;
    end;
    Exit;
  end;
  Res.Send<TJSONObject>(TJSONObject.Create.AddPair('error','Token inválido')).Status(401);
  raise EHorseCallbackInterrupted.Create;
  Next;
end;

end.
