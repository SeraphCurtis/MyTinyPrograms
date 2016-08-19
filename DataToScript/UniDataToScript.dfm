object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #25968#25454#23548#20986#20026#33050#26412
  ClientHeight = 303
  ClientWidth = 535
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
  PixelsPerInch = 96
  TextHeight = 13
  object RzLabel1: TRzLabel
    Left = 212
    Top = 13
    Width = 48
    Height = 13
    Caption = #25968#25454#34920#65306
  end
  object RzLabel2: TRzLabel
    Left = 375
    Top = 13
    Width = 36
    Height = 13
    Caption = #23383#27573#65306
  end
  object RzLabel3: TRzLabel
    Left = 20
    Top = 13
    Width = 48
    Height = 13
    Caption = #30331#24405#20449#24687
  end
  object LabeledEdit1: TLabeledEdit
    Left = 64
    Top = 40
    Width = 121
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'IP'#22320#22336#65306
    LabelPosition = lpLeft
    TabOrder = 0
    Text = '192.168.10.167'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 64
    Top = 94
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #30331#24405#21517#65306
    LabelPosition = lpLeft
    TabOrder = 1
    Text = 'sa'
  end
  object LabeledEdit3: TLabeledEdit
    Left = 64
    Top = 147
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #23494'    '#30721#65306
    LabelPosition = lpLeft
    TabOrder = 2
    Text = 'qwezxc'
  end
  object BitBtn1: TBitBtn
    Left = 110
    Top = 262
    Width = 75
    Height = 25
    Caption = #36830#25509
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 368
    Top = 262
    Width = 75
    Height = 25
    Caption = #23548#20986
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object LabeledEdit4: TLabeledEdit
    Left = 64
    Top = 201
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #25968#25454#24211#65306
    LabelPosition = lpLeft
    TabOrder = 3
    Text = 'DBMonitorV1.0'
  end
  object ListBox1: TListBox
    Left = 211
    Top = 32
    Width = 158
    Height = 207
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = ListBox1Click
    OnMouseMove = ListBox1MouseMove
  end
  object CheckListBox1: TCheckListBox
    Left = 375
    Top = 32
    Width = 149
    Height = 207
    ItemHeight = 13
    TabOrder = 7
  end
  object BitBtn3: TBitBtn
    Left = 449
    Top = 262
    Width = 75
    Height = 25
    Caption = #25171#24320#25991#20214#22841
    TabOrder = 8
    OnClick = BitBtn3Click
  end
  object ADOConnection1: TADOConnection
    CommandTimeout = 5
    ConnectionTimeout = 5
    LoginPrompt = False
    Left = 270
    Top = 65533
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 328
  end
end
