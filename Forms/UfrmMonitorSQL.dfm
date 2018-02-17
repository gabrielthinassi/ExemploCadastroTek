object frmMonitorSQL: TfrmMonitorSQL
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Monitor de SQL'
  ClientHeight = 309
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgcPrincipal: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 678
    Height = 303
    ActivePage = tsID
    Align = alClient
    MultiLine = True
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    object tsID: TTabSheet
      Caption = 'C'#243'digo da conex'#227'o'
      object dbgrdID: TDBGrid
        Left = 0
        Top = 0
        Width = 670
        Height = 275
        Align = alClient
        DataSource = ds1
        DrawingStyle = gdsGradient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = dbgrdIDDblClick
      end
    end
    object tsMonitor: TTabSheet
      Caption = 'Monitor'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 788
      ExplicitHeight = 273
      object mmoSQL: TMemo
        Left = 0
        Top = 0
        Width = 670
        Height = 275
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 788
        ExplicitHeight = 273
      end
    end
  end
  object sqlMonitor: TSQLMonitor
    OnTrace = sqlMonitorTrace
    Left = 192
    Top = 96
  end
  object ds1: TDataSource
    DataSet = cds1
    Left = 71
    Top = 99
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 127
    Top = 99
  end
end
