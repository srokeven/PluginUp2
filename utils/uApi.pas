unit uApi;

interface

uses System.SysUtils, System.Classes, REST.Types, REST.Client, REST.Json, IPPeerCommon,IPPeerClient,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, System.NetEncoding,
  REST.Authenticator.Basic;

type
  TApi = class
    private
      RestCliente: TRESTClient;
      RestRequisicao: TRESTRequest;
      RestResposta: TRESTResponse;
      FUrl: string;
      FResource: string;
      FRespostaContentType: string;
      FClienteAccept: string;
      FClienteCharset: string;
      FMetodoHTTP: TRESTRequestMethod;
      FBodyJson: string;
      FBasicAuthPassword: string;
      FToken: string;
      FBasicAuthUsername: string;
      procedure SetUrl(const Value: string);
      procedure SetResource(const Value: string);
      procedure SetClienteAccept(const Value: string);
      procedure SetClienteCharset(const Value: string);
      procedure SetRespostaContentType(const Value: string);
      procedure SetMetodoHTTP(const Value: TRESTRequestMethod);
      function ParseErro(AError: string): string;
      procedure SetBodyJson(const Value: string);
      procedure SetBasicAuthPassword(const Value: string);
      procedure SetBasicAuthUsername(const Value: string);
      procedure SetToken(const Value: string);
    public
      constructor Create;
      destructor Destroy; override;
      property Url: string read FUrl write SetUrl;
      property Resource: string read FResource write SetResource;
      property ClienteAccept: string read FClienteAccept write SetClienteAccept;
      property ClienteCharset: string read FClienteCharset write SetClienteCharset;
      property RespostaContentType: string read FRespostaContentType write SetRespostaContentType;
      property MetodoHTTP: TRESTRequestMethod read FMetodoHTTP write SetMetodoHTTP;
      property BodyJson: string read FBodyJson write SetBodyJson;
      property Token: string read FToken write SetToken;
      property BasicAuthUsername: string read FBasicAuthUsername write SetBasicAuthUsername;
      property BasicAuthPassword: string read FBasicAuthPassword write SetBasicAuthPassword;
      procedure SetJWTAuthentication;
      procedure SetBasicAuthentication;
      procedure AddFile(AParam, AFile: string);
      procedure AddParametros(AParam, AValor: string);
      //Metodos Get
      function Get: string; overload;
      class function Get(AUrl, AResource: string): string; overload;
      class function Get(AUrl, AResource, AUsername, APassword: string): string; overload;
      class function Get(AUrl, AResource, AToken: string): string; overload;
      //Metodos Post
      function Post: string; overload;
      class function Post(AUrl, AResource, AJsonBody: string): string; overload;
      class function Post(AUrl, AResource, AJsonBody, AUsername, APassword: string): string; overload;
      class function Post(AUrl, AResource, AJsonBody, AToken: string): string; overload;
  end;

implementation

{ TApi }

procedure TApi.AddFile(AParam, AFile: string);
begin
  RestRequisicao.AddFile(AParam, AFile, TRESTContentType.ctAPPLICATION_XML);
end;

procedure TApi.AddParametros(AParam, AValor: string);
begin
  RestRequisicao.AddParameter(AParam, AValor, pkGETorPOST);
end;

constructor TApi.Create;
begin
  RestCliente := TRESTClient.Create('');
  RestRequisicao := TRESTRequest.Create(nil);
  RestResposta := TRESTResponse.Create(nil);
  RestCliente.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestCliente.AcceptCharset := 'utf-8, *;q=0.8';
  RestCliente.RaiseExceptionOn500 := False;
  RestRequisicao.Client := RestCliente;
  RestRequisicao.Method := rmGET;
  RestRequisicao.Response := RestResposta;
  RestResposta.ContentType := 'application/json';
end;

destructor TApi.Destroy;
begin
  RestCliente.Free;
  RestRequisicao.Free;
  RestResposta.Free;
  inherited;
end;

class function TApi.Get(AUrl, AResource: string): string;
var
  Api: TApi;
begin
  Api := TApi.Create;
  try
    Api.Url := AUrl;
    Api.Resource := AResource;
    Result := Api.Get;
  finally
    Api.Free;
  end;
end;

class function TApi.Get(AUrl, AResource, AUsername, APassword: string): string;
var
  Api: TApi;
begin
  Api := TApi.Create;
  try
    Api.Url := AUrl;
    Api.Resource := AResource;
    Api.BasicAuthUsername := AUsername;
    Api.BasicAuthPassword := APassword;
    Api.SetBasicAuthentication;
    Result := Api.Get;
  finally
    Api.Free;
  end;
end;

class function TApi.Get(AUrl, AResource, AToken: string): string;
var
  Api: TApi;
begin
  Api := TApi.Create;
  try
    Api.Url := AUrl;
    Api.Resource := AResource;
    Api.Token := AToken;
    Api.SetJWTAuthentication;
    Result := Api.Get;
  finally
    Api.Free;
  end;
end;

function TApi.Get: string;
begin
  MetodoHTTP := rmGET;
  try
    RestRequisicao.Execute;
    Result := RestResposta.Content;
  except
    on e : exception do
      Result := ParseErro(e.Message);
  end;
end;

function TApi.ParseErro(AError: string): string;
var
  vJsonErro: TJSONObject;
begin
  vJsonErro := TJSONObject.Create;
  try
    vJsonErro.AddPair('error', AError);
    Result := vJsonErro.ToJSON;
  finally
    vJsonErro.Free;
  end;
end;

class function TApi.Post(AUrl, AResource, AJsonBody, AToken: string): string;
var
  Api: TApi;
begin
  Api := TApi.Create;
  try
    Api.Url := AUrl;
    Api.Resource := AResource;
    Api.Token := AToken;
    Api.BodyJson := AJsonBody;
    Api.SetJWTAuthentication;
    Result := Api.Post;
  finally
    Api.Free;
  end;
end;

class function TApi.Post(AUrl, AResource, AJsonBody: string): string;
var
  Api: TApi;
begin
  Api := TApi.Create;
  try
    Api.Url := AUrl;
    Api.Resource := AResource;
    Api.BodyJson := AJsonBody;
    Result := Api.Post;
  finally
    Api.Free;
  end;
end;

class function TApi.Post(AUrl, AResource, AJsonBody, AUsername, APassword: string): string;
var
  Api: TApi;
begin
  Api := TApi.Create;
  try
    Api.Url := AUrl;
    Api.Resource := AResource;
    Api.BodyJson := AJsonBody;
    Api.BasicAuthUsername := AUsername;
    Api.BasicAuthPassword := APassword;
    Api.SetBasicAuthentication;
    Result := Api.Post;
  finally
    Api.Free;
  end;
end;

function TApi.Post: string;
begin
  MetodoHTTP := rmPOST;
  try
    RestRequisicao.Execute;
    Result := RestResposta.Content;
  except
    on e : exception do
      Result := ParseErro(e.Message);
  end;
end;

procedure TApi.SetBasicAuthentication;
begin
  if not (FBasicAuthUsername.IsEmpty) then
    RestCliente.Authenticator := THTTPBasicAuthenticator.Create(FBasicAuthUsername, FBasicAuthPassword);
end;

procedure TApi.SetBasicAuthPassword(const Value: string);
begin
  FBasicAuthPassword := Value;
end;

procedure TApi.SetBasicAuthUsername(const Value: string);
begin
  FBasicAuthUsername := Value;
end;

procedure TApi.SetBodyJson(const Value: string);
begin
  FBodyJson := Value;
  RestRequisicao.AddBody(FBodyJson, TRESTContentType.ctAPPLICATION_JSON);
end;

procedure TApi.SetClienteAccept(const Value: string);
begin
  FClienteAccept := Value;
  RestCliente.Accept := FClienteAccept;
end;

procedure TApi.SetClienteCharset(const Value: string);
begin
  FClienteCharset := Value;
  RestCliente.AcceptCharset := FClienteCharset;
end;

procedure TApi.SetJWTAuthentication;
begin
  if not (FToken.IsEmpty) then
  begin
    RestRequisicao.Params.AddHeader('Authorization', 'Bearer ' + FToken);
    RestRequisicao.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  end;
end;

procedure TApi.SetMetodoHTTP(const Value: TRESTRequestMethod);
begin
  FMetodoHTTP := Value;
  RestRequisicao.Method := FMetodoHTTP;
end;

procedure TApi.SetResource(const Value: string);
begin
  FResource := Value;
  RestRequisicao.Resource := FResource;
end;

procedure TApi.SetRespostaContentType(const Value: string);
begin
  FRespostaContentType := Value;
  RestResposta.ContentType := FRespostaContentType;
end;

procedure TApi.SetToken(const Value: string);
begin
  FToken := Value;
end;

procedure TApi.SetUrl(const Value: string);
begin
  FUrl := Value;
  RestCliente.BaseURL := FUrl;
end;

end.
