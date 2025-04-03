unit plugin.controller.links;

interface

uses System.JSON, System.SysUtils, System.Generics.Collections, System.StrUtils,
  uUtils;

type
  TPluginLinkJoin = class
  private
    FJoin: string;
    FTipo: string;
    FCondicao: string;
  public
    constructor Create;
    class function Novo(AJoin, ATipo, ACondicao: string): TPluginLinkJoin;
    function MontaJoin: string;
    function Salvar: string;
  end;

  TPluginLinkTabela = class
  private
    FTabelaOrigem: string;
    FCampoOrigem: string;
    FTipoOrigem: string;
		FCampoDestino: string;
		FTipoDestino: string;
		FTamanhoMaximo: integer;
		FValorPadrao: string;
		FPermiteNulo: string;
    FMascaraConversao: string;
    FChavePrimaria: boolean;
  public
    constructor Create;
    class function Novo(ATabelaOrigem, ACampoOrigem, ATipoOrigem, ACampoDestino, ATipoDestino,
      AValorPadrao, APermiteNulo, AMascaraConversao: string; ATamanhoMaximo: integer;
      AChavePrimaria: boolean): TPluginLinkTabela;
    function MontaSelect: string;
    function MontaInsert(AType: integer): string;
    function MatchingField: string;
    function Salvar: string;
  end;

  TPluginLink = class
  private
    FTabelaOrigem: string;
    FTabelaDestino: string;
    FWhereSelect, FWhereAdicional: string;
    FSelect: string;
    FInsert: string;
    FUpdate: string;
    FLinks: TObjectList<TPluginLinkTabela>;
    FJoins: TObjectList<TPluginLinkJoin>;
    FChavesAuxiliares: TJSONArray;
    FTipoComando: string;
    FNomeArquivo: string;
    FTipoExecucao: string;
    FTipoExecucaoSQL: string;
    FListaCamposChaves: string;
    function MontaSelect(AIgnoraWhere: boolean = false): string;
    function MontaInsert: string;
    function MontaInsertMigracao(AContinuarSequencia: boolean = False): string;
    function MontaInsertMigracaoPessoa(ACampoChave: string; AContinuarSequencia: boolean = False): string;
    function MontaInsertMigracaoProduto(ACampoChave: string; AContinuarSequencia: boolean = False): string;
    function MontaUpdate: string;
  public
    constructor Create;
    destructor Destroy; override;
    function Salvar: string;
    function SalvarArquivo(APasta, ANomeArquivo: string): boolean;
    property TabelaOrigem: string read FTabelaOrigem write FTabelaOrigem;
    property TabelaDestino: string read FTabelaDestino write FTabelaDestino;
    property WhereSelect: string read FWhereSelect write FWhereSelect;
    property WhereAdicional: string read FWhereAdicional write FWhereAdicional;
    property TipoComando: string read FTipoComando write FTipoComando;
    property NomeArquivo: string read FNomeArquivo write FNomeArquivo;
    property TipoExecucao: string read FTipoExecucao write FTipoExecucao;
    property TipoExecucaoSQL: string read FTipoExecucaoSQL write FTipoExecucaoSQL;
    property ListaCamposChaves: string read FListaCamposChaves write FListaCamposChaves;
    function AddLinkFields(ATabelaOrigem, ACampoOrigem, ATipoOrigem, ACampoDestino, ATipoDestino,
      AValorPadrao, APermiteNulo, AMascaraConversao: string; ATamanhoMaximo: integer;
      AChavePrimaria: boolean): boolean;
    procedure AddTabelaJoin(ATabelaJoin, ATipoJoin, ACondicaoJoin: string);
    function RemoverLinkFields(ATabelaOrigem, ACampoOrigem, ACampoDestino: string): boolean;
    function LinkOrigemJaRegistrado(ATabelaOrigem, ACampo: string): boolean;
    function LinkDestinoJaRegistrado(ACampo: string): boolean;
    function GetCampoOrigemDoDestino(ADestino: string): string;
    function GetCampoDestinoDoOrigem(ATabelaOrigem, AOrigem: string): string;
    procedure LoadByJson(AJson: string);
    procedure MontaSQL;
    function GetSelect: string;
    function GetSelectAll: string;
    function GetInsert: string;
    function GetInsertAll(AContinuarSequencia: boolean = false): string;
    function GetInsertPessoa(ACampoChave: string; AContinuarSequencia: boolean = false): string;
    function GetInsertProduto(ACampoChave: string; AContinuarSequencia: boolean = false): string;
    function GetUpdate: string;
    procedure MontaWhereSelect;
    function AtualizarDataConsulta(ADataConsultas: string): string;
    class function Novo: TPluginLink; overload;
    class function Novo(AJson: string): TPluginLink; overload;
    function GetJoins: TObjectList<TPluginLinkJoin>;
    function SchemaInsert: boolean;
    function SchemaExecucaoGrupo: boolean;
    function SchemaExecucaoIncremental: boolean;
    procedure SetSchemaInsert;
    procedure SetSchemaUpdate;
    procedure SetExecucaoIndividual;
    procedure SetExecucaoEmGrupo;
    procedure SetExecucaoIncremental;
    procedure SetExecucaoPadrao;
    procedure SetCamposChaves(AListaCamposChaves: string);
  end;

implementation

{ TPluginLink }

function TPluginLink.AddLinkFields(ATabelaOrigem, ACampoOrigem, ATipoOrigem, ACampoDestino,
  ATipoDestino, AValorPadrao, APermiteNulo, AMascaraConversao: string;
  ATamanhoMaximo: integer; AChavePrimaria: boolean): boolean;
var
  lTextoExemplo: string;
begin
  Result := False;
  //Validações
  //Tipos imcopativeis
  if AMascaraConversao.IsEmpty then //Se a marcara de conversao estiver preenchida ignora as validações de tipos
  begin
    if (ATipoOrigem.IsEmpty) and (AValorPadrao.IsEmpty) then
    begin
      case StrToInt(ATipoDestino) of
        0 : lTextoExemplo := '''A'' as '+ACampoDestino;
        1 : lTextoExemplo := '0 as '+ACampoDestino;
        2 : lTextoExemplo := '0 as '+ACampoDestino;
        3 : lTextoExemplo := 'current_date as '+ACampoDestino;
        4 : lTextoExemplo := 'current_timestamp as '+ACampoDestino;
        5 : lTextoExemplo := '''A'' as '+ACampoDestino;
      end;
      ShowWarning('Campo de origem não informado. Utilize a opção de conversão no campo "Expressão livre" para informar um valor padrão para o campo de destino'+sLineBreak+'Exemplo: '+lTextoExemplo);
      Exit(False);
    end;
    if StrToIntDef(ATipoOrigem, StrToIntDef(ATipoDestino, 0)) = 0 then
    begin
      case StrToIntDef(ATipoDestino, 0) of
        1, 2, 3, 4: begin
          ShowWarning('Tipos de campos incompatíveis. Utilize a opção de conversão no campo "Expressão livre"');
          Exit(False);
        end;
      end;
    end;
    if StrToIntDef(ATipoOrigem, StrToIntDef(ATipoDestino, 1)) = 1 then
    begin
      case StrToIntDef(ATipoDestino, 1) of
        3, 4: begin
          ShowWarning('Tipos de campos incompatíveis. Utilize a opção de conversão no campo "Expressão livre"');
          Exit(False);
        end;
      end;
    end;
    if StrToIntDef(ATipoOrigem, StrToIntDef(ATipoDestino, 2)) = 2 then
    begin
      case StrToIntDef(ATipoDestino, 2) of
        1, 3, 4: begin
          ShowWarning('Tipos de campos incompatíveis. Utilize a opção de conversão no campo "Expressão livre"');
          Exit(False);
        end;
      end;
    end;
    if StrToIntDef(ATipoOrigem, StrToIntDef(ATipoDestino, 3)) = 3 then
    begin
      case StrToIntDef(ATipoDestino, 3) of
        1, 2: begin
          ShowWarning('Tipos de campos incompatíveis. Utilize a opção de conversão no campo "Expressão livre"');
          Exit(False);
        end;
      end;
    end;
    if StrToIntDef(ATipoOrigem, StrToIntDef(ATipoDestino, 4)) = 4 then
    begin
      case StrToIntDef(ATipoDestino, 4) of
        1, 2: begin
          ShowWarning('Tipos de campos incompatíveis. Utilize a opção de conversão no campo "Expressão livre"');
          Exit(False);
        end;
      end;
    end;
    if StrToIntDef(ATipoOrigem, StrToIntDef(ATipoDestino, 5)) = 5 then
    begin
      case StrToIntDef(ATipoDestino, 5) of
        1, 2, 3, 4: begin
          ShowWarning('Tipos de campos incompatíveis. Utilize a opção de conversão no campo "Expressão livre"');
          Exit(False);
        end;
      end;
    end;
  end;
  if not (ACampoOrigem = 'DATA_ALTERADO') then
  begin
    FLinks.Add(TPluginLinkTabela.Novo(ATabelaOrigem, ACampoOrigem, ATipoOrigem, ACampoDestino,
      ATipoDestino, AValorPadrao, APermiteNulo, AMascaraConversao, ATamanhoMaximo,
      AChavePrimaria));
    Result := True;
  end else
  begin
    FLinks.Add(TPluginLinkTabela.Novo(ATabelaOrigem, ACampoOrigem, ATipoOrigem, '',
      '', '', '', '', 0, False));
    Result := True;
  end;
end;

procedure TPluginLink.AddTabelaJoin(ATabelaJoin, ATipoJoin,
  ACondicaoJoin: string);
begin
  FJoins.Add(TPluginLinkJoin.Novo(ATabelaJoin, ATipoJoin, ACondicaoJoin));
end;

function TPluginLink.AtualizarDataConsulta(ADataConsultas: string): string;
begin
  Result := '';
  if not (FWhereSelect.IsEmpty) then
    Result := 'update SINCRONIZACAO_PLUGIN set '+FTabelaOrigem+' = '+ADataConsultas;
end;

constructor TPluginLink.Create;
begin
  FTabelaOrigem := '';
  FTabelaDestino := '';
  FLinks := TObjectList<TPluginLinkTabela>.Create;
  FJoins := TObjectList<TPluginLinkJoin>.Create;
  FChavesAuxiliares := TJSONArray.Create;
  FTipoComando := 'insert';
  FTipoExecucao := 'grupo';
  FTipoExecucaoSQL := 'padrao';
  FListaCamposChaves := EmptyStr;
end;

destructor TPluginLink.Destroy;
begin
  FLinks.Free;
  FJoins.Free;
  FChavesAuxiliares.Free;
  inherited;
end;

function TPluginLink.GetCampoDestinoDoOrigem(ATabelaOrigem, AOrigem: string): string;
var
  I: Integer;
begin
  Result := '';
  if FLinks.Count > 0 then
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      if (FLinks[I].FCampoOrigem = AOrigem) and (FLinks[I].FTabelaOrigem = ATabelaOrigem) then
      begin
        Result := FLinks[I].FCampoDestino;
        break;
      end;
    end;
  end;
end;

function TPluginLink.GetCampoOrigemDoDestino(ADestino: string): string;
var
  I: Integer;
begin
  Result := '';
  if FLinks.Count > 0 then
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      if FLinks[I].FCampoDestino = ADestino then
      begin
        if FLinks[I].FTabelaOrigem = TabelaOrigem then
          Result := FLinks[I].FCampoOrigem
        else
          Result := FLinks[I].FTabelaOrigem +'.'+ FLinks[I].FCampoOrigem;
        break;
      end;
    end;
  end;
end;

function TPluginLink.GetInsert: string;
begin
  MontaSQL;
  Result := FInsert;
end;

function TPluginLink.GetInsertAll(AContinuarSequencia: boolean = false): string;
begin
  FInsert := MontaInsertMigracao(AContinuarSequencia);
  Result := FInsert;
end;

function TPluginLink.GetInsertPessoa(ACampoChave: string; AContinuarSequencia: boolean): string;
begin
  FInsert := MontaInsertMigracaoPessoa(ACampoChave, AContinuarSequencia);
  Result := FInsert;
end;

function TPluginLink.GetInsertProduto(ACampoChave: string; AContinuarSequencia: boolean): string;
begin
  FInsert := MontaInsertMigracaoProduto(ACampoChave, AContinuarSequencia);
  Result := FInsert;
end;

function TPluginLink.GetJoins: TObjectList<TPluginLinkJoin>;
begin
  Result := FJoins;
end;

function TPluginLink.GetSelect: string;
begin
  MontaSQL;
  Result := FSelect;
end;

function TPluginLink.GetSelectAll: string;
begin
  FSelect := MontaSelect(True);
  Result := FSelect;
end;

function TPluginLink.GetUpdate: string;
begin
  FUpdate := MontaUpdate;
  Result := FUpdate;
end;

function TPluginLink.LinkDestinoJaRegistrado(ACampo: string): boolean;
var
  I: Integer;
begin
  Result := False;
  if FLinks.Count > 0 then
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      if FLinks[I].FCampoDestino = ACampo then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function TPluginLink.LinkOrigemJaRegistrado(ATabelaOrigem, ACampo: string): boolean;
var
  I: Integer;
begin
  Result := False;
  if FLinks.Count > 0 then
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      if (FLinks[I].FCampoOrigem = ACampo) and (FLinks[I].FTabelaOrigem = ATabelaOrigem) then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

procedure TPluginLink.LoadByJson(AJson: string);
var
  lCampos, lJoins: TJSONArray;
  I: Integer;
begin
  Self.TabelaOrigem := LerJson(AJson, 'tabelaorigem');
  Self.TabelaDestino := LerJson(AJson, 'tabeladestino');
  Self.WhereSelect := LerJson(AJson, 'where');
  Self.WhereAdicional := LerJson(AJson, 'whereadicional');
  Self.TipoComando := LerJson(AJson, 'comando', 'insert');
  Self.TipoExecucao := LerJson(AJson, 'execucao', 'grupo');
  Self.TipoExecucaoSQL := LerJson(AJson, 'execucaosql', 'padrao');
  Self.ListaCamposChaves := LerJson(AJson, 'camposchaves', '');
  FreeAndNil(FJoins);
  FJoins := TObjectList<TPluginLinkJoin>.Create;
  FreeAndNil(FLinks);
  FLinks := TObjectList<TPluginLinkTabela>.Create;
  lCampos := TJSONObject.ParseJSONValue(LerJsonArray(AJson, 'links')) as TJSONArray;
  try
    for I := 0 to lCampos.Count - 1 do
    begin
      Self.AddLinkFields(lCampos.Items[I].GetValue<string>('tabelaorigem'),
                         lCampos.Items[I].GetValue<string>('campoorigem'),
                         lCampos.Items[I].GetValue<string>('tipoorigem'),
                         lCampos.Items[I].GetValue<string>('campodestino'),
                         lCampos.Items[I].GetValue<string>('tipodestino'),
                         lCampos.Items[I].GetValue<string>('valorpadrao'),
                         lCampos.Items[I].GetValue<string>('permitenulo'),
                         lCampos.Items[I].GetValue<string>('mascaraconversao'),
                         lCampos.Items[I].GetValue<integer>('tamanhomaximo'),
                         lCampos.Items[I].GetValue<string>('chaveprimaria') = 'S');
    end;
  finally
    lCampos.Free;
  end;

  lJoins := TJSONObject.ParseJSONValue(LerJsonArray(AJson, 'joins')) as TJSONArray;
  try
    for I := 0 to lJoins.Count - 1 do
    begin
      Self.AddTabelaJoin(lJoins.Items[I].GetValue<string>('join'),
                         lJoins.Items[I].GetValue<string>('tipo'),
                         lJoins.Items[I].GetValue<string>('condicao'));
    end;
  finally
    lJoins.Free;
  end;
end;

function TPluginLink.MontaInsert: string;
var
  lSql, lSqlFields, lSqlValues, lSqlMatchingField: string;
  I: Integer;
begin
  for I := 0 to FLinks.Count - 1 do
  begin
    lSqlFields := lSqlFields + IfThen(lSqlFields.IsEmpty, '', ', ') + FLinks[I].MontaInsert(0);
    lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + FLinks[I].MontaInsert(1);
    if not (FLinks[I].MatchingField.IsEmpty) then
      lSqlMatchingField := lSqlMatchingField + IfThen(lSqlMatchingField.IsEmpty, '', ', ') + FLinks[I].MatchingField;
  end;
  lSql := ' insert ';
  if not (lSqlMatchingField.IsEmpty) then
    lSql := 'update or ' + lSql;
  lSql := lSql + ' into '+FTabelaDestino+' ('+lSqlFields+') ';
  lSql := lSql + ' values ('+lSqlValues+') ';
  if not (lSqlMatchingField.IsEmpty) then
    lSql := lSql + ' matching ('+lSqlMatchingField+') ';
  Result := lSql;
end;

function TPluginLink.MontaInsertMigracao(AContinuarSequencia: boolean = False): string;
var
  lSql, lSqlFields, lSqlValues, lSqlMatchingField, lKeyField, lKeyAux, lTextoMascaraSelect, lMascaraCampoOrigem,
  lMascaraTabela, lMarcaraCampoDestino, lTextoSelectField: string;
  I, O: Integer;
begin
  if AContinuarSequencia then
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      lTextoSelectField := EmptyStr;
      if FLinks[I].FChavePrimaria then
      begin
        lKeyField := FLinks[I].FCampoDestino;
        Continue;
      end;
      if ContainsText(FLinks[I].FCampoDestino, '__FISCAL') then
        lKeyAux := FLinks[I].FCampoDestino;

      if ContainsText(FLinks[I].FMascaraConversao, '/*#') then
      begin
        lTextoMascaraSelect := ExtrairTextoAPartirDePosicao(FLinks[I].FMascaraConversao, '#', EXTRAIR_TRECHO);
        lMascaraCampoOrigem := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_PRE_TRECHO);
        lMascaraTabela := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_TRECHO);
        lMarcaraCampoDestino := ExtrairTextoAPartirDePosicao(ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_POS_TRECHO), '-', EXTRAIR_POS_TRECHO);
        lTextoSelectField := Format('(select first 1 ID from %s where %s = %s)', [lMascaraTabela,
                                                                                  lMarcaraCampoDestino,
                                                                                  FLinks[I].MontaInsert(1)]);
      end;

      lSqlFields := lSqlFields + IfThen(lSqlFields.IsEmpty, '', ', ') + FLinks[I].MontaInsert(0);
      if not (lTextoSelectField.IsEmpty) then
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + lTextoSelectField
      else
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + FLinks[I].MontaInsert(1);
    end;
    if not (lKeyAux.IsEmpty) then
    begin
      FChavesAuxiliares.Add(TJSONObject.Create.AddPair('tabela', FTabelaDestino)
                                              .AddPair('key', lKeyField)
                                              .AddPair('key_aux', lKeyAux));
    end;
    lSql := ' insert ';
    lSql := lSql + ' into '+FTabelaDestino+' ('+lSqlFields+') ';
    lSql := lSql + ' values ('+lSqlValues+') ';
    Result := lSql;
  end
  else
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      lSqlFields := lSqlFields + IfThen(lSqlFields.IsEmpty, '', ', ') + FLinks[I].MontaInsert(0);
      lTextoSelectField := EmptyStr;
      if ContainsText(FLinks[I].FMascaraConversao, '/*#') then
      begin
        lTextoMascaraSelect := ExtrairTextoAPartirDePosicao(FLinks[I].FMascaraConversao, '#', EXTRAIR_TRECHO);
        lMascaraCampoOrigem := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_PRE_TRECHO);
        lMascaraTabela := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_TRECHO);
        lMarcaraCampoDestino := ExtrairTextoAPartirDePosicao(ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_POS_TRECHO), '-', EXTRAIR_POS_TRECHO);
        lTextoSelectField := Format('(select first 1 ID from %s where %s = %s)', [lMascaraTabela,
                                                                                  lMarcaraCampoDestino,
                                                                                  FLinks[I].MontaInsert(1)]);
      end;
      if not (lTextoSelectField.IsEmpty) then
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + lTextoSelectField
      else
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + FLinks[I].MontaInsert(1);

      if not (FLinks[I].MatchingField.IsEmpty) then
        lSqlMatchingField := lSqlMatchingField + IfThen(lSqlMatchingField.IsEmpty, '', ', ') + FLinks[I].MatchingField;
    end;
    lSql := ' insert ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := 'update or ' + lSql;
    lSql := lSql + ' into '+FTabelaDestino+' ('+lSqlFields+') ';
    lSql := lSql + ' values ('+lSqlValues+') ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := lSql + ' matching ('+lSqlMatchingField+') ';
    Result := lSql;
  end;
end;

function TPluginLink.MontaInsertMigracaoPessoa(ACampoChave: string; AContinuarSequencia: boolean): string;
var
  lSql, lSqlFields, lSqlValues, lSqlMatchingField, lKeyField, lKeyAux, lTextoMascaraSelect, lMascaraCampoOrigem,
  lMascaraTabela, lMarcaraCampoDestino, lTextoSelectField: string;
  I, O: Integer;
begin
  if AContinuarSequencia then
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      lTextoSelectField := EmptyStr;
      if FLinks[I].FChavePrimaria then
      begin
        lKeyField := FLinks[I].FCampoDestino;
        Continue;
      end;
      if ContainsText(FLinks[I].FCampoDestino, '__FISCAL') then
        lKeyAux := FLinks[I].FCampoDestino;

      if ContainsText(FLinks[I].FMascaraConversao, '/*#') then
      begin
        lTextoMascaraSelect := ExtrairTextoAPartirDePosicao(FLinks[I].FMascaraConversao, '#', EXTRAIR_TRECHO);
        lMascaraCampoOrigem := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_PRE_TRECHO);
        lMascaraTabela := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_TRECHO);
        lMarcaraCampoDestino := ExtrairTextoAPartirDePosicao(ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_POS_TRECHO), '-', EXTRAIR_POS_TRECHO);
        lTextoSelectField := Format('(select first 1 ID from %s where %s = %s)', [lMascaraTabela,
                                                                                  lMarcaraCampoDestino,
                                                                                  FLinks[I].MontaInsert(1)]);
      end;

      lSqlFields := lSqlFields + IfThen(lSqlFields.IsEmpty, '', ', ') + FLinks[I].MontaInsert(0);
      if not (lTextoSelectField.IsEmpty) then
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + lTextoSelectField
      else
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + FLinks[I].MontaInsert(1);
    end;
    if not (lKeyAux.IsEmpty) then
    begin
      FChavesAuxiliares.Add(TJSONObject.Create.AddPair('tabela', FTabelaDestino)
                                              .AddPair('key', lKeyField)
                                              .AddPair('key_aux', lKeyAux));
    end;
    lSqlMatchingField := ACampoChave;
    lSql := ' insert ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := 'update or ' + lSql;
    lSql := lSql + ' into '+FTabelaDestino+' ('+lSqlFields+') ';
    lSql := lSql + ' values ('+lSqlValues+') ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := lSql + ' matching ('+lSqlMatchingField+') ';
    Result := lSql;
  end
  else
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      lSqlFields := lSqlFields + IfThen(lSqlFields.IsEmpty, '', ', ') + FLinks[I].MontaInsert(0);
      lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + FLinks[I].MontaInsert(1);
    end;
    lSqlMatchingField := ACampoChave;
    lSql := ' insert ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := 'update or ' + lSql;
    lSql := lSql + ' into '+FTabelaDestino+' ('+lSqlFields+') ';
    lSql := lSql + ' values ('+lSqlValues+') ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := lSql + ' matching ('+lSqlMatchingField+') ';
    Result := lSql;
  end;
end;

function TPluginLink.MontaInsertMigracaoProduto(ACampoChave: string; AContinuarSequencia: boolean): string;
var
  lSql, lSqlFields, lSqlValues, lSqlMatchingField, lKeyField, lKeyAux, lTextoMascaraSelect, lMascaraCampoOrigem,
  lMascaraTabela, lMarcaraCampoDestino, lTextoSelectField: string;
  I, O: Integer;
begin
  if AContinuarSequencia then
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      lTextoSelectField := EmptyStr;
      if FLinks[I].FChavePrimaria then
      begin
        lKeyField := FLinks[I].FCampoDestino;
        Continue;
      end;
      if ContainsText(FLinks[I].FCampoDestino, '__FISCAL') then
        lKeyAux := FLinks[I].FCampoDestino;

      if ContainsText(FLinks[I].FMascaraConversao, '/*#') then
      begin
        lTextoMascaraSelect := ExtrairTextoAPartirDePosicao(FLinks[I].FMascaraConversao, '#', EXTRAIR_TRECHO);
        lMascaraCampoOrigem := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_PRE_TRECHO);
        lMascaraTabela := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_TRECHO);
        lMarcaraCampoDestino := ExtrairTextoAPartirDePosicao(ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_POS_TRECHO), '-', EXTRAIR_POS_TRECHO);
        lTextoSelectField := Format('(select first 1 ID from %s where %s = %s)', [lMascaraTabela,
                                                                                  lMarcaraCampoDestino,
                                                                                  FLinks[I].MontaInsert(1)]);
      end;

      lSqlFields := lSqlFields + IfThen(lSqlFields.IsEmpty, '', ', ') + FLinks[I].MontaInsert(0);
      if not (lTextoSelectField.IsEmpty) then
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + lTextoSelectField
      else
        lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + FLinks[I].MontaInsert(1);
    end;
    if not (lKeyAux.IsEmpty) then
    begin
      FChavesAuxiliares.Add(TJSONObject.Create.AddPair('tabela', FTabelaDestino)
                                              .AddPair('key', lKeyField)
                                              .AddPair('key_aux', lKeyAux));
    end;
    lSqlMatchingField := ACampoChave;
    lSql := ' insert ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := 'update or ' + lSql;
    lSql := lSql + ' into '+FTabelaDestino+' ('+lSqlFields+') ';
    lSql := lSql + ' values ('+lSqlValues+') ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := lSql + ' matching ('+lSqlMatchingField+') ';
    Result := lSql;
  end
  else
  begin
    for I := 0 to FLinks.Count - 1 do
    begin
      lSqlFields := lSqlFields + IfThen(lSqlFields.IsEmpty, '', ', ') + FLinks[I].MontaInsert(0);
      lSqlValues := lSqlValues + IfThen(lSqlValues.IsEmpty, '', ', ') + FLinks[I].MontaInsert(1);
    end;
    lSqlMatchingField := ACampoChave;
    lSql := ' insert ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := 'update or ' + lSql;
    lSql := lSql + ' into '+FTabelaDestino+' ('+lSqlFields+') ';
    lSql := lSql + ' values ('+lSqlValues+') ';
    if not (lSqlMatchingField.IsEmpty) then
      lSql := lSql + ' matching ('+lSqlMatchingField+') ';
    Result := lSql;
  end;
end;

function TPluginLink.MontaSelect(AIgnoraWhere: boolean = false): string;
var
  lSql, lSqlCampos, lSqlJoin, lSqlWhere: string;
  I: Integer;
begin
  lSql := 'select ';
  for I := 0 to FLinks.Count - 1 do
  begin
    lSqlCampos := lSqlCampos + IfThen(lSqlCampos.IsEmpty, '', ', ') + FLinks[I].MontaSelect;
  end;
  if not (AIgnoraWhere) then
    lSqlWhere := FWhereSelect;
  lSqlWhere := lSqlWhere + FWhereAdicional;
  lSqlJoin := ''; //Monta joins
  for I := 0 to FJoins.Count - 1 do
  begin
    lSqlJoin := lSqlJoin + sLineBreak + FJoins[I].MontaJoin;
  end;
  Result := Format('%s %s from %s %s %s', [lSql, lSqlCampos, FTabelaOrigem, lSqlJoin, lSqlWhere]);
end;

procedure TPluginLink.MontaSQL;
begin
  FSelect := MontaSelect;
  FInsert := MontaInsert;
  FUpdate := MontaUpdate;
end;

function TPluginLink.MontaUpdate: string;
var
  I: integer;
  lSqlValueToFields, lSql,
  lTextoSelectField, lTextoMascaraSelect, lMascaraCampoOrigem, lMascaraTabela, lMarcaraCampoDestino: string;
begin
  for I := 0 to FLinks.Count - 1 do
  begin
    if ContainsText(FLinks[I].FMascaraConversao, '/*#') then
    begin
      lTextoMascaraSelect := ExtrairTextoAPartirDePosicao(FLinks[I].FMascaraConversao, '#', EXTRAIR_TRECHO);
      lMascaraCampoOrigem := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_PRE_TRECHO);
      lMascaraTabela := ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_TRECHO);
      lMarcaraCampoDestino := ExtrairTextoAPartirDePosicao(ExtrairTextoAPartirDePosicao(lTextoMascaraSelect, '-', EXTRAIR_POS_TRECHO), '-', EXTRAIR_POS_TRECHO);
      lTextoSelectField := Format('(select first 1 ID from %s where %s = %s)', [lMascaraTabela,
                                                                                lMarcaraCampoDestino,
                                                                                FLinks[I].MontaInsert(1)]);
    end
    else
      lTextoSelectField := FLinks[I].MontaInsert(1);

    lSqlValueToFields := lSqlValueToFields + IfThen(lSqlValueToFields.IsEmpty, '', ', ') +
      FLinks[I].MontaInsert(0) + ' = ' +lTextoSelectField;
  end;
  lSql := ' update '+FTabelaDestino+' set '+lSqlValueToFields+ ' '+FWhereSelect;
  Result := lSql;
end;

procedure TPluginLink.MontaWhereSelect;
begin
  FWhereSelect := ' where '+FTabelaOrigem+'.DATA_ALTERADO > (select '+FTabelaOrigem+' from SINCRONIZACAO_PLUGIN) ';
end;

class function TPluginLink.Novo(AJson: string): TPluginLink;
begin
  Result := Self.Create;
  Result.LoadByJson(AJson);
end;

function TPluginLink.RemoverLinkFields(ATabelaOrigem, ACampoOrigem, ACampoDestino: string): boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FLinks.Count - 1 do
  begin
    if (FLinks[I].FTabelaOrigem = ATabelaOrigem) and (FLinks[I].FCampoOrigem = ACampoOrigem) and (FLinks[I].FCampoDestino = ACampoDestino) then
    begin
      FLinks.Delete(I);
      Result := True;
      Break;
    end;
  end;
end;

class function TPluginLink.Novo: TPluginLink;
begin
  Result := Self.Create;
end;

function TPluginLink.Salvar: string;
var
  vJsonResposta: TJSONObject;
  vJsonLinks, vJsonJoins: TJSONArray;
  I: integer;
begin
  try
    vJsonResposta := TJSONObject.Create
      .AddPair('tabelaorigem', FTabelaOrigem)
      .AddPair('tabeladestino', FTabelaDestino);
    vJsonResposta.AddPair('where', FWhereSelect);
    vJsonResposta.AddPair('whereadicional', FWhereAdicional);
    vJsonResposta.AddPair('comando', FTipoComando);
    vJsonResposta.AddPair('execucao', FTipoExecucao);
    vJsonResposta.AddPair('execucaosql', FTipoExecucaoSQL);
    vJsonResposta.AddPair('camposchaves', FListaCamposChaves);
    vJsonJoins := TJSONArray.Create;
    for I := 0 to FJoins.Count - 1 do
    begin
      if Assigned(FJoins.Items[I]) then
        vJsonJoins.Add(TJSONObject.ParseJSONValue(FJoins.Items[I].Salvar) as TJSONObject);
    end;
    vJsonResposta.AddPair('joins', vJsonJoins);

    vJsonLinks := TJSONArray.Create;
    for I := 0 to FLinks.Count - 1 do
    begin
      if Assigned(FLinks.Items[I]) then
        vJsonLinks.Add(TJSONObject.ParseJSONValue(FLinks.Items[I].Salvar) as TJSONObject);
    end;
    vJsonResposta.AddPair('links', vJsonLinks);
    Result := vJsonResposta.ToJSON;
  finally
    vJsonResposta.Free;
  end;
end;

function TPluginLink.SalvarArquivo(APasta, ANomeArquivo: string): boolean;
var
  lArquivo: string;
begin
  lArquivo := IncludeTrailingPathDelimiter(APasta)+ANomeArquivo+'.json';
  if FileExists(lArquivo) then
    if not (ShowQuestion('Deseja substituir o registro "'+ANomeArquivo+'" existente?')) then
      Exit(False);
  GravarArrayJsonToFile(Salvar, lArquivo);
  Result := True;
end;

function TPluginLink.SchemaExecucaoGrupo: boolean;
begin
  Result := FTipoExecucao = 'grupo';
end;

function TPluginLink.SchemaExecucaoIncremental: boolean;
begin
  Result := FTipoExecucaoSQL = 'incremental';
end;

function TPluginLink.SchemaInsert: boolean;
begin
  Result := FTipoComando = 'insert';
end;

procedure TPluginLink.SetCamposChaves(AListaCamposChaves: string);
begin
  FListaCamposChaves := AListaCamposChaves;
end;

procedure TPluginLink.SetExecucaoEmGrupo;
begin
  FTipoExecucao := 'grupo';
end;

procedure TPluginLink.SetExecucaoIndividual;
begin
  FTipoExecucao := 'individual';
end;

procedure TPluginLink.SetExecucaoIncremental;
begin
  FTipoExecucaoSQL := 'incremental';
end;

procedure TPluginLink.SetExecucaoPadrao;
begin
  FTipoExecucaoSQL := 'padrao';
end;

procedure TPluginLink.SetSchemaInsert;
begin
  FTipoComando := 'insert';
end;

procedure TPluginLink.SetSchemaUpdate;
begin
  FTipoComando := 'update';
end;

{ TPluginLinkTabela }

constructor TPluginLinkTabela.Create;
begin
  FTabelaOrigem := '';
  FCampoOrigem := '';
  FTipoOrigem := '';
	FCampoDestino := '';
	FTipoDestino := '';
	FTamanhoMaximo := 0;
	FValorPadrao := '';
	FPermiteNulo := 'N';
  FMascaraConversao := '';
  FChavePrimaria := False;
end;

function TPluginLinkTabela.MatchingField: string;
begin
  Result := '';
  if FChavePrimaria then
    Result := FCampoDestino;
end;

function TPluginLinkTabela.MontaInsert(AType: integer): string;
begin
  Result := IfThen(AType = 0, '', ':')+ FCampoDestino;
end;

function TPluginLinkTabela.MontaSelect: string;
var
  lCampo, lCampoOrigem: string;
begin
  if FMascaraConversao.IsEmpty then
  begin
    lCampoOrigem := FTabelaOrigem+'.'+FCampoOrigem; //Campo origem formatado com o nome da tabela de origem
    case StrToInt(FTipoDestino) of
      0: begin // -> Texto
        if FCampoOrigem.IsEmpty then
          lCampo := QuotedStr(FValorPadrao)
        else
        case StrToInt(FTipoOrigem) of
          0, 5: begin //Texto -> Texto
            if not (FValorPadrao.IsEmpty) then
              lCampo := 'coalesce('+lCampoOrigem+', '+FValorPadrao.QuotedString+')'
            else
              lCampo := lCampoOrigem;
            lCampo := Format('substring(%s from 1 for %d)', [lCampo, FTamanhoMaximo]);
          end;
          1, 2: begin //Numerico -> Texto
            if not (FValorPadrao.IsEmpty) then
              lCampo := 'coalesce('+lCampoOrigem+', '+FValorPadrao.QuotedString+')'
            else
              lCampo := lCampoOrigem;
            lCampo := Format('substring(cast(%s as varchar(20)) from 1 for %d)', [lCampo, FTamanhoMaximo]);
          end;
          3, 4: begin //Data e Data & Hora -> Texto
            if not (FValorPadrao.IsEmpty) then
              lCampo := 'coalesce('+lCampoOrigem+', '+ IfThen(ContainsText(UpperCase(FValorPadrao), 'CURRENT'), FValorPadrao, FValorPadrao.QuotedString) +')'
            else
              lCampo := lCampoOrigem;
            lCampo := Format('substring(cast(%s as varchar(25)) from 1 for %s)', [lCampo, FTamanhoMaximo]);
          end;
        end;

      end;
      1: begin // -> Inteiro
        if FCampoOrigem.IsEmpty then
          lCampo := FValorPadrao
        else
        begin
          case StrToInt(FTipoOrigem) of
            1: begin // Inteiro -> Inteiro
              if not (FValorPadrao.IsEmpty) then
                lCampo := 'coalesce('+lCampoOrigem+', '+FValorPadrao+')'
              else
                lCampo := lCampoOrigem;
            end;
            2: begin // Numerico -> Inteeiro
              if not (FValorPadrao.IsEmpty) then
                lCampo := 'coalesce('+lCampoOrigem+', '+FValorPadrao+')'
              else
                lCampo := lCampoOrigem;
              lCampo := Format('cast(%s as int)', [lCampo]);
            end;
          end;
        end;
      end;
      2: begin // -> Numerico
        if FCampoOrigem.IsEmpty then
          lCampo := FValorPadrao
        else
        begin
          case StrToInt(FTipoOrigem) of
            1, 2: begin //Inteiro, Numerico -> Numerico
              if not (FValorPadrao.IsEmpty) then
                lCampo := 'coalesce('+lCampoOrigem+', '+FValorPadrao+')'
              else
                lCampo := lCampoOrigem;
            end;
          end;
        end;
      end;
      3: begin // -> Data
        if FCampoOrigem.IsEmpty then
          lCampo := IfThen(ContainsText(UpperCase(FValorPadrao), 'CURRENT'), FValorPadrao, FValorPadrao.QuotedString)
        else
        begin
          case StrToInt(FTipoOrigem) of
            3, 4: begin //Data, Timestamp -> Data
              if not (FValorPadrao.IsEmpty) then
                lCampo := 'coalesce('+lCampoOrigem+', '+
                  IfThen(ContainsText(UpperCase(FValorPadrao), 'CURRENT'),
                    FValorPadrao,
                    FValorPadrao.QuotedString)
                +')'
              else
                lCampo := lCampoOrigem;
              lCampo := Format('cast(%s as date)', [lCampo]);
            end;
          end;
        end;
      end;
      4: begin // -> Timestamp
        if FCampoOrigem.IsEmpty then
          lCampo := IfThen(ContainsText(UpperCase(FValorPadrao), 'CURRENT'), FValorPadrao, FValorPadrao.QuotedString)
        else
        begin
          case StrToInt(FTipoOrigem) of
            3, 4: begin //Data, Timestamp -> Timestamp
              if not (FValorPadrao.IsEmpty) then
                lCampo := 'coalesce('+lCampoOrigem+', '+
                  IfThen(ContainsText(UpperCase(FValorPadrao), 'CURRENT'),
                    FValorPadrao,
                    FValorPadrao.QuotedString)
                +')'
              else
                lCampo := lCampoOrigem;
              lCampo := Format('cast(%s as timestamp)', [lCampo]);
            end;
          end;
        end;
      end;
      5: begin // -> Blob texto
        if FCampoOrigem.IsEmpty then
          lCampo := QuotedStr(FValorPadrao)
        else
          lCampo := Format('cast(%s AS BLOB SUB_TYPE 1 SEGMENT SIZE %d)', [lCampoOrigem, FTamanhoMaximo]);
      end;
    end;
    lCampo := lCampo + ' as '+FCampoDestino;
    Result := lCampo;
  end
  else
    Result := FMascaraConversao;
end;

class function TPluginLinkTabela.Novo(ATabelaOrigem, ACampoOrigem, ATipoOrigem,
  ACampoDestino, ATipoDestino, AValorPadrao, APermiteNulo, AMascaraConversao: string;
  ATamanhoMaximo: integer; AChavePrimaria: boolean): TPluginLinkTabela;
begin
  Result := Self.Create;
  Result.FTabelaOrigem := ATabelaOrigem;
  Result.FCampoOrigem := ACampoOrigem;
  Result.FTipoOrigem := ATipoOrigem;
	Result.FCampoDestino := ACampoDestino;
	Result.FTipoDestino := ATipoDestino;
	Result.FTamanhoMaximo := ATamanhoMaximo;
	Result.FValorPadrao := AValorPadrao;
	Result.FPermiteNulo := APermiteNulo;
  Result.FMascaraConversao := AMascaraConversao;
  Result.FChavePrimaria := AChavePrimaria;
end;

function TPluginLinkTabela.Salvar: string;
var
  vJsonResposta: TJSONObject;
begin
  try
    vJsonResposta := TJSONObject.Create
      .AddPair('tabelaorigem', FTabelaOrigem)
      .AddPair('campoorigem', FCampoOrigem)
      .AddPair('tipoorigem', FTipoOrigem)
      .AddPair('campodestino', FCampoDestino)
      .AddPair('tipodestino', FTipoDestino)
      .AddPair('tamanhomaximo', IntToStr(FTamanhoMaximo))
      .AddPair('valorpadrao', FValorPadrao)
      .AddPair('permitenulo', FPermiteNulo)
      .AddPair('mascaraconversao', FMascaraConversao)
      .AddPair('chaveprimaria', IfThen(FChavePrimaria, 'S', 'N'));
    Result := vJsonResposta.ToJSON;
  finally
    vJsonResposta.Free;
  end;
end;

{ TPluginLinkJoin }

constructor TPluginLinkJoin.Create;
begin
  FJoin := '';
  FTipo := '';
  FCondicao := '';
end;

function TPluginLinkJoin.MontaJoin: string;
begin
  Result := Format(' %s join %s on %s ', [FTipo, FJoin, FCondicao]);
end;

class function TPluginLinkJoin.Novo(AJoin, ATipo,
  ACondicao: string): TPluginLinkJoin;
begin
  Result := TPluginLinkJoin.Create;
  Result.FJoin := AJoin;
  Result.FTipo := ATipo;
  Result.FCondicao := ACondicao;
end;

function TPluginLinkJoin.Salvar: string;
var
  vJsonResposta: TJSONObject;
begin
  try
    vJsonResposta := TJSONObject.Create
      .AddPair('join', FJoin)
      .AddPair('tipo', FTipo)
      .AddPair('condicao', FCondicao);
    Result := vJsonResposta.ToJSON;
  finally
    vJsonResposta.Free;
  end;
end;

end.
