object frmListarUsuarios: TfrmListarUsuarios
  Left = 0
  Top = 0
  Caption = 'Listar Usu'#225'rios'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 640
    Height = 25
    Align = alTop
    Alignment = taCenter
    Caption = 'LISTA DE USU'#193'RIOS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 216
  end
  object mmLista: TMemo
    Left = 8
    Top = 168
    Width = 624
    Height = 304
    TabOrder = 0
  end
  inline frmBotaoPrimario1: TfrmBotaoPrimario
    Left = 200
    Top = 96
    Width = 320
    Height = 50
    Color = clWhite
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    ExplicitLeft = 200
    ExplicitTop = 96
    inherited pnlFundo: TPanel
      inherited spbBotaoPrimario: TSpeedButton
        Caption = 'LISTAR USU'#193'RIOS'
        OnClick = frmBotaoPrimario1spbBotaoPrimarioClick
      end
    end
  end
end
