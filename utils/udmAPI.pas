unit udmAPI;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdMultipartFormData;

type
  TdmAPI = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FHttp: TIdHTTP;
    IdSSL: TIdSSLIOHandlerSocketOpenSSL;
    FParams: TIdMultipartFormDataStream;
    function TratarRetorno(aText: string): string;
  public
    procedure AcceptCharSet(const AValue: string);
    procedure ContentEncoding(const AValue: string);
    procedure ContentType(const AValue: string);
    procedure AddParams(AParam, AValue: string);
    procedure AddParamsFile(AParam, AValue, AType: string);
    procedure SetBasicAuth(AUsuario, ASenha: string);

    function Post(AUrl: string): string;
    function Get(AUrl: string): string;
  end;

var
  dmAPI: TdmAPI;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmAPI.AcceptCharSet(const AValue: string);
begin
  FHttp.Request.AcceptCharSet := AValue;
end;

procedure TdmAPI.AddParams(AParam, AValue: string);
begin
  FParams.AddFormField(AParam, AValue);
end;

procedure TdmAPI.AddParamsFile(AParam, AValue, AType: string);
begin
  FParams.AddFile(AParam, AValue, AType);
end;

procedure TdmAPI.ContentEncoding(const AValue: string);
begin
  FHttp.Request.ContentEncoding := AValue;
end;

procedure TdmAPI.ContentType(const AValue: string);
begin
  FHttp.Request.ContentType := AValue;
end;

procedure TdmAPI.DataModuleCreate(Sender: TObject);
begin
  FHttp := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FParams := TIdMultipartFormDataStream.Create;
  IdSSL.SSLOptions.Method := sslvSSLv23;
  IdSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdSSL.SSLOptions.Mode := sslmBoth;
  FHttp.HandleRedirects := True;
  FHttp.IOHandler := IdSSL;
  FHttp.HTTPOptions := [hoKeepOrigProtocol];
  FHttp.AllowCookies := True;
end;

procedure TdmAPI.DataModuleDestroy(Sender: TObject);
begin
  FHttp.Free;
  IdSSL.Free;
  FParams.Free;
end;

function TdmAPI.Get(AUrl: string): string;
begin
  try
    Result := TratarRetorno(FHttp.Get(AUrl));
    FHttp.Disconnect;
  except
    on e: exception do
    begin
      Result := 'Error: '+e.Message;
    end;
  end;
end;

function TdmAPI.Post(AUrl: string): string;
var
  lStream: TStringStream;
begin
  lStream := TStringStream.Create('');
  try
    FHttp.Post(AUrl, FParams, lStream);
    FHttp.Disconnect;
    Result := TratarRetorno(lStream.DataString);
  finally
    lStream.Free;
  end;
end;

procedure TdmAPI.SetBasicAuth(AUsuario, ASenha: string);
begin
  FHttp.Request.BasicAuthentication := True;
  FHttp.Request.Username := AUsuario;
  FHttp.Request.Password := ASenha;
end;

function TdmAPI.TratarRetorno(aText: string): string;
var
  I, Y: integer;
begin

  Result := '';
  I := Pos('{', aText);
  Y := Length(aText);
  while aText[Y] <> '}' do
  begin
    Dec(Y);
    if Y < 0 then
      Exit(Result);
  end;
  if aText[Y] = '}' then
    Result := Copy(aText, I, Y) else
  Result := Copy(aText, I, Y-1);
end;

end.
