object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Principal'
  ClientHeight = 402
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object jvpnl1: TJvPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 52
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    FlatBorderColor = clGrayText
    Align = alTop
    BorderStyle = bsSingle
    Caption = 'Cadastro exemplo datasnap'
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Pristina'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object jvstsbr: TJvStatusBar
    Left = 0
    Top = 383
    Width = 526
    Height = 19
    BiDiMode = bdLeftToRight
    Color = clBlack
    Panels = <>
    ParentBiDiMode = False
    SimplePanel = True
  end
  object MainMenu1: TMainMenu
    Left = 144
    Top = 136
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Cliente1: TMenuItem
        Caption = 'Pessoas'
        OnClick = Cliente1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
    object Configuraes1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object Servidordeaplicao1: TMenuItem
        Caption = 'Servidor de aplica'#231#227'o'
        OnClick = Servidordeaplicao1Click
      end
    end
  end
  object jvblnhnt1: TJvBalloonHint
    DefaultIcon = ikNone
    UseBalloonAsApplicationHint = True
    Left = 248
    Top = 136
  end
end
