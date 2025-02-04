object dmConexao: TdmConexao
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 399
  Width = 575
  object ConexaoOrigem: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 88
    Top = 144
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 80
    Top = 224
  end
  object ConexaoDestino: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    LoginPrompt = False
    Left = 184
    Top = 56
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    LoginPrompt = False
    Left = 280
    Top = 56
  end
  object Scripts: TFDScript
    SQLScripts = <
      item
        Name = 'TABELAS'
        SQL.Strings = (
          'select RDB$RELATION_NAME TABELA '
          'from RDB$RELATIONS '
          'where RDB$SYSTEM_FLAG = 0 '
          'order by RDB$RELATION_NAME;')
      end
      item
        Name = 'CAMPOS'
        SQL.Strings = (
          'select RF.RDB$FIELD_NAME FIELD_NAME,'
          '       case RF.RDB$NULL_FLAG'
          '         when 1 then 1'
          '         else 0'
          '       end as NOT_NULL,'
          
            '       replace(RF.RDB$DEFAULT_SOURCE, '#39'DEFAULT '#39', '#39#39') as DEFAULT' +
            '_VALUE,'
          '       F.RDB$FIELD_LENGTH FIELD_LENGTH,'
          '       F.RDB$FIELD_PRECISION as FIELD_PRECISION,'
          '       abs(F.RDB$FIELD_SCALE) as FIELD_SCALE,'
          '       case F.RDB$FIELD_TYPE'
          '         when 261 then '#39'BLOB'#39
          '         when 14 then '#39'CHAR'#39
          '         when 40 then '#39'CSTRING'#39
          '         when 11 then '#39'D_FLOAT'#39
          '         when 27 then '#39'DOUBLE'#39
          '         when 10 then '#39'FLOAT'#39
          
            '         when 16 then iif(F.RDB$FIELD_PRECISION = 0, '#39'INT64'#39', '#39'D' +
            'ECIMAL'#39')'
          
            '         when 8 then iif(F.RDB$FIELD_PRECISION = 0, '#39'INTEGER'#39', '#39 +
            'DECIMAL'#39')'
          '         when 9 then '#39'QUAD'#39
          '         when 7 then '#39'SMALLINT'#39
          '         when 12 then '#39'DATE'#39
          '         when 13 then '#39'TIME'#39
          '         when 35 then '#39'TIMESTAMP'#39
          '         when 37 then '#39'VARCHAR'#39
          '         else '#39'UNKNOWN'#39
          '       end as FIELD_TYPE,'
          '       T.CONSTRAINT_NAME,'
          '       T.CONSTRAINT_TYPE,'
          '       T.FOREIGN_KEY,'
          '       T.RELATION_NAME'
          'from RDB$RELATION_FIELDS RF'
          'join RDB$FIELDS F on RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME'
          'left join(select RC.RDB$CONSTRAINT_NAME CONSTRAINT_NAME,'
          '                 RC.RDB$CONSTRAINT_TYPE CONSTRAINT_TYPE,'
          '                 I.RDB$FOREIGN_KEY FOREIGN_KEY,'
          '                 RCF.RDB$RELATION_NAME RELATION_NAME,'
          '                 ISG.RDB$FIELD_NAME FIELD_NAME'
          '          from RDB$RELATION_CONSTRAINTS RC'
          
            '          left join RDB$INDICES I on I.RDB$INDEX_NAME = RC.RDB$C' +
            'ONSTRAINT_NAME'
          
            '          left join RDB$RELATION_CONSTRAINTS RCF on RCF.RDB$CONS' +
            'TRAINT_NAME = I.RDB$FOREIGN_KEY'
          
            '          left join RDB$INDEX_SEGMENTS ISG on I.RDB$INDEX_NAME =' +
            ' ISG.RDB$INDEX_NAME'
          '          where RC.RDB$INDEX_NAME is not null and'
          
            '                RC.RDB$RELATION_NAME = :TABELA) T on T.FIELD_NAM' +
            'E = RF.RDB$FIELD_NAME'
          'where RF.RDB$RELATION_NAME = :TABELA'
          'order by RF.RDB$FIELD_NAME asc')
      end
      item
        Name = 'DEPENDENCIAS'
        SQL.Strings = (
          'select RC.RDB$RELATION_NAME TABELA,'
          '       RC.RDB$CONSTRAINT_TYPE CONSTRAINT_TYPE,'
          '       RCF.RDB$RELATION_NAME TABELA_ESTRANGEIRA,'
          '       ISG.RDB$FIELD_NAME CAMPO,'
          '       case RF.RDB$NULL_FLAG'
          '         when 1 then 1'
          '         else 0'
          '       end as NOT_NULL'
          'from RDB$RELATION_CONSTRAINTS RC'
          'join RDB$INDICES I on I.RDB$INDEX_NAME = RC.RDB$CONSTRAINT_NAME'
          
            'join RDB$RELATION_CONSTRAINTS RCF on RCF.RDB$CONSTRAINT_NAME = I' +
            '.RDB$FOREIGN_KEY'
          
            'join RDB$INDEX_SEGMENTS ISG on I.RDB$INDEX_NAME = ISG.RDB$INDEX_' +
            'NAME'
          
            'join RDB$RELATION_FIELDS RF on RF.RDB$FIELD_NAME = ISG.RDB$FIELD' +
            '_NAME and'
          '      RC.RDB$RELATION_NAME = RF.RDB$RELATION_NAME'
          'where RC.RDB$INDEX_NAME is not null and'
          '      RC.RDB$CONSTRAINT_TYPE = '#39'FOREIGN KEY'#39' and'
          '      I.RDB$FOREIGN_KEY is not null')
      end>
    Connection = ConexaoOrigem
    Params = <>
    Macros = <>
    Left = 352
    Top = 200
  end
end
