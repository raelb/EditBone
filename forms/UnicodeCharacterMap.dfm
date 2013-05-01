object UnicodeCharacterMapForm: TUnicodeCharacterMapForm
  Left = 0
  Top = 0
  Caption = 'Unicode Character Map'
  ClientHeight = 412
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000000000000000000000000000000000000000000000000
    00006B535300BCABB800A193B400AD9FB400A698B500785B5C00F4EEED00EDE5
    E900504CAB0012118F007D7BC500C0B6D500E7D3D000D0BABF00CFBDC500D3C5
    CF00CCC2D400E5E0EB00DED8E200DEC2B800CE9E9F00CC8B9900C98C9600B19A
    9F00C2917600BF7B4E00C0825A00CBB0AF00DECECB00E0CCCB00C79C9F008C89
    69004A873700758E5600C08E6F00BF703700C0774300BF6E3400C47D4800DCD0
    D400E3D3D300C6A09F0000650000C78B9000C27B4700BF6B2B00C1876200C190
    7700C07D4B00D9B59D00E7D8DD00D3A3A700AC8E7E00918E6600C5AAAD00C47D
    4900BF6A2B00C1978600C2A3A000C0794600D8B49D00EADCE000E0A5B0005F89
    4500B68E8000C0908300C0828400C1835900BD672500BF784400BF733B00C176
    3D00D9CBCE00EAD9DA00D0A6A400928B6700DE909A00D5909100D9929100BDA3
    A400C4A7A600C6885D00C1753C00C6A69F00D8C9CB00EFDADC00A9A48400E291
    9C00D9929200D78F8F00B69D9F00C7ACB000C9B0B100D8C5C500EEDCDC00D4A6
    A100CF989200CF8B8C00B8A3A300D7BFBF00C68C8C0000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000060101000000000000000000000101016364650101000000000001
    01015B5C5D5E5F6061620101000001505152533C545556572B58595A01010137
    4445464748494A4B2B4C4D4E4F01013738393A3B3C3D3E3F402B414243010001
    2D2E2F3031323334352B2B3601000001232425262728292A2B2B2B2C01000001
    18191A1B1C1D1E1F2021220100000000010E0F10111213141516170100000000
    01010708090A0A0B0C0D01000000000000000101020304050101060000000000
    000000000101010100000000000000000000000000000000000000000000FFFF
    0000FFFF0000FE3F0000F00F0000800300000000000000000000000000008001
    00008001000080030000C0030000C0070000F0070000FC3F0000FFFF0000}
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 393
    Width = 435
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      435
      393)
    object StringGridCharacter: TStringGrid
      Left = 8
      Top = 38
      Width = 420
      Height = 347
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 20
      DefaultColWidth = 19
      DefaultRowHeight = 19
      FixedCols = 0
      RowCount = 3277
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ScrollBars = ssVertical
      TabOrder = 0
      OnClick = StringGridCharacterClick
      OnDrawCell = StringGridCharacterDrawCell
      OnMouseDown = StringGridCharacterMouseDown
      OnMouseUp = StringGridCharacterMouseUp
    end
    object ImagePanel: TPanel
      Left = 150
      Top = 88
      Width = 125
      Height = 125
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object Image: TImage
        Left = 1
        Top = 1
        Width = 119
        Height = 119
        Align = alClient
        ExplicitLeft = 80
        ExplicitTop = 32
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
    object Button1: TButton
      Left = 273
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Insert'
      TabOrder = 2
    end
    object Button2: TButton
      Left = 354
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Copy'
      TabOrder = 3
    end
    object FontComboBox: TJvFontComboBox
      Left = 8
      Top = 7
      Width = 255
      Height = 25
      DroppedDownWidth = 255
      MaxMRUCount = 0
      FontName = 'Arial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 40
      ParentFont = False
      Sorted = True
      TabOrder = 4
      OnChange = FontComboBoxChange
    end
  end
end