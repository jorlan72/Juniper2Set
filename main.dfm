object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Convert Juniper to SET format - CodeRed 2023 - J. Lanesskog'
  ClientHeight = 766
  ClientWidth = 788
  Color = clBtnFace
  Constraints.MinHeight = 800
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object lblInput: TLabel
    Left = 0
    Top = 0
    Width = 788
    Height = 23
    Align = alTop
    Caption = 'Input'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri Light'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 41
  end
  object lblOutput: TLabel
    Left = 0
    Top = 312
    Width = 788
    Height = 23
    Align = alTop
    Caption = 'Output'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri Light'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 54
  end
  object memoInput: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 26
    Width = 782
    Height = 167
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Paste Juniper configuration here and click "Convert".')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    ExplicitWidth = 778
  end
  object memoOutput: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 338
    Width = 782
    Height = 425
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
    ExplicitWidth = 778
    ExplicitHeight = 420
  end
  object btnConvert: TButton
    AlignWithMargins = True
    Left = 200
    Top = 216
    Width = 388
    Height = 93
    Margins.Left = 200
    Margins.Top = 20
    Margins.Right = 200
    Align = alTop
    Caption = 'Convert'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Calibri Light'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnConvertClick
    ExplicitWidth = 384
  end
end
