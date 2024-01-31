unit uUtils;

interface

uses
  Inifiles, System.SysUtils, System.JSON, System.Classes, System.DateUtils,
  Vcl.Forms, Winapi.Windows, System.StrUtils, System.Math;

  //Manipulação de arquivos
  procedure GravarIni(ASecao, AIdent, AValor, AIniFile: string);
  function LerIni(ASecao, AIdent, AValorDefault, AIniFile: string): string;
  procedure GravaLog(ALog, AFileName: string);
  function LerTextFromFile(AFile: string): string;
  procedure CriarPastasPadronizadas;
  function DirLocal: string;
  function DirBancoDeDados: string;
  function DirTabelas: string;
  function DirSchemas: string;
  function DirSchemasMigracao: string;
  function DirConsultas: string;
  function DirConsultasPendentes: string;
  function DirConsultasHistorico: string;

  //Manipulação de JSON
  function LerJson(aJson, aIdent: string): string;  //Retorna um valor de um parametro de json
  function LerJsonFromJson(aJson, aIdent: string): string;  //Retorna um objecto json de um parametro de json
  function LerJsonArray(aJson, aNameArray: string): string; //Retorna um string de um array de json de um objeto
  function LerJsonFromArrayJson(aJson: string; aIndex: integer): string;   //Retorna um json dentro de um array de json
  function IsJSONValid(const jsonString: string): Boolean; //Verifica se o json é valido

  //Manipulação de arquivos de json
  function LerJsonFromFile(const FileName: string): string; //Retorna todo o conteudo de um arquivo de json
  function LerArrayJsonFromFile(const FileName: string): string; //Retorna todo o conteudo de um arquivo de array de json
  procedure GravarArrayJsonToFile(const JSON: string; const FileName: string); //Grva um arquivo de texto com o conteudo de um array de json

  //Tradução de constantes
  function LogTypeToString(AType: integer): string;
  function DateToSQLDateTime(aDateTime: TDateTime; aTipo: integer = 0;
  aPosicao: integer = 0): string;

  //Calculos matematicos
  function CalculaOValorEquivalenteAPorcentagemSobreValor(aPercent, aValue: double): double;
  function RetornaTempoExecucao(AInicio, AFim: TDateTime): string;

  //Criptografia simples
  function Crypt(aParam: integer; aTexto: String): String;

  //Mensagens
  function ShowQuestion(const aMsg: string; aTitulo:String = 'Importante'; aPreSelect: integer = 0): boolean;
  procedure ShowWarning(const aMsg: string; aTitulo:String = 'Aviso');

  //Manipular textos
  function ExtrairTextoAPartirDePosicao(aTexto, aTrecho: string; aDirecao: integer): string;
  function ExtrairTabelaJoin(ACampo: string): string;
  function ExtrairCampoJoin(ACampo: string): string;

const
  LOG_ENTADA = 0;
  LOG_SAIDA = 1;
  LOG_OPERACIONAL = 2;
  LOG_ERROR = 3;
  DO_ENCPT = 0;
  DO_DECPT = 1;
  EXTRAIR_PRE_TRECHO = 0;
  EXTRAIR_TRECHO = 1;
  EXTRAIR_POS_TRECHO = 2;


implementation

procedure GravarIni(ASecao, AIdent, AValor, AIniFile: string);
var
  vIni: TIniFile;
begin
  vIni := TIniFile.Create(AIniFile);
  try
    vIni.WriteString(ASecao, AIdent, AValor);
  finally
    vIni.Free;
  end;
end;

function LerIni(ASecao, AIdent, AValorDefault, AIniFile: string): string;
var
  vIni: TIniFile;
begin
  vIni := TIniFile.Create(AIniFile);
  try
    Result := vIni.ReadString(ASecao, AIdent, AValorDefault);
  finally
    vIni.Free;
  end;
end;

procedure GravaLog(ALog, AFileName: string);
var
  arq: TextFile;
  vDiretorio: string;
begin
  try
    vDiretorio := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'logs';
    if not DirectoryExists(vDiretorio) then
      ForceDirectories(vDiretorio);
    AssignFile(arq, IncludeTrailingPathDelimiter(vDiretorio)+AFileName+FormatDateTime('ddMMyyyy',Date)+'.txt');
    {$I-}
    Reset(arq);
    {$I+}
    if (IOResult <> 0)
       then Rewrite(arq) { arquivo não existe e será criado }
    else begin
           CloseFile(arq);
           Append(arq); { o arquivo existe e será aberto para saídas adicionais }
         end;
    WriteLn(Arq, Format('Data: %s -- Log: %s',
                        [FormatDateTime('dd/MM/yyyy hh:mm:ss', Now),
                        ALog]));
    CloseFile(Arq);
  except

  end;
end;

function LerTextFromFile(AFile: string): string;
var
  lArquivo: TStringList;
  arq: TextFile;
  linha: string;
begin
  if not FileExists(AFile) then
    Exit('');
  lArquivo := TStringList.Create;
  try
    AssignFile(arq, AFile);
    {$I-}         // desativa a diretiva de Input
    Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
    {$I+}         // ativa a diretiva de Input
    if (IOResult <> 0) then
      lArquivo.Add('')
    else
    begin
      while (not Eof(arq)) do
      begin
        readln(arq, linha);
        lArquivo.Add(linha);
      end;
      CloseFile(arq);
    end;
    Result := lArquivo.Text;
  finally
    lArquivo.Free;
  end;
end;

procedure CriarPastasPadronizadas;
begin
  if not (DirectoryExists(DirBancoDeDados)) then
    ForceDirectories(DirBancoDeDados);

  if not (DirectoryExists(DirTabelas)) then
    ForceDirectories(DirTabelas);

  if not (DirectoryExists(DirSchemas)) then
    ForceDirectories(DirSchemas);

  if not (DirectoryExists(DirSchemasMigracao)) then
    ForceDirectories(DirSchemasMigracao);

  if not (DirectoryExists(DirConsultas)) then
    ForceDirectories(DirConsultas);

  if not (DirectoryExists(DirConsultasPendentes)) then
    ForceDirectories(DirConsultasPendentes);

  if not (DirectoryExists(IncludeTrailingPathDelimiter(DirConsultas)+'historico')) then
    ForceDirectories(IncludeTrailingPathDelimiter(DirConsultas)+'historico');
end;

function DirLocal: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function DirBancoDeDados: string;
begin
  Result := IncludeTrailingPathDelimiter(DirLocal)+'bancodedados';
end;

function DirTabelas: string;
begin
  Result := IncludeTrailingPathDelimiter(DirBancoDeDados)+'tabelas';
end;

function DirSchemas: string;
begin
  Result := IncludeTrailingPathDelimiter(DirLocal)+'schemas';
end;

function DirSchemasMigracao: string;
begin
  Result := IncludeTrailingPathDelimiter(DirLocal)+'schemas_migracao';
end;

function DirConsultas: string;
begin
  Result := IncludeTrailingPathDelimiter(DirLocal)+'consultas';
end;

function DirConsultasPendentes: string;
begin
  Result := IncludeTrailingPathDelimiter(DirConsultas)+'pendentes';
end;

function DirConsultasHistorico: string;
begin
  Result := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(DirConsultas)+'historico')+FormatDateTime('ddmmyyyy', Date);
  if not (DirectoryExists(Result)) then
    ForceDirectories(Result);
end;

function LerJson(aJson, aIdent: string): string;
var
  Obj: TJSONObject;
begin //Retorna um valor de um json simples
  Result := '';
  if (aJson.IsEmpty) or (aJson = '[]') or (aJson = '{}') then
    Exit;
  if not (aIdent.IsEmpty) then
  begin
    Obj := TJSONObject.ParseJSONValue(aJson) as TJSONObject;
    try
      try
        Result := Obj.GetValue<string>(aIdent.ToLower, '');
        if Result = '' then
          Result := Obj.GetValue<string>(aIdent.ToUpper, '');
      except
      end;
    finally
      Obj.Free;
    end;
  end;
end;

function LerJsonFromJson(aJson, aIdent: string): string;
var
  vObj: TJSONObject;
begin
  if aJson.IsEmpty then
  begin
    Result := '{}';
    Exit;
  end;
  vObj := nil;
  try
    vObj := TJSONObject.ParseJSONValue(aJson) as TJSONObject;
    Result := vObj.GetValue<TJSONObject>(aIdent).ToJSON;
    vObj.Free;
  except on E: Exception do
    begin
      Result := '{}';
      vObj.Free;
    end;
  end;
end;

function LerJsonArray(aJson, aNameArray: string): string;
var
  vObj: TJSONObject;
begin
  if aJson.IsEmpty then
  begin
    Result := '[]';
    Exit;
  end;
  vObj := nil;
  try
    vObj := TJSONObject.ParseJSONValue(aJson) as TJSONObject;
    Result := vObj.GetValue<TJSONArray>(aNameArray).ToJSON;
    vObj.Free;
  except on E: Exception do
    begin
      Result := '[]';
      vObj.Free;
    end;
  end;
end;

function LerJsonFromArrayJson(aJson: string; aIndex: integer): string;
var
  vArray: TJSONArray;
begin
  Result := '';
  if (aJson.IsEmpty) or (aJson = '[]') or (aJson = '{}') then
    Exit;
  try
    vArray := TJSONObject.ParseJSONValue(aJson) as TJSONArray;
    Result := (vArray.Items[aIndex] as TJSONObject).ToJSON;
    vArray.Free;
  except on E: Exception do
    begin
      Result := '{}';
      vArray.Free;
    end;
  end;
end;

function IsJSONValid(const jsonString: string): Boolean;
var
  jsonValue: TJSONValue;
begin
  Result := False;

  try
    jsonValue := TJSONObject.ParseJSONValue(jsonString);
    Result := Assigned(jsonValue);
    FreeAndNil(jsonValue);
  except
    // Se ocorrer uma exceção ao analisar a string JSON, significa que não é válido
    if Assigned(jsonValue) then
      FreeAndNil(jsonValue);
    Result := False;
  end;
end;

function LerJsonFromFile(const FileName: string): string;
var
  JSONText: string;
  vObjectJson: TJSONObject;
  FileStream: TFileStream;
begin
  if not FileExists(FileName) then
    Exit('');

  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    SetLength(JSONText, FileStream.Size div SizeOf(Char));
    FileStream.ReadBuffer(JSONText[1], FileStream.Size);
  finally
    FileStream.Free;
  end;
  if not (JSONText.IsEmpty) then
  begin
    vObjectJson := TJSONObject.ParseJSONValue(JSONText) as TJSONObject;
    Result := vObjectJson.ToJSON;
    vObjectJson.Free;
  end;
end;

function LerArrayJsonFromFile(const FileName: string): string;
var
  JSONText: string;
  FileStream: TFileStream;
  vJsonArray: TJSONArray;
begin
  if not FileExists(FileName) then
    Exit('[]');

  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    SetLength(JSONText, FileStream.Size div SizeOf(Char));
    FileStream.ReadBuffer(JSONText[1], FileStream.Size);
  finally
    FileStream.Free;
  end;

  vJsonArray := TJSONObject.ParseJSONValue(JSONText) as TJSONArray;
  Result := vJsonArray.ToJSON;
  vJsonArray.Free;
end;

procedure GravarArrayJsonToFile(const JSON: string; const FileName: string);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    FileStream.WriteBuffer(JSON[1], Length(JSON) * SizeOf(Char));
  finally
    FileStream.Free;
  end;
end;

function LogTypeToString(AType: integer): string;
begin
  case AType of
    LOG_ENTADA: Result := '>>>';
    LOG_SAIDA: Result := '<<<';
    LOG_OPERACIONAL: Result := '===';
    LOG_ERROR: Result := '@@@';
  end;
end;

function DateToSQLDateTime(aDateTime: TDateTime; aTipo: integer = 0;
  aPosicao: integer = 0): string;
begin
  if aTipo = 1 then
    Result := FormatDateTime('yyyy-mm-dd', aDateTime)
  else if aTipo = 0 then
    Result := FormatDateTime('yyyy-mm-dd', aDateTime)+
      IfThen(aPosicao = 0, FormatDateTime(' hh:nn:ss', aDateTime), IfThen(aPosicao = 1, ' 00:00:00', ' 23:59:59'));
  Result := QuotedStr(Result);
end;

function CalculaOValorEquivalenteAPorcentagemSobreValor(aPercent,
  aValue: double): double;
begin
  if (aPercent > 0) and (aValue > 0) then
    Result := ((aPercent / 100 + 1) * aValue) - aValue
  else
    Result := 0;
end;

function RetornaTempoExecucao(AInicio, AFim: TDateTime): string;
var
  TempoDecorrido: TDateTime;
begin
  TempoDecorrido := AFim - AInicio;
  Result := FormatDateTime('hh "horas", nn "minutos", ss "segundos" e zzz "milissegundos"', TempoDecorrido);
end;

function Crypt(aParam: integer; aTexto: String): String;
Label Fim;
var KeyLen : Integer;
	KeyPos : Integer;
	OffSet : Integer;
	Dest, Key : String;
	SrcPos : Integer;
	SrcAsc : Integer;
	TmpSrcAsc : Integer;
	Range : Integer;
begin
	if (aTexto = '') Then
	begin
		Result:= '';
		Goto Fim;
	end;
	Key := 'YUQL2OKEMFWROWFMO439ROKMWERF984M940MWMKFMWELRJW89WJ43M2KWOELRM498J54MREWWML22KHGH8IHKKBNBDKJ';
	Dest := '';
	KeyLen := Length(Key);
	KeyPos := 0;
	SrcPos := 0;
	SrcAsc := 0;
	Range := 256;
	if (aParam = DO_ENCPT) then
	begin
		Randomize;
		OffSet := Random(Range);
		Dest := Format('%1.2x',[OffSet]);
		for SrcPos := 1 to Length(aTexto) do
		begin
			{Application.ProcessMessages;}
			SrcAsc := (Ord(aTexto[SrcPos]) + OffSet) Mod 255;
			if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;

			SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
			Dest := Dest + Format('%1.2x',[SrcAsc]);
			OffSet := SrcAsc;
		end;
	end
	Else if (aParam = DO_DECPT) then
	begin
		OffSet := StrToInt('$' + copy(atexto,1,2));
		SrcPos := 3;
		repeat
			SrcAsc := StrToInt('$' + copy(aTexto,SrcPos,2));
			if (KeyPos < KeyLen) Then KeyPos := KeyPos + 1 else KeyPos := 1;
			TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
			if TmpSrcAsc <= OffSet then TmpSrcAsc := 255 + TmpSrcAsc - OffSet
			else TmpSrcAsc := TmpSrcAsc - OffSet;
			Dest := Dest + Chr(TmpSrcAsc);
			OffSet := SrcAsc;
			SrcPos := SrcPos + 2;
		until (SrcPos >= Length(aTexto));
	end;
	Result:= Dest;
  Fim:
end;

function ShowQuestion(const aMsg: string; aTitulo:String = 'Importante'; aPreSelect: integer = 0): boolean;
begin
  Result := (Application.MessageBox(PWideChar(aMsg), PWideChar(aTitulo),
    MB_ICONQUESTION + MB_YESNO + IfThen(aPreSelect = 0, MB_DEFBUTTON2, MB_DEFBUTTON1)) = IDYES);
end;

procedure ShowWarning(const aMsg: string; aTitulo:String = 'Aviso');
begin
  Application.MessageBox(PWideChar(aMsg), PWideChar(aTitulo), MB_ICONWARNING + MB_OK);
end;

function ExtrairTextoAPartirDePosicao(aTexto, aTrecho: string; aDirecao: integer): string;
begin
  Result := '';
  if not (aTexto.IsEmpty) then
  begin
    if pos(aTrecho, aTexto) > 0 then
    begin
      case aDirecao of
        EXTRAIR_PRE_TRECHO: Result := copy(aTexto, 1, pos(aTrecho, aTexto)-1);
        EXTRAIR_TRECHO: Result := copy(aTexto, 1, pos(aTrecho, aTexto)) + copy(aTexto, pos(aTrecho, aTexto)+Length(aTrecho), Length(aTexto));
        EXTRAIR_POS_TRECHO: Result := copy(aTexto, pos(aTrecho, aTexto)+Length(aTrecho), Length(aTexto));
      end;
    end;
  end;
end;

function ExtrairTabelaJoin(ACampo: string): string;
begin
  Result := '';
  if Pos('.', ACampo) > 0 then
    Result := ExtrairTextoAPartirDePosicao(ACampo, '.', EXTRAIR_PRE_TRECHO);
end;

function ExtrairCampoJoin(ACampo: string): string;
begin
  Result := '';
  if Pos('.', ACampo) > 0 then
    Result := ExtrairTextoAPartirDePosicao(ACampo, '.', EXTRAIR_POS_TRECHO);
end;

end.
