unit plugin.datamodule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, uUtils, DataSet.Serialize, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  System.JSON, FireDAC.ConsoleUI.Wait;

type
  TdmConexao = class(TDataModule)
    ConexaoOrigem: TFDConnection;
    ConexaoDestino: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Conexao: TFDConnection;
    Scripts: TFDScript;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FQuantidadeUltimaConsulta: integer;

  public
    property QuantidadeUltimaConsulta: integer read FQuantidadeUltimaConsulta write FQuantidadeUltimaConsulta;
    procedure ConectarOrigem(AJson: string);
    procedure ConectarDestino(AJson: string);
    procedure Conectar(AJson: string);

    procedure DesconectarOrigem;
    procedure DesconectarDestino;
    procedure Desconectar;
    procedure DesconectarTodos;

    function OrigemConectado: boolean;
    function DestinoConectado: boolean;
    function Conectado: boolean;

    function ConsultarESalvar(ASelect, ATabelaOrigem, ABancoOrigem, ATabelaDestino,
      ABancoDestino: string; out OCaminhoArquivo: string): boolean;
    function ExecutarDestino(ASqlInsert, AEstrutura, ATabelaOrigem, ABancoOrigem,
      ATabelaDestino, ABancoDestino: string): boolean;

    function Select(ASQL: string): string; overload;
    function Select(AIndex: integer): string; overload;
    procedure Execute(ASQL: string; AConexao: TFDConnection); overload;
    procedure Execute(ASQL: array of string; AConexao: TFDConnection); overload;

    function GetScript(AIndex: integer):string;

    class function TestarConexao(AJson: string): boolean;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmConexao }

procedure TdmConexao.Conectar(AJson: string);
var
  lTempDataSet: TDataSet;
begin
  try
    Conexao.Params.Values['Server']    := LerJson(AJson, 'servidor');
    Conexao.Params.Values['Port']      := LerJson(AJson, 'porta');
    Conexao.Params.Values['Database']  := LerJson(AJson, 'caminho');
    Conexao.Params.Values['User_Name'] := LerJson(AJson, 'usuario');
    Conexao.Params.Values['Password']  := LerJson(AJson, 'senha');
    Conexao.Open;
    if Conexao.Connected then
    begin
      if LerJson(AJson, 'sistema') = 'MV' then
        Conexao.ExecSQL('select VERSIONDB from SYSINFO', lTempDataSet)
      else
      if LerJson(AJson, 'sistema') = 'PDV' then
        Conexao.ExecSQL('select VERSIONDB from SYSINFO where TYPEEXE = '+QuotedStr('PDV'), lTempDataSet)
      else
        Exit;
      if not lTempDataSet.IsEmpty then
      begin
        if LerJson(AJson, 'sistema') = 'MV' then
          if lTempDataSet.FieldByName('VERSIONDB').AsInteger < 184 then
            ShowWarning('A versão do banco de dados ('+lTempDataSet.FieldByName('VERSIONDB').AsString+') esta inferior ao mínimo necessário (184) para rodar o PluginUp2');
        if LerJson(AJson, 'sistema') = 'PDV' then
          if lTempDataSet.FieldByName('VERSIONDB').AsInteger < 101 then
            ShowWarning('A versão do banco de dados ('+lTempDataSet.FieldByName('VERSIONDB').AsString+') esta inferior ao mínimo necessário (184) para rodar o PluginUp2');
      end;
    end;
  except
    on E: exception do
    begin
      GravaLog('Erro ao tentar se conectar ao banco de dados: '+e.Message, 'log');
    end;
  end;
end;

procedure TdmConexao.ConectarDestino(AJson: string);
begin
  try
    ConexaoDestino.Params.Values['Server']    := LerJson(AJson, 'servidor');
    ConexaoDestino.Params.Values['Port']      := LerJson(AJson, 'porta');
    ConexaoDestino.Params.Values['Database']  := LerJson(AJson, 'caminho');
    ConexaoDestino.Params.Values['User_Name'] := LerJson(AJson, 'usuario');
    ConexaoDestino.Params.Values['Password']  := LerJson(AJson, 'senha');
    ConexaoDestino.Open;
  except
    on E: exception do
    begin
      GravaLog('Erro ao tentar se conectar ao banco de dados de destino: '+e.Message, 'log');
    end;
  end;
end;

procedure TdmConexao.ConectarOrigem(AJson: string);
begin
  try
    ConexaoOrigem.Params.Values['Server']    := LerJson(AJson, 'servidor');
    ConexaoOrigem.Params.Values['Port']      := LerJson(AJson, 'porta');
    ConexaoOrigem.Params.Values['Database']  := LerJson(AJson, 'caminho');
    ConexaoOrigem.Params.Values['User_Name'] := LerJson(AJson, 'usuario');
    ConexaoOrigem.Params.Values['Password']  := LerJson(AJson, 'senha');
    ConexaoOrigem.Open;
  except
    on E: exception do
    begin
      GravaLog('Erro ao tentar se conectar ao banco de dados de origem: '+e.Message, 'log');
    end;
  end;
end;

function TdmConexao.ConsultarESalvar(ASelect, ATabelaOrigem, ABancoOrigem, ATabelaDestino,
  ABancoDestino: string; out OCaminhoArquivo: string): boolean;
var
  lNomeArquivo, lDiretorioArquivo: string;
  lListaArquivos, lLinasArquivo: TStringList;
  lQuery: TFDQuery;
  LJSONArray: TJSONArray;
begin
  Result := False;
  FQuantidadeUltimaConsulta := 0;
  lNomeArquivo := Format('%s.%s_%s.%s.json', [ABancoOrigem, ATabelaOrigem, ABancoDestino, ATabelaDestino]);
  lDiretorioArquivo := IncludeTrailingPathDelimiter(DirConsultasPendentes)+ lNomeArquivo;
  OCaminhoArquivo := lDiretorioArquivo;
  if FileExists(lDiretorioArquivo) then
    DeleteFile(lDiretorioArquivo);
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := ConexaoOrigem;
    try
      lQuery.Open(ASelect);
      lQuery.FetchAll;
      if not (lQuery.IsEmpty) then
      begin
        FQuantidadeUltimaConsulta := lQuery.RecordCount;
        GravaLog(
         Format('Salvando %d registro da tabela %s do banco de dados %s para serem inseridos na tabela %s do banco de dados %s',
         [lQuery.RecordCount, ATabelaOrigem, ABancoOrigem, ATabelaDestino, ABancoDestino])
          , 'log');
        lListaArquivos := TStringList.Create;
        try
          LJSONArray := lQuery.ToJSONArray();
          lListaArquivos.Text := LJSONArray.toJSON;
          lListaArquivos.SaveToFile(lDiretorioArquivo);
          Result := True;
        finally
          lListaArquivos.Free;
          LJSONArray.Free;
        end;
      end;
    except
      on e: exception do
      begin
         GravaLog('Erro ao abrir a consulta de dados: '+e.Message, 'log');
      end;
    end;
  finally
    lQuery.Free;
  end;
end;

function TdmConexao.Conectado: boolean;
begin
  Result := Conexao.Connected;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndNone;
end;

procedure TdmConexao.DataModuleDestroy(Sender: TObject);
begin
  DesconectarTodos;
end;

procedure TdmConexao.Desconectar;
begin
  Conexao.Close;
end;

procedure TdmConexao.DesconectarDestino;
begin
  ConexaoDestino.Close;
end;

procedure TdmConexao.DesconectarOrigem;
begin
  ConexaoOrigem.Close;
end;

procedure TdmConexao.DesconectarTodos;
begin
  DesconectarOrigem;
  DesconectarDestino;
  Desconectar;
end;

function TdmConexao.DestinoConectado: boolean;
begin
  Result := ConexaoDestino.Connected;
end;

function TdmConexao.ExecutarDestino(ASqlInsert, AEstrutura, ATabelaOrigem, ABancoOrigem,
  ATabelaDestino, ABancoDestino: string): boolean;
var
  lQuery: TFDQuery;
  lArray, lArrayEstruturaDestino: TJSONArray;
  I, O: integer;
  lNomeArquivo, lDiretorioArquivo: string;
begin
  lNomeArquivo := Format('%s.%s_%s.%s.json', [ABancoOrigem, ATabelaOrigem, ABancoDestino, ATabelaDestino]);
  lDiretorioArquivo := IncludeTrailingPathDelimiter(DirConsultasPendentes)+ lNomeArquivo;
  if FileExists(lDiretorioArquivo) then
  begin
    lQuery := TFDQuery.Create(nil);
    try
      lArray := TJSONObject.ParseJSONValue(LerTextFromFile(lDiretorioArquivo)) as TJSONArray;

      lArrayEstruturaDestino := TJSONObject.ParseJSONValue( LerJsonArray(AEstrutura, 'links')) as TJSONArray;
      try
        lQuery.Connection := ConexaoDestino;
        //Tentativa 1: arrayDML
        lQuery.SQL.Text := ASqlInsert;
        lQuery.Params.ArraySize := lArray.Count;
        for I := 0 to lArray.Count - 1 do
        begin
          for O := 0 to lArrayEstruturaDestino.Count - 1 do
          begin
            if not Assigned(lQuery.FindParam(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino'))) then
              Continue;

            case StrToIntDef(lArrayEstruturaDestino.Items[O].GetValue<string>('tipodestino'),0) of
              0: begin
                if not (lArray.Items[I].GetValue<TJSONValue>( lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino') ) is TJSONNull) then
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).AsStrings[I] :=
                  lArray.Items[I].GetValue<string>(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino'))
                else
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).Clear(I);
              end;
              1: begin
                if not (lArray.Items[I].GetValue<TJSONValue>( lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino') ) is TJSONNull) then
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).AsIntegers[I] :=
                  lArray.Items[I].GetValue<integer>(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino'))
                else
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).Clear(I);
              end;
              2: begin
                if not (lArray.Items[I].GetValue<TJSONValue>( lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino') ) is TJSONNull) then
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).AsFloats[I] :=
                  lArray.Items[I].GetValue<double>(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino'))
                else
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).Clear(I);
              end;
              3: begin
                if not (lArray.Items[I].GetValue<TJSONValue>( lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino') ) is TJSONNull) then
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).AsDates[I] :=
                  lArray.Items[I].GetValue<TDate>(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino'))
                else
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).Clear(I);
              end;
              4: begin
                if not (lArray.Items[I].GetValue<TJSONValue>( lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino') ) is TJSONNull) then
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).AsDateTimes[I] :=
                  lArray.Items[I].GetValue<TDateTime>(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino'))
                else
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).Clear(I);
              end;
              5: begin
                if not (lArray.Items[I].GetValue<TJSONValue>( lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino') ) is TJSONNull) then
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).AsMemos[I] :=
                  lArray.Items[I].GetValue<string>(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino'))
                else
                  lQuery.ParamByName(lArrayEstruturaDestino.Items[O].GetValue<string>('campodestino')).Clear(I);
              end;
            end;
          end;
        end;
        lQuery.Execute(lArray.Count, 0);

        Result := True;
      except
        on E: exception do
        begin
           GravaLog('Erro ao executar inserção de dados no banco de destino: '+e.Message+sLineBreak+'Arquivo: '+lNomeArquivo, 'log');
        end;
      end;
    finally
      lQuery.Free;
      lArray.Free;
      lArrayEstruturaDestino.Free;
    end;
  end else
    Result := True;
end;

procedure TdmConexao.Execute(ASQL: array of string; AConexao: TFDConnection);
var
  lQuery: TFDQuery;
  I: Integer;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := AConexao;
    try
      for I := Low(ASQL) to High(ASQL) do
      begin
        lQuery.ExecSQL(ASQL[I]);
      end;
    except
      on e: exception do
        GravaLog('Erro ao executar comando SQL'+sLineBreak+'Erro: '+e.Message, 'log');
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TdmConexao.Execute(ASQL: string; AConexao: TFDConnection);
var
  lQuery: TFDQuery;
begin
  if ASQL.IsEmpty then
    Exit;
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := AConexao;
    lQuery.SQL.Text := ASQL;
    try
      lQuery.ExecSQL;
    except
      on e: exception do
        GravaLog('Erro ao executar comando SQL: '+ASQL+sLineBreak+'Erro: '+e.Message, 'log');
    end;
  finally
    lQuery.Free;
  end;
end;

function TdmConexao.GetScript(AIndex: integer): string;
begin
  Result := Scripts.SQLScripts.Items[AIndex].SQL.Text;
end;

function TdmConexao.OrigemConectado: boolean;
begin
  Result := ConexaoOrigem.Connected;
end;

function TdmConexao.Select(AIndex: integer): string;
var
  lQuery: TFDQuery;
  LJSONArray: TJSONArray;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Conexao;
    lQuery.Open(GetScript(AIndex));
    LJSONArray := lQuery.ToJSONArray();
    Result := LJSONArray.toJSON;
  finally
    lQuery.Free;
    LJSONArray.Free;
  end;
end;

function TdmConexao.Select(ASQL: string): string;
var
  lQuery: TFDQuery;
  LJSONArray: TJSONArray;
begin
  if ASQL.IsEmpty then
    Exit(EmptyStr);
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Conexao;
    lQuery.Open(ASQL);
    LJSONArray := lQuery.ToJSONArray();
    Result := LJSONArray.toJSON;
  finally
    lQuery.Free;
    LJSONArray.Free;
  end;
end;

class function TdmConexao.TestarConexao(AJson: string): boolean;
begin
  dmConexao := TdmConexao.Create(nil);
  try
    dmConexao.Conectar(AJson);
    Result := dmConexao.Conectado;
  finally
    dmConexao.Free;
  end;
end;

end.
