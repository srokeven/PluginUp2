unit plugin.controller.tables;

interface

uses uUtils, System.JSON, System.SysUtils, System.Generics.Collections, System.StrUtils;

type
  TTypeField = (tfVarchar, tfInteger, tfFloat, tfDate, tfDateTime, tfBlob);
  TPluginTablesFields = class
  private
    FCampo: string;
    FTipo: TTypeField;
    FTamanho: integer;
    FChavePrimaria: boolean;
    FChaveEstrangeira: boolean;
    FChaveEstrangeiraNomeTabela: string;
    FPermiteNull: boolean;
    FValorPadrao: string;
    function TypeFieldToInt(Value: TTypeField): integer;
    function IntToTypeField(Value: integer): TTypeField;
  public
    constructor Create(AJson: string);
    function Salvar: string;
    class function Novo(AJson: string): TPluginTablesFields;
  end;

  TPluginTables = class
  private
    FTabela: string;
    FSistema: string;
    FCampos: TObjectList<TPluginTablesFields>;
  public
    constructor Create;
    destructor destroy; override;
    procedure LoadFromFile(AFile: string);
    function Salvar: string;
    function SalvarArquivo: boolean;
    procedure SetTabela(AValue: string);
    procedure SetSistema(AValue: string);
    procedure AddCampo(ACampo: string; ATipo, ATamanho: integer; AChavePrimaria, AChaveEstrangeira: boolean;
      AChaveEstrangeiraNomeTabela: string; APermiteNulo: boolean; AValorPadrao: string);
    function StrTypeFieldsToIntTypeFields(AValue: string): integer;
  end;

implementation

{ TPluginTables }

procedure TPluginTables.AddCampo(ACampo: string; ATipo, ATamanho: integer;
  AChavePrimaria, AChaveEstrangeira: boolean;
  AChaveEstrangeiraNomeTabela: string; APermiteNulo: boolean;
  AValorPadrao: string);
var
  lCampo: TJSONObject;
begin
  try
    lCampo := TJSONObject.Create
      .AddPair('campo', ACampo)
      .AddPair('tipo', ATipo.ToString)
      .AddPair('tamanho', ATamanho.ToString)
      .AddPair('chaveprimaria', IfThen(AChavePrimaria, 'S', 'N'))
      .AddPair('chaveestrangeira', IfThen(AChaveEstrangeira, 'S', 'N'))
      .AddPair('chaveestrangeiranometabela', AChaveEstrangeiraNomeTabela)
      .AddPair('permitenulo', IfThen(APermiteNulo, 'S', 'N'))
      .AddPair('valorpadrao', AValorPadrao);
    FCampos.Add(TPluginTablesFields.Novo(lCampo.ToJSON));
  finally
    lCampo.Free;
  end;
end;

constructor TPluginTables.Create;
begin
  FCampos := TObjectList<TPluginTablesFields>.Create;
end;

destructor TPluginTables.destroy;
begin
  FCampos.Free;
  inherited;
end;

procedure TPluginTables.LoadFromFile(AFile: string);
begin

end;

function TPluginTables.Salvar: string;
var
  vJsonResposta: TJSONObject;
  vJsonRespostaArray: TJSONArray;
  I: integer;
begin
  try
    vJsonResposta := TJSONObject.Create
      .AddPair('tabela', FTabela)
      .AddPair('sistema', FSistema);

    vJsonRespostaArray := TJSONArray.Create;
    for I := 0 to FCampos.Count - 1 do
    begin
      if Assigned(FCampos.Items[I]) then
        vJsonRespostaArray.Add(TJSONObject.ParseJSONValue(FCampos.Items[I].Salvar) as TJSONObject);
    end;
    vJsonResposta.AddPair('campos', vJsonRespostaArray);
    Result := vJsonResposta.ToJSON;
  finally
    vJsonResposta.Free;
  end;
end;

function TPluginTables.SalvarArquivo: boolean;
var
  lNomeArquivo: string;
begin
  Result := False;
  lNomeArquivo := IncludeTrailingPathDelimiter(DirTabelas)+FTabela+'.json';
  if FileExists(lNomeArquivo) then
    if not (ShowQuestion('Deseja substituir o registro da tabela "'+FTabela+'" existente?')) then
      Exit(False);
  GravarArrayJsonToFile(Salvar, lNomeArquivo);
  Result := True;
end;

procedure TPluginTables.SetTabela(AValue: string);
begin
  FTabela := AValue;
end;

procedure TPluginTables.SetSistema(AValue: string);
begin
  FSistema := AValue;
end;

function TPluginTables.StrTypeFieldsToIntTypeFields(AValue: string): integer;
begin
  if AValue = 'BLOB' then
    Result := 5;
  if AValue = 'CHAR' then
    Result := 0;
  if AValue = 'CSTRING' then
    Result := 0;
  if AValue = 'D_FLOAT' then
    Result := 2;
  if AValue = 'DOUBLE' then
    Result := 2;
  if AValue = 'FLOAT' then
    Result := 2;
  if AValue = 'INT64' then
    Result := 1;
  if AValue = 'DECIMAL' then
    Result := 2;
  if AValue = 'INTEGER' then
    Result := 1;
  if AValue = 'SMALLINT' then
    Result := 1;
  if AValue = 'DATE' then
    Result := 3;
  if AValue = 'TIME' then
    Result := 4;
  if AValue = 'TIMESTAMP' then
    Result := 4;
  if AValue = 'VARCHAR' then
    Result := 0;
  if AValue = 'UNKNOWN' then
    Result := 0;
end;

{ TPluginTablesFields }

constructor TPluginTablesFields.Create(AJson: string);
begin
  FCampo := LerJson(AJson, 'campo');
  FTipo := IntToTypeField(StrToIntDef(LerJson(AJson, 'tipo'), 0));
  FTamanho := StrToIntDef(LerJson(AJson, 'tamanho'), 0);
  FChavePrimaria := LerJson(AJson, 'chaveprimaria') = 'S';
  FChaveEstrangeira := LerJson(AJson, 'chaveestrangeira') = 'S';
  FChaveEstrangeiraNomeTabela := LerJson(AJson, 'chaveestrangeiranometabela');
  FPermiteNull := LerJson(AJson, 'permitenulo') = 'S';
  FValorPadrao := LerJson(AJson, 'valorpadrao');
end;

function TPluginTablesFields.IntToTypeField(Value: integer): TTypeField;
begin
  case Value of
    0: Result := tfVarchar;
    1: Result := tfInteger;
    2: Result := tfFloat;
    3: Result := tfDate;
    4: Result := tfDateTime;
    5: Result := tfBlob;
  end;
end;

class function TPluginTablesFields.Novo(AJson: string): TPluginTablesFields;
begin
  Result := Self.Create(AJson);
end;

function TPluginTablesFields.Salvar: string;
var
  vJsonResposta: TJSONObject;
begin
  try
    vJsonResposta := TJSONObject.Create
      .AddPair('campo', FCampo)
      .AddPair('tipo', IntToStr(TypeFieldToInt(FTipo)))
      .AddPair('tamanho', FTamanho.ToString)
      .AddPair('chaveprimaria', IfThen(FChavePrimaria, 'S', 'N'))
      .AddPair('chaveestrangeira', IfThen(FChaveEstrangeira, 'S', 'N'))
      .AddPair('chaveestrangeiranometabela', FChaveEstrangeiraNomeTabela)
      .AddPair('permitenulo', IfThen(FPermiteNull, 'S', 'N'))
      .AddPair('valorpadrao', FValorPadrao);
    Result := vJsonResposta.ToJSON;
  finally
    vJsonResposta.Free;
  end;
end;

function TPluginTablesFields.TypeFieldToInt(Value: TTypeField): integer;
begin
  case Value of
    tfVarchar: Result := 0;
    tfInteger: Result := 1;
    tfFloat: Result := 2;
    tfDate:Result := 3;
    tfDateTime: Result := 4;
    tfBlob: Result := 5;
  end;
end;

end.
