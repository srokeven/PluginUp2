unit plugin.controller.databases;

interface

uses uUtils, System.JSON, System.SysUtils;

type
  TPluginDatabases = class
  private
    FNome: string;
    FServidor: string;
    FPorta: string;
    FCaminho: string;
    FUsuario: string;
    FSenha: string;
    FTipo: integer;
    FSistema: string;
  public
    constructor Create(AJson: string);
    function Salvar: string;
    function SalvarArquivo: boolean;
  end;

implementation

{ TPluginDatabases }

constructor TPluginDatabases.Create(AJson: string);
begin
  FNome := LerJson(AJson, 'nome');
  FServidor := LerJson(AJson, 'servidor');
  FPorta := LerJson(AJson, 'porta');
  FCaminho := LerJson(AJson, 'caminho');
  FUsuario := LerJson(AJson, 'usuario');
  FSenha := LerJson(AJson, 'senha');
  FTipo := StrToIntDef(LerJson(AJson, 'tipo'),0);
  FSistema := LerJson(AJson, 'sistema');
end;

function TPluginDatabases.Salvar: string;
var
  vJsonResposta: TJSONObject;
begin
  try
    vJsonResposta := TJSONObject.Create
      .AddPair('nome', FNome)
      .AddPair('servidor', FServidor)
      .AddPair('porta', FPorta)
      .AddPair('caminho', FCaminho)
      .AddPair('usuario', FUsuario)
      .AddPair('senha', FSenha)
      .AddPair('tipo', FTipo.ToString)
      .AddPair('sistema', FSistema);
    Result := vJsonResposta.ToJSON;
  finally
    vJsonResposta.Free;
  end;
end;

function TPluginDatabases.SalvarArquivo: boolean;
var
  lNomeArquivo: string;
begin
  Result := False;
  lNomeArquivo := IncludeTrailingPathDelimiter(DirBancoDeDados)+LerJson(Salvar, 'nome').Replace(' ', '_')+'.json';
  if FileExists(lNomeArquivo) then
    if not (ShowQuestion('Deseja substituir o registro "'+LerJson(Salvar, 'nome')+'" existente?')) then
      Exit(False);
  GravarArrayJsonToFile(Salvar, lNomeArquivo);
  Result := True;
end;

end.
