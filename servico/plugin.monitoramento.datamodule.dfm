object dmMonitoramento: TdmMonitoramento
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 342
  Width = 510
  object tmCiclos: TTimer
    Enabled = False
    Interval = 15000
    OnTimer = tmCiclosTimer
    Left = 56
    Top = 32
  end
end
