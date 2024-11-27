unit plugin.controller.schemas;

interface

uses System.JSON, System.SysUtils, System.Classes, System.Generics.Collections,
  plugin.controller.links, plugin.controller.databases, uUtils, System.StrUtils,
  plugin.datamodule, System.IOUtils, Vcl.FileCtrl, FileSearchUnit;

type
  TPluginTabelaParaAtualizar = class
    SqlDataAtualizar: string;
    TabelaOrigem: string;
    TabelaDestino: string;
    CaminhoArquivo: string;
    class function Novo(ASql, ATabelaOrigem, ATabelaDestino, ACaminhoArquivo: string): TPluginTabelaParaAtualizar;
  end;
  TPluginSchemas = class
  private
    FBaseOrigem: TPluginDatabases;
    FBaseDestino: TPluginDatabases;
    FLinks: TObjectList<TPluginLink>;
    FFilaAtualizacaoData: TObjectList<TPluginTabelaParaAtualizar>;
    FListaTabelasConsultadas: TObjectList<TPluginTabelaParaAtualizar>;
  public
    constructor Create;
    destructor Destroy; override;
    function PodeSalvar: boolean;
    procedure AddBaseOrigem(AJson: string);
    procedure AddBaseDestino(AJson: string);
    procedure AddLink(ALink: TPluginLink);
    procedure DeleteLink(ALink: TPluginLink);
    function Salvar: string;
    function SalvarArquivo: boolean;
    procedure LoadFromFile(AFile: string);
    function BaseOrigem: TPluginDatabases;
    function BaseDestino: TPluginDatabases;
    function LinksCount: integer;
    function GetLinkByTables(ATabelaOrigem, ATabelaDestino: string): TPluginLink;
    function CheckLinkByTables(ATabelaOrigem, ATabelaDestino: string): boolean;
    function GetIndexLinkByTables(ATabelaOrigem, ATabelaDestino: string): integer;
    function GetLink(AIndex: integer): TPluginLink;

    function Consultar(ADataConsultas: string): boolean;
    function Executar: boolean;
    function Atualizar: boolean;
    function Mover: boolean;
    function MoverArquivoAtualizado: boolean;

    procedure FilaAtualizacaoDatas(ATabelaAtualizada: TPluginTabelaParaAtualizar);

    function TesteSelect: string;

    class function Novo(AFile: string): TPluginSchemas;
  end;

implementation

{ TPluginSchemas }

procedure TPluginSchemas.AddBaseDestino(AJson: string);
begin
  FBaseDestino := TPluginDatabases.Create(AJson);
end;

procedure TPluginSchemas.AddBaseOrigem(AJson: string);
begin
  FBaseOrigem := TPluginDatabases.Create(AJson);
end;

procedure TPluginSchemas.AddLink(ALink: TPluginLink);
begin
  if not CheckLinkByTables(ALink.TabelaOrigem, ALink.TabelaDestino) then
    FLinks.Add(ALink)
  else GetLinkByTables(ALink.TabelaOrigem, ALink.TabelaDestino).LoadByJson(ALink.Salvar);
end;

function TPluginSchemas.BaseDestino: TPluginDatabases;
begin
  Result := FBaseDestino;
end;

function TPluginSchemas.BaseOrigem: TPluginDatabases;
begin
  Result := FBaseOrigem;
end;

constructor TPluginSchemas.Create;
begin
  FLinks := TObjectList<TPluginLink>.Create;
  FListaTabelasConsultadas := TObjectList<TPluginTabelaParaAtualizar>.Create;
  FFilaAtualizacaoData := TObjectList<TPluginTabelaParaAtualizar>.Create;
end;

procedure TPluginSchemas.DeleteLink(ALink: TPluginLink);
var
  lIndexLink: integer;
begin
  if CheckLinkByTables(ALink.TabelaOrigem, ALink.TabelaDestino) then
  begin
    lIndexLink := GetIndexLinkByTables(ALink.TabelaOrigem, ALink.TabelaDestino);
    //FLinks[lIndexLink].Free;
    FLinks.Delete(lIndexLink);
  end;
end;

destructor TPluginSchemas.Destroy;
begin
  if Assigned(FBaseOrigem) then
    FBaseOrigem.Free;
  if Assigned(FBaseDestino) then
    FBaseDestino.Free;
  FLinks.Free;
  FListaTabelasConsultadas.Free;
  FFilaAtualizacaoData.Free;
  inherited;
end;

procedure TPluginSchemas.FilaAtualizacaoDatas(ATabelaAtualizada: TPluginTabelaParaAtualizar);
begin
  FFilaAtualizacaoData.Add(TPluginTabelaParaAtualizar.Novo(ATabelaAtualizada.SqlDataAtualizar,
    ATabelaAtualizada.TabelaOrigem, ATabelaAtualizada.TabelaDestino, ATabelaAtualizada.CaminhoArquivo));
end;

function TPluginSchemas.GetLink(AIndex: integer): TPluginLink;
begin
  Result := FLinks[AIndex];
end;

function TPluginSchemas.GetIndexLinkByTables(ATabelaOrigem,
  ATabelaDestino: string): integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FLinks.Count - 1 do
  begin
    if (FLinks[I].TabelaOrigem = ATabelaOrigem) and (FLinks[I].TabelaDestino = ATabelaDestino) then
    begin
      Result := I;
      break;
    end;
  end;
end;

function TPluginSchemas.CheckLinkByTables(ATabelaOrigem,
  ATabelaDestino: string): boolean;
begin
  Result := Assigned(GetLinkByTables(ATabelaOrigem, ATabelaDestino));
end;

function TPluginSchemas.Consultar(ADataConsultas: string): boolean;
var
  lConexaoOrigem: TdmConexao;
  lSqlAtualizaDatas, lCaminhoArquivo: string;
  I: Integer;
begin
  Result := False;
  FListaTabelasConsultadas.Clear;
  FFilaAtualizacaoData.Clear;
  //Conectar banco origem
  lConexaoOrigem := TdmConexao.Create(nil);
  try
    lConexaoOrigem.ConectarOrigem(FBaseOrigem.Salvar);
    if lConexaoOrigem.OrigemConectado then
    begin
      //Montar SQLs
      for I := 0 to FLinks.Count - 1 do
      begin
        lSqlAtualizaDatas := FLinks[I].AtualizarDataConsulta(ADataConsultas);
        if lConexaoOrigem.ConsultarESalvar(FLinks[I].GetSelect,
                                           FLinks[I].TabelaOrigem,
                                           LerJson(FBaseOrigem.Salvar, 'nome'),
                                           FLinks[I].TabelaDestino,
                                           LerJson(FBaseDestino.Salvar, 'nome'),
                                           lCaminhoArquivo) then
        begin
          if not (lSqlAtualizaDatas.IsEmpty) then
            FListaTabelasConsultadas.Add(TPluginTabelaParaAtualizar.Novo(lSqlAtualizaDatas, FLinks[I].TabelaOrigem, FLinks[I].TabelaDestino, lCaminhoArquivo))
        end;
      end;
      Result := True;
    end;
  finally
    lConexaoOrigem.Free;
  end;
end;

function TPluginSchemas.Executar: boolean;
var
  lConexaoDestino: TdmConexao;
  I: Integer;
  O: Integer;
begin
  //Conectar banco origem
  lConexaoDestino := TdmConexao.Create(nil);
  try
    lConexaoDestino.ConectarDestino(FBaseDestino.Salvar);
    if lConexaoDestino.DestinoConectado then
    begin
      //Montar SQLs
      for I := 0 to FLinks.Count - 1 do
      begin
        if not (lConexaoDestino.ExecutarDestino(FLinks[I].GetInsert,
                                                FLinks[I].Salvar,
                                                FLinks[I].TabelaOrigem,
                                                LerJson(FBaseOrigem.Salvar, 'nome'),
                                                FLinks[I].TabelaDestino,
                                                LerJson(FBaseDestino.Salvar, 'nome'))) then
        begin
          Result := False;
          Break;
        end else
        begin
          for O := 0 to FListaTabelasConsultadas.Count - 1 do
          begin
            if (FListaTabelasConsultadas[O].TabelaOrigem = FLinks[I].TabelaOrigem) and
              (FListaTabelasConsultadas[O].TabelaDestino = FLinks[I].TabelaDestino) then
            begin
              FilaAtualizacaoDatas(FListaTabelasConsultadas[O]);
              Result := True;
              Break;
            end;
          end;
        end;
      end;
    end;
  finally
    lConexaoDestino.Free;
  end;
end;

function TPluginSchemas.Atualizar: boolean;
var
  lConexaoOrigem: TdmConexao;
  I: Integer;
begin
  Result := False;
  //Conectar banco origem
  lConexaoOrigem := TdmConexao.Create(nil);
  try
    lConexaoOrigem.ConectarOrigem(FBaseOrigem.Salvar);
    if lConexaoOrigem.OrigemConectado then
    begin
      //Atualizar datas
      for I := 0 to FFilaAtualizacaoData.Count - 1 do
      begin
        lConexaoOrigem.Execute(FFilaAtualizacaoData[I].SqlDataAtualizar, lConexaoOrigem.ConexaoOrigem);
      end;
      Result := True;
    end;
  finally
    lConexaoOrigem.Free;
  end;
end;

function TPluginSchemas.Mover: boolean;
var
  I: Integer;
  lListaArquivos: TFileSearch;
begin
  Result := False;
  lListaArquivos := TFileSearch.Create(DirConsultasPendentes,  '.json');
  try
    //Mover arquivos
    lListaArquivos.Execute;
    for I := 0 to lListaArquivos.GetFileList.Count -1 do
    begin
      TFile.Move(lListaArquivos.GetFileList[I],
                 IncludeTrailingPathDelimiter(DirConsultasHistorico)+ExtractFileName(lListaArquivos.GetFileList[I])+'_'+FormatDateTime('ddmmyyhhnnss',Now));
    end;
    Result := True;
  finally
    lListaArquivos.Free;
  end;
end;

function TPluginSchemas.MoverArquivoAtualizado: boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to FFilaAtualizacaoData.Count - 1 do
  begin
    TFile.Move(FFilaAtualizacaoData[I].CaminhoArquivo,
               IncludeTrailingPathDelimiter(DirConsultasHistorico)+ExtractFileName(FFilaAtualizacaoData[I].CaminhoArquivo)+'_'+FormatDateTime('ddmmyyhhnnss',Now));
  end;
end;

class function TPluginSchemas.Novo(AFile: string): TPluginSchemas;
begin
  Result := TPluginSchemas.Create;
  Result.LoadFromFile(AFile);
end;

function TPluginSchemas.GetLinkByTables(ATabelaOrigem,
  ATabelaDestino: string): TPluginLink;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FLinks.Count - 1 do
  begin
    if (FLinks[I].TabelaOrigem = ATabelaOrigem) and (FLinks[I].TabelaDestino = ATabelaDestino) then
    begin
      Result := GetLink(I);
      break;
    end;
  end;
end;

function TPluginSchemas.LinksCount: integer;
begin
  Result := 0;
  if Assigned(FLinks) then
    Result := FLinks.Count;
end;

procedure TPluginSchemas.LoadFromFile(AFile: string);
var
  I: Integer;
  lLinks: TJSONArray;
begin
  AddBaseOrigem(LerJsonFromJson(LerJsonFromFile(AFile), 'bancoorigem'));
  AddBaseDestino(LerJsonFromJson(LerJsonFromFile(AFile), 'bancodestino'));
  lLinks := TJSONObject.ParseJSONValue(LerJsonArray(LerJsonFromFile(AFile), 'links')) as TJSONArray;
  try
    for I := 0 to lLinks.Count - 1 do
    begin
      FLinks.Add(TPluginLink.Novo(lLinks.Items[I].ToJson));
    end;
  finally
    lLinks.Free;
  end;
end;

function TPluginSchemas.PodeSalvar: boolean;
var
  I: integer;
begin
  Result := True;
  if not (Assigned(FBaseOrigem)) then
  begin
    ShowWarning('Base de origem não encontrada');
    Exit(False);
  end;
  if not (Assigned(FBaseDestino)) then
  begin
    ShowWarning('Base de destino não encontrada');
    Exit(False);
  end;
  if FLinks.Count = 0 then
  begin
    ShowWarning('Nenhum link entre as tabelas dos bancos de dados foi encontrado');
    Exit(False);
  end;
end;

function TPluginSchemas.Salvar: string;
var
  vJsonResposta: TJSONObject;
  vJsonRespostaArray: TJSONArray;
  I: integer;
begin
  try
    vJsonResposta := TJSONObject.Create
      .AddPair('bancoorigem', TJSONObject.ParseJSONValue(FBaseOrigem.Salvar) as TJSONObject)
      .AddPair('bancodestino', TJSONObject.ParseJSONValue(FBaseDestino.Salvar) as TJSONObject);

    vJsonRespostaArray := TJSONArray.Create;
    for I := 0 to FLinks.Count - 1 do
    begin
      if Assigned(FLinks.Items[I]) then
        vJsonRespostaArray.Add(TJSONObject.ParseJSONValue(FLinks.Items[I].Salvar) as TJSONObject);
    end;
    vJsonResposta.AddPair('links', vJsonRespostaArray);
    Result := vJsonResposta.ToJSON;
  finally
    vJsonResposta.Free;
  end;
end;

function TPluginSchemas.SalvarArquivo: boolean;
var
  lNomeArquivo, lDiretorio: string;
begin
  Result := False;
  if PodeSalvar then
  begin
    lNomeArquivo := LerJson(BaseOrigem.Salvar, 'nome')+'_'+LerJson(BaseDestino.Salvar, 'nome');
    lDiretorio := IncludeTrailingPathDelimiter(DirSchemas)+lNomeArquivo+'.json';
    if FileExists(lDiretorio) then
      if not (ShowQuestion('Deseja substituir o registro "'+lNomeArquivo+'" existente?')) then
        Exit(False);
    GravarArrayJsonToFile(Salvar, lDiretorio);
    Result := True;
  end;
end;

function TPluginSchemas.TesteSelect: string;
var
  I: Integer;
begin
  for I := 0 to FLinks.Count - 1 do
  begin
    Result := Result + FLinks[I].GetSelect + sLineBreak;
  end;
end;

{ TPluginTabelaParaAtualizar }

class function TPluginTabelaParaAtualizar.Novo(ASql, ATabelaOrigem, ATabelaDestino, ACaminhoArquivo: string): TPluginTabelaParaAtualizar;
begin
  Result := TPluginTabelaParaAtualizar.Create;
  Result.SqlDataAtualizar := ASql;
  Result.TabelaOrigem := ATabelaOrigem;
  Result.TabelaDestino := ATabelaDestino;
  Result.CaminhoArquivo := ACaminhoArquivo;
end;

end.
