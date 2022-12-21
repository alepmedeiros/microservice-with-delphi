unit pedidosapi.bachend.auth.impl.httpclient;

interface

uses
  RestRequest4D,
  pedidosapi.bachend.auth.interfaces,
  Data.DB;

type
  THttpClient = class(TInterfacedObject, iHttpClient)
  private
    FReq : IRequest;
    FResp : IResponse;
    FContent : String;
    const
        CONTENT_TYPE = 'Content-Type';
        APPLICATION_JSON = 'application/json';
  public
    constructor Create(BaseURL: String);
    destructor Destroy; override;
    class function New(BaseURL: String): iHttpClient;
    function Token(Value: String): iHttpClient;
    function Headers(aKey: String; aValue: String): iHttpClient;
    function Get(Url: String): iHttpClient;
    function GetAll(Url: String): iHttpClient;
    function Post(Url: String): iHttpClient;
    function Put(Url: String): iHttpClient;
    function Delete(Url: String): iHttpClient;
    function Params(aKey: String; aValue: String): iHttpClient;
    function Body(Value: String): iHttpClient;
    function DataSet(Value: TDataSet): iHttpClient;
    function Content(var Value: String): iHttpClient;
  end;

implementation

function THttpClient.Body(Value: String): iHttpClient;
begin
  Result := Self;
  FReq.AddBody(Value);
end;

function THttpClient.Content(var Value: String): iHttpClient;
begin
  Result := Self;
  Value := FResp.Content;
end;

constructor THttpClient.Create(BaseURL: String);
begin
  FReq := TRequest.New.BaseURL(BaseURL);
end;

function THttpClient.DataSet(Value: TDataSet): iHttpClient;
begin
  Result := Self;
  FReq.DataSetAdapter(Value);
end;

function THttpClient.Delete(Url: String): iHttpClient;
begin
  Result := Self;
  FResp := FReq
    .Resource(Url)
    .Delete;
end;

destructor THttpClient.Destroy;
begin

  inherited;
end;

function THttpClient.Get(Url: String): iHttpClient;
begin
  Result := Self;
  FResp := FReq
    .Resource(Url)
    .Get;
end;

function THttpClient.GetAll(Url: String): iHttpClient;
begin
  Result := Self;
  FResp := FReq
    .Resource(Url)
    .Get;
end;

function THttpClient.Headers(aKey, aValue: String): iHttpClient;
begin
  Result := Self;
  FReq.AddHeader(aKey,aValue);
end;

class function THttpClient.New(BaseURL: String): iHttpClient;
begin
  Result := Self.Create(BaseURL);
end;

function THttpClient.Params(aKey, aValue: String): iHttpClient;
begin
  Result := Self;
  FReq.AddUrlSegment(aKey, aValue);
end;

function THttpClient.Post(Url: String): iHttpClient;
begin
  Result := Self;
  FResp := FReq
    .Resource(Url)
    .AddHeader(CONTENT_TYPE,APPLICATION_JSON)
    .Post;
end;

function THttpClient.Put(Url: String): iHttpClient;
begin
  Result := Self;
  FResp := FReq
    .Resource(Url)
    .AddHeader(CONTENT_TYPE,APPLICATION_JSON)
    .Put;
end;

function THttpClient.Token(Value: String): iHttpClient;
begin
  Result := Self;
  FReq.TokenBearer(Value);
end;

end.
