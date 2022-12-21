unit pedidosapi.bachend.auth.interfaces;

interface

uses
  Data.DB;

type
  iHttpClient = interface
    function Token(Value : String) : iHttpClient;
    function Headers(aKey: String; aValue: String): iHttpClient;
    function Get(Url: String) : iHttpClient;
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

end.
