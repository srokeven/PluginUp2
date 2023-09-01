object dmService: TdmService
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'dmService'
  BeforeInstall = ServiceBeforeInstall
  OnContinue = ServiceContinue
  OnPause = ServicePause
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
