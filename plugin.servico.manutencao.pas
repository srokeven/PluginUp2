unit plugin.servico.manutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Param, uUtils, plugin.monitoramento.datamodule, uApi,
  FileSearchUnit, udmAPI, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfmServicos = class(TForm)
    pcPrincipal: TPageControl;
    tsRetorno: TTabSheet;
    pnlSideBar: TPanel;
    pnlBackground: TPanel;
    btnStatus: TButton;
    btnIniciar: TButton;
    btnParar: TButton;
    btnLog: TButton;
    mmResposta: TMemo;
    Label1: TLabel;
    edPorta: TEdit;
    edHost: TEdit;
    Label2: TLabel;
    btnListaLogs: TButton;
    Bevel1: TBevel;
    Label3: TLabel;
    edDataLog: TcxDateEdit;
    chkAutoRefresh: TCheckBox;
    tmAutoRefresh: TTimer;
    chkAutoRefreshLog: TCheckBox;
    chkLimpaLog: TCheckBox;
    tmAutoRefreshLog: TTimer;
    procedure btnTesteAtualClick(Sender: TObject);
    procedure btnIniciarDebugClick(Sender: TObject);
    procedure btnStatusClick(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnListaLogsClick(Sender: TObject);
    procedure tmAutoRefreshTimer(Sender: TObject);
    procedure tmAutoRefreshLogTimer(Sender: TObject);
    procedure chkAutoRefreshClick(Sender: TObject);
    procedure chkAutoRefreshLogClick(Sender: TObject);
  private
    FdmMonitoramento: TdmMonitoramento;
    FSkip: integer;
    function Post(AHost, APorta, ARecurso: string): string;
    function PostWin10(AHost, APorta, ARecurso: string): string;
    function PostWin7(AHost, APorta, ARecurso: string): string;

    function Get(AHost, APorta, ARecurso: string): string;
    function GetWin10(AHost, APorta, ARecurso: string): string;
    function GetWin7(AHost, APorta, ARecurso: string): string;
  public
    { Public declarations }
  end;

var
  fmServicos: TfmServicos;

implementation

{$R *.dfm}

procedure TfmServicos.btnIniciarClick(Sender: TObject);
begin
  if (edHost.Text = '') and (edPorta.Text = '') then
  begin
    FdmMonitoramento := TdmMonitoramento.Create(Self);
    FdmMonitoramento.Iniciar;
  end
  else
  begin
    mmResposta.Lines.Add(Get(edHost.Text, edPorta.Text, 'iniciar'));
    GravarIni('GERAL', 'PORTA_GERENCIAL', edPorta.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
    GravarIni('GERAL', 'HOST', edHost.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  end;
end;

procedure TfmServicos.btnIniciarDebugClick(Sender: TObject);
begin
  FdmMonitoramento.Iniciar;
end;

procedure TfmServicos.btnListaLogsClick(Sender: TObject);
begin
  if Assigned(FdmMonitoramento) then
  begin
    mmResposta.Lines.Add(FdmMonitoramento.GetListLogs(10, FSkip));
  end else
  begin
    mmResposta.Lines.Add(Post(edHost.Text, edPorta.Text, '/logs/'+FSkip.ToString+'/10'));
  end;
  FSkip := FSkip + 10;
end;

procedure TfmServicos.btnLogClick(Sender: TObject);
begin
  tmAutoRefreshLog.Enabled := chkAutoRefreshLog.Checked;
  if Assigned(FdmMonitoramento) then
  begin
    if chkLimpaLog.Checked then
      mmResposta.Lines.Text := FdmMonitoramento.GetLog(edDataLog.Date)
    else
      mmResposta.Lines.Add(FdmMonitoramento.GetLog(edDataLog.Date));
  end else
  begin
    if chkLimpaLog.Checked then
      mmResposta.Lines.Text := Post(edHost.Text, edPorta.Text, '/log/'+FormatDateTime('ddmmyyyy', edDataLog.Date))
    else
      mmResposta.Lines.Add(Post(edHost.Text, edPorta.Text, '/log/'+FormatDateTime('ddmmyyyy', edDataLog.Date)));
  end;
end;

procedure TfmServicos.btnPararClick(Sender: TObject);
begin
  if Assigned(FdmMonitoramento) then
  begin
    FdmMonitoramento.Parar;
    FreeAndNil(FdmMonitoramento);
  end else
    mmResposta.Lines.Add(Get(edHost.Text, edPorta.Text, 'parar'));
end;

procedure TfmServicos.btnStatusClick(Sender: TObject);
begin
  tmAutoRefresh.Enabled := chkAutoRefresh.Checked;

  if Assigned(FdmMonitoramento) then
  begin
    mmResposta.Lines.Add(FdmMonitoramento.GetStatus);
  end else
  mmResposta.Lines.Add(Get(edHost.Text, edPorta.Text, 'status'));
end;

procedure TfmServicos.btnTesteAtualClick(Sender: TObject);
begin
  FdmMonitoramento := TdmMonitoramento.Create(nil);
end;

procedure TfmServicos.chkAutoRefreshClick(Sender: TObject);
begin
  if tmAutoRefresh.Enabled then
    tmAutoRefresh.Enabled := False;
  chkAutoRefreshLog.Checked := False;
end;

procedure TfmServicos.chkAutoRefreshLogClick(Sender: TObject);
begin
  if tmAutoRefreshLog.Enabled then
    tmAutoRefreshLog.Enabled := False;
  chkAutoRefresh.Checked := False;
end;

procedure TfmServicos.FormShow(Sender: TObject);
begin
  edHost.Text := LerIni('GERAL', 'HOST', '127.0.0.1', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edPorta.Text := LerIni('GERAL', 'PORTA_GERENCIAL', '49255', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edDataLog.Date := Date;
  FSkip := 0;
end;

function TfmServicos.Get(AHost, APorta, ARecurso: string): string;
var
  osVersion: TOSVersionInfo;
begin
  //Verificar se é windows 10 ou superior
  // Preenche a estrutura TOSVersionInfo com informações do sistema operacional
  osVersion.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(osVersion);

  // Verifica se é o Windows 10
  if (osVersion.dwMajorVersion >= 10) and (osVersion.dwPlatformId = VER_PLATFORM_WIN32_NT) then
    Result := GetWin10(AHost, APorta, ARecurso)
  else
    Result := GetWin7(AHost, APorta, ARecurso);
end;

function TfmServicos.GetWin10(AHost, APorta, ARecurso: string): string;
var
  lAPI: TAPI;
  lResposta: string;
begin
  if AHost.IsEmpty then
  begin
    ShowWarning('Host não encontrado');
    Exit;
  end;
  if APorta.IsEmpty then
  begin
    ShowWarning('Porta não encontrado');
    Exit;
  end;
  lAPI := TAPI.Create;
  try
    lAPI.Url := 'http://'+AHost+':'+APorta;
    lAPI.Resource := ARecurso;
    lAPI.ClienteAccept := 'text/plain; q=0.9, text/html;q=0.8,';
    lResposta := lAPI.Get;
    Result := lResposta;
  finally
    lAPI.Free;
  end;
end;

function TfmServicos.GetWin7(AHost, APorta, ARecurso: string): string;
var
  lAPI: TdmAPI;
  lResposta: string;
begin
  if AHost.IsEmpty then
  begin
    ShowWarning('Host não encontrado');
    Exit;
  end;
  if APorta.IsEmpty then
  begin
    ShowWarning('Porta não encontrado');
    Exit;
  end;
  lAPI := TdmAPI.Create(nil);
  try
    lAPI.ContentType('text/plain; q=0.9, text/html;q=0.8,');
    lAPI.AcceptCharSet('utf-8');
    lAPI.ContentEncoding('text/plain');
    lResposta := lAPI.Get('http://'+AHost+':'+APorta+'/'+ARecurso);
    Result := lResposta;
  finally
    lAPI.Free;
  end;
end;

function TfmServicos.Post(AHost, APorta, ARecurso: string): string;
var
  osVersion: TOSVersionInfo;
begin
  //Verificar se é windows 10 ou superior
  // Preenche a estrutura TOSVersionInfo com informações do sistema operacional
  osVersion.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(osVersion);

  // Verifica se é o Windows 10
  if (osVersion.dwMajorVersion >= 10) and (osVersion.dwPlatformId = VER_PLATFORM_WIN32_NT) then
    Result := PostWin10(AHost, APorta, ARecurso)
  else
    Result := PostWin7(AHost, APorta, ARecurso);
end;

function TfmServicos.PostWin10(AHost, APorta, ARecurso: string): string;
var
  lAPI: TAPI;
  lResposta: string;
begin
  if AHost.IsEmpty then
  begin
    ShowWarning('Host não encontrado');
    Exit;
  end;
  if APorta.IsEmpty then
  begin
    ShowWarning('Porta não encontrado');
    Exit;
  end;
  lAPI := TAPI.Create;
  try
    lAPI.Url := 'http://'+AHost+':'+APorta;
    lAPI.Resource := ARecurso;
    lAPI.ClienteAccept := 'text/plain; q=0.9, text/html;q=0.8,';
    lResposta := lAPI.Post;
    Result := lResposta;
  finally
    lAPI.Free;
  end;
end;

function TfmServicos.PostWin7(AHost, APorta, ARecurso: string): string;
var
  lAPI: TdmAPI;
  lResposta: string;
begin
  if AHost.IsEmpty then
  begin
    ShowWarning('Host não encontrado');
    Exit;
  end;
  if APorta.IsEmpty then
  begin
    ShowWarning('Porta não encontrado');
    Exit;
  end;
  lAPI := TdmAPI.Create(nil);
  try
    lAPI.ContentType('text/plain; q=0.9, text/html;q=0.8,');
    lAPI.AcceptCharSet('utf-8');
    lAPI.ContentEncoding('text/plain');
    lResposta := lAPI.Post('http://'+AHost+':'+APorta+'/'+ARecurso);
    Result := lResposta;
  finally
    lAPI.Free;
  end;
end;

procedure TfmServicos.tmAutoRefreshLogTimer(Sender: TObject);
begin
  tmAutoRefreshLog.Enabled := False;
  if Assigned(FdmMonitoramento) then
  begin
    mmResposta.Lines.Add(FdmMonitoramento.GetLog(edDataLog.Date));
  end else
    mmResposta.Lines.Add(Post(edHost.Text, edPorta.Text, '/log/'+FormatDateTime('ddmmyyyy', edDataLog.Date)));
  tmAutoRefreshLog.Enabled := True;
end;

procedure TfmServicos.tmAutoRefreshTimer(Sender: TObject);
begin
  tmAutoRefresh.Enabled := False;
  if Assigned(FdmMonitoramento) then
  begin
    mmResposta.Lines.Add(FdmMonitoramento.GetStatus);
  end else
  mmResposta.Lines.Add(Get(edHost.Text, edPorta.Text, 'status'));
  tmAutoRefresh.Enabled := True;
end;

end.
