object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 544
  ClientWidth = 786
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    786
    544)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 26
    Height = 13
    Caption = 'SGDB'
  end
  object cmb_sgdb: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 21
    TabOrder = 0
    OnChange = cmb_sgdbChange
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 525
    Width = 786
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ed_port: TLabeledEdit
    Left = 135
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 20
    EditLabel.Height = 13
    EditLabel.Caption = 'Port'
    TabOrder = 3
    Text = '3306'
  end
  object ed_server: TLabeledEdit
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Server'
    TabOrder = 2
    Text = '127.0.0.1'
  end
  object ed_username: TLabeledEdit
    Left = 8
    Top = 120
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Username'
    TabOrder = 4
    Text = 'root'
  end
  object ed_password: TLabeledEdit
    Left = 135
    Top = 120
    Width = 121
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    TabOrder = 5
    Text = '123456'
  end
  object btn_connect: TButton
    Left = 8
    Top = 195
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 6
    OnClick = btn_connectClick
  end
  object btn_open_dataset: TButton
    Left = 89
    Top = 195
    Width = 75
    Height = 25
    Caption = 'Run Query'
    TabOrder = 7
    OnClick = btn_open_datasetClick
  end
  object memoSQL: TMemo
    Left = 8
    Top = 257
    Width = 330
    Height = 167
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 8
  end
  object Memo1: TMemo
    Left = 8
    Top = 430
    Width = 770
    Height = 89
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 9
  end
  object DBGrid1: TDBGrid
    Left = 344
    Top = 16
    Width = 434
    Height = 408
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btn_run_command: TButton
    Left = 170
    Top = 195
    Width = 88
    Height = 25
    Caption = 'Run Command'
    TabOrder = 11
    OnClick = btn_run_commandClick
  end
  object Button2: TButton
    Left = 8
    Top = 226
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 12
    OnClick = Button2Click
  end
  object ed_database: TLabeledEdit
    Left = 8
    Top = 168
    Width = 248
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Database'
    TabOrder = 13
    Text = 'tk2000'
  end
  object chkUsarAutWindows: TCheckBox
    Left = 159
    Top = 10
    Width = 167
    Height = 17
    Hint = 
      'Usar autentica'#231#227'o do Windows|Esta op'#231#227'o s'#243' '#233' v'#225'lida para conex'#227'o' +
      ' com SQL Server.'
    Caption = 'Usar autentica'#231#227'o do Windows'
    TabOrder = 14
  end
  object chkUseConnectionStr: TCheckBox
    Left = 159
    Top = 34
    Width = 130
    Height = 17
    Hint = 'Usar ConnectionString'
    Caption = 'Usar ConnectionString'
    TabOrder = 15
  end
end
