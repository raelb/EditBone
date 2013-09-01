object LanguageEditorForm: TLanguageEditorForm
  Left = 0
  Top = 0
  Caption = 'Language Editor - [%s]'
  ClientHeight = 474
  ClientWidth = 820
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000280400001600000028000000100000002000
    0000010020000000000000000000000000000000000000000000000000000000
    0023000000330000003300000033000000330000003300000033000000330000
    003300000033000000330000003300000033000000330000002C000000007F7F
    7FC0848484FF828282FF818181FF818181FF818181FF818181FF828282FF8282
    82FF828282FF828282FF828282FF828282FF848484FF838383E1000000008484
    84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000008282
    82FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4240
    40FFFFFFFFFF292626FFFFFFFFFFFFFFFFFFFFFFFFFF828282FF000000008181
    81FFFFFFFFFFFFFFFFFFFFFFFFFF5B5959FF211F20FFFFFFFFFFFFFFFFFF7675
    75FF737171FF363435FFFFFFFFFF6C6969FFFFFFFFFF838383FF000000008181
    81FFFFFFFFFFFFFEFEFF1C191BFFFFFFFFFF595757FFFFFFFFFFFFFFFFFF3F3D
    3EFF3C3B3BFF3C3A3BFF2D2D2CFF312E30FFFFFFFFFF838383FF000000008282
    82FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7B8B6FF3B3B
    3BFF8A8B8BFF353234FFFFFFFFFFFFFFFFFFFFFFFFFF828282FF000000008383
    83FFFFFFFFFF767575FF282627FFFFFFFFFF222121FFFFFFFFFF4A4A4AFFE7E7
    E5FF424242FF2A2829FFFFFFFFFFF9F9F8FFFFFFFFFF828282FF000000008383
    83FFFFFFFFFF252223FF312F30FF2E2C2DFF2A2829FFFFFFFFFF545454FFFFFF
    FFFF3B3C3CFFFFFFFFFFF0EFEEFF222121FFFFFFFFFF838383FF000000008383
    83FFFFFFFFFFFFFFFFFF282829FFFFFFFFFF282728FFFFFFFFFFFFFEFDFFFFFF
    FFFF989797FF282627FFFFFFFFFFC2C1C0FFFFFFFFFF838383FF000000008383
    83FFFFFFFFFF161517FF1D1C1DFFFCFBFAFF1F1E1EFF211E20FF211E20FF2321
    22FF2A2829FF2E2B2DFF242223FF181517FFFFFFFFFF838383FF000000008282
    82FFFFFFFFFFE8E8E6FFEAEAE8FFE8E8E6FFECECEAFFF2F2F0FFF8F8F6FFFDFD
    FAFFFFFFFFFF201E20FFF6F7F4FFEAEAE8FFFFFFFFFF828282FF000000008282
    82FFFFFFFFFFDCDAD8FFDDDCD9FFDDDCDAFFDFDEDCFFE5E4E2FF131213FF1A19
    19FF1A191AFF838281FFE5E4E2FFDDDCD9FFFFFFFFFF828282FF000000008282
    82FFFFFFFFFFD4D3D0FFD5D4D2FFD5D4D2FFD6D5D3FFD9D8D6FFE0DFDCFFE3E2
    DFFFE2E1DEFFDEDDDAFFD8D7D4FFD5D4D1FFFFFFFFFF828282FF000000008484
    84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000008787
    87EF858585FF828282FF828282FF828282FF828282FF828282FF828282FF8282
    82FF828282FF828282FF828282FF828282FF858585FF878787EF00000000}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 455
    Width = 820
    Height = 19
    Panels = <
      item
        Width = 86
      end
      item
        Width = 86
      end
      item
        Width = 86
      end>
  end
  object VirtualTreePanel: TPanel
    Left = 0
    Top = 27
    Width = 820
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 4
    Padding.Right = 4
    Padding.Bottom = 4
    TabOrder = 1
    object VirtualDrawTree: TVirtualDrawTree
      Left = 4
      Top = 0
      Width = 812
      Height = 424
      Align = alClient
      Ctl3D = True
      DragOperations = []
      EditDelay = 0
      Header.AutoSizeIndex = 0
      Header.DefaultHeight = 20
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Height = 20
      Header.Images = ImageList
      Header.Options = [hoColumnResize, hoShowSortGlyphs, hoVisible]
      Images = ImageList
      ParentCtl3D = False
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand]
      TreeOptions.MiscOptions = [toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
      TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedSelection]
      TreeOptions.SelectionOptions = [toDisableDrawSelection, toExtendedFocus, toMiddleClickSelect, toRightClickSelect]
      WantTabs = True
      OnCompareNodes = VirtualDrawTreeCompareNodes
      OnCreateEditor = VirtualDrawTreeCreateEditor
      OnDrawNode = VirtualDrawTreeDrawNode
      OnEdited = VirtualDrawTreeEdited
      OnEditing = VirtualDrawTreeEditing
      OnFreeNode = VirtualDrawTreeFreeNode
      OnGetImageIndex = VirtualDrawTreeGetImageIndex
      OnGetNodeWidth = VirtualDrawTreeGetNodeWidth
      OnInitChildren = VirtualDrawTreeInitChildren
      OnInitNode = VirtualDrawTreeInitNode
      Columns = <
        item
          Position = 0
          Width = 220
          WideText = 'Object'
        end
        item
          Position = 1
          Width = 220
          WideText = 'Caption'
        end
        item
          Position = 2
          Width = 220
          WideText = 'Hint'
        end
        item
          Position = 3
          Width = 120
          WideText = 'Shortcut'
        end>
    end
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 0
    Width = 820
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 2
    object ToolbarSeparator1Bevel: TBevel
      AlignWithMargins = True
      Left = 56
      Top = 4
      Width = 4
      Height = 19
      Margins.Left = 6
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      Shape = bsLeftLine
      ExplicitLeft = 84
      ExplicitTop = 5
    end
    object ToolbarSeparator2Bevel: TBevel
      AlignWithMargins = True
      Left = 93
      Top = 4
      Width = 4
      Height = 19
      Margins.Left = 6
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      Shape = bsLeftLine
      ExplicitLeft = 109
      ExplicitTop = 3
    end
    object StandardToolBar: TBCToolBar
      Left = 2
      Top = 2
      Width = 48
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      Images = ImageList
      TabOrder = 0
      object NewToolButton: TToolButton
        Left = 0
        Top = 0
        Action = FileNewAction
      end
      object OpenToolButton: TToolButton
        Left = 23
        Top = 0
        Action = FileOpenAction
      end
    end
    object SaveToolBar: TBCToolBar
      Left = 63
      Top = 2
      Width = 24
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      Caption = 'ZoomToolBar'
      Images = ImageList
      TabOrder = 1
      object SaveToolButton: TToolButton
        Left = 0
        Top = 0
        Action = FileSaveAction
      end
    end
    object CloseToolBar: TBCToolBar
      Left = 100
      Top = 2
      Width = 23
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      Images = ImageList
      TabOrder = 2
      object CloseToolButton: TToolButton
        Left = 0
        Top = 0
        Action = CloseAction
      end
    end
  end
  object ImageList: TBCImageList
    Left = 84
    Top = 54
    Bitmap = {
      494C010109000D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      000000000000000000004B7DA30068A4D9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005C5C5C005C5C5C005E5B5A005E5A
      59005D5A5A005B5A5B005A5B5B005A5B5B005A5B5B005B5A5A005C5956005768
      76004E7EA4004C80AC005082AB0065A2D5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003F69
      A50075666700706869006D6969006C6A69006C6A69006C6A68006E6762004C89
      BA004E85B2004D83AE005D8CB200629ED1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001382
      6B0000934600715C62006A62630067646300666463006764620068615B004F8A
      BB005086B4004F84B1006895B9005F9BCD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000008C
      46004FDDB000008D43006B585E00655E60006361600062605F00645D5700518D
      BE00528AB7005187B400739FC2005D97C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000D915400008A4700008845000084
      410000DAA20060D9B300008D420068545A00625B5C00605C5A00605852005490
      C200558CBA004E81AD007EA6C8005A94C4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000008A470063EDD00000D4A00000D2
      9E0000CC9C0000CD9C006FDCBD0000934600615457005C5756005B534D005794
      C500588EBC0047749B0088AFCF005790C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000008A470061E1D00060DDCA0063DC
      C80000C49B0000C69C0082E1C800009447005C50540058535300574F4A005A96
      CA005B8FBE0022B9F70095B5D300548DBC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000010945700008A4700008844000085
      3F0000C1A00097E3D100008F43005A484E005650510053514F00524B45005B9A
      CD005C91C10020B7F5009EBCD7005189B8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000008B
      4400A0E8DA000091440055434A00524B4D004F4D4E004F4D4C004D4641005E9C
      D2005C95C5005990C100A6C4DF004E86B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001786
      6D0000964700523F45004F4749004D494A004C4A4A004C4848004A423D0060A0
      D5005D98C9005894C600AFCCE6004B83B0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004D7B
      B0004C3D3B004A43430048454400484644004846440047454200433C36005FA1
      D8005C9ACC005896C900B8D3EB004980AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A7F
      AC0044383100433B3700433D3800433D3800433D3800423B36003C332C00B9DA
      F5007FB0DA005495CC00C0DAEF00467CA8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000082A6
      C3004A82AE004A83B0004A83B0004A83B0004A83B0004A82AF00447DA900709C
      BF00B9D5EB00B3D1EA00C1DBF2004279A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEE3F5003F75A1000000000000000000000000000000
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
      000000000000000000000000000000000000BD964800B77F0F00B67D0A00B67C
      0A00B67C0A00B67C0A00B67C0A00B67C0A00B67C0A00B67C0A00B67C0A00B67C
      0A00B67C0A00B67D0A00B77F0F00BD964800000000000000000000000000BD96
      4800B67E0E00B47B0900B47A0700B47A0700B47A0700B47A0700B47A0700B47A
      0700B47A0700B47B0900B67E0E00BD964800BD964800B67E0E00B47B0900B47A
      0700B47A0700B47A0700B47A0700B47A0700B47A0700B47A0700B47A0700B47A
      0700B47A0700B47B0900B67E0E00BD9648000000000000000000000000000000
      0000000000000000000000000000AE865D00A7774500AE865D00000000000000
      000000000000000000000000000000000000B77F0F00F7FFFF00F2F7FF00F2F6
      FF00F2F6FF00F2F6FF00F1F6FF00F1F6FF00F1F6FF00F1F6FF00F1F6FF00F1F6
      FF00F1F6FF00F2F7FF00F7FFFF00B77F0F00000000000000000000000000B67E
      0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B67E0E00B67E0E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B67E0E000000000000000000000000000000
      00000000000000000000A97F5200C5A37E00FBF4E700C5A37E00A97F52000000
      000000000000000000000000000000000000B67D0A00F4FBFF00EBEBEE00EBEA
      EC00EBEBEC00EBEAEC00EAEAEC00E9E9EB00E8E8EA00E7E7E900E7E7E900E8E8
      EA00E9E9EB00EAEBEE00F4FBFF00B67D0A00000000000000000000000000B47B
      0900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B47B0900B47B0900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B47B09000000000000000000000000000000
      000000000000A9805300C4A47F00F6EDDF00C19E7900F6EDDF00C4A47F00A980
      530000000000000000000000000000000000B67C0900F4FAFF00E8E7E700E9E8
      E700EBEAE800EAE9E700E8E7E600EBEAEA00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EBEAEA00E6E6E700F4FAFF00B67C0900000000000000000000000000B47A
      0700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B47A0800B47A0700FFFFFF00FCFDFF00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FCFDFF00FFFFFF00B47A07000000000000000000000000000000
      0000A9805300C5A58100F8F1E600B4895D00A3723E00B4895D00F8F1E600C5A5
      8100A9805300000000000000000000000000B67C0900F5FBFF00E5E4E6009D9C
      9C009E9D9D009D9C9C00E8E5E600C0BFBC00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00BFBEBC00E5E3E500F5FBFF00B67C0900BD964800B67E0F00B57C0B00B277
      0100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B47B0800B47A0700FFFFFF00F5F5F700F5F4
      F400F5F4F400F5F4F400F5F4F400F5F4F400F5F4F400F5F4F400F5F4F400F5F4
      F400F5F4F400F5F5F700FFFFFF00B47A0700000000000000000000000000A980
      5300C7A68400FAF4EA00B3895C00A2703C00A3713D00A2703C00B3895C00FAF4
      EA00C7A68400A98053000000000000000000B67C0900F5FBFF00DFDFE100E2E1
      E100E4E3E300E3E2E200E3E2E200A0A0A000A0A0A0009F9F9F009F9F9F00A0A0
      A000A0A0A000E1E1E300F5FBFF00B67C0900B67E0E00FFFFFF00FFFFFF00AF72
      0000FFFFFF00FBFCFF00FBFBFC00FBFCFC00FBFCFC00FBFCFC00FBFCFC00FBFC
      FC00FBFBFC00FBFCFF00FFFFFF00B47B0800B47A0800FFFFFF00EDEEEF00EEEE
      ED00EEEEED00EEEEED00EEEEED00EEEEED00EEEEED00EEEEED00EEEEED00EEEE
      ED00EEEEED00EDEEEF00FFFFFF00B47A08000000000000000000A97E5100C6A7
      8400FCF7EF00B38A5F00B8916800FAF2E400F8EFE000FBF3E600B9926900B38B
      5F00FCF7EF00C6A78400A97E510000000000B67C0900F5FBFF00DBDBDC00DDDC
      DB00DEDDDC00DEDDDB00DDDCDB00DEDDDC00DDDCDA00DCDBDA00DCDBDA00DDDC
      DA00DDDCDB00DCDBDC00F5FBFF00B67C0900B47B0900FFFFFF00FFFFFF00AE71
      0000FFFFFF00EEEFF000EFEFEE00EFEFEE00EFEFEE00EFEFEE00EFEFEE00EFEF
      EE00EFEFEE00EEEFF000FFFFFF00B57C0A00B47B0800FFFFFF00E7E6E700E8E7
      E600E8E7E600E8E7E600E8E7E600E8E7E600E8E7E600E8E7E600E8E7E600E8E7
      E600E8E7E600E7E6E700FFFFFF00B47B080000000000B18D6800C8A88700FDF9
      F200B58C6000A6764300A5754200B8906600FDF8EF00A26F3A00A7774500A676
      4400B58C6000FDF9F200C8A88700AD865C00B67C0A00F6FBFF00D9D9D900DCDB
      DA00DDDDDB00DCDBDA00DAD9D800EEEDEE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EEEDED00D7D7D800F6FBFF00B67C0A00B47A0800FFFFFF00F3F9FF00B073
      0000FFFFFF00E4E4E400E5E4E300E5E4E300E5E4E300E5E4E300E5E4E300E5E4
      E300E5E4E300E4E4E400FFFFFF00B57E0F00B47B0800FFFFFF00DEDEDF00E0DF
      DE00E0DFDE00E0DFDE00E0DFDE00E0DFDE00E0DFDE00E0DFDE00E0DFDE00E0DF
      DE00E0DFDE00DEDEDF00FFFFFF00B47B080000000000A6754300FFFFFF00C4A4
      8100A3723E00A8784700A6754200B9916700FFFFFE00A4723E00A97A4A00A97A
      4900A4723E00C4A48100FFFFFF00A6754300B67D0A00F6FCFF00D7D5D6009392
      92009594950094939300D9D7D600C2C1BE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C1C0BD00D5D4D400F6FCFF00B67D0A00B47B0800FFFFFF00E8EDF700B176
      0000FFFFFF00D6D6D700D7D7D600D7D7D600D7D7D600D7D7D600D7D7D600D7D7
      D600D7D7D600D6D6D700FFFFFF00B6801300B47B0800FFFFFF00D5D6D600D6D6
      D500D7D7D600D7D7D600D7D7D600D7D7D600D7D7D600D7D7D600D7D7D600D7D7
      D600D6D6D500D5D6D600FFFFFF00B47B080000000000C4A38200C9A98900FFFF
      FC00B48D6200A5744200BE9A7400FFFFFF00FFFFFF00A5744100A97A4900A777
      4400B58D6300FFFFFC00C9A98900BC987300B67D0A00F6FCFF00D2D1D100D6D3
      D200D7D5D300D6D4D300D6D3D200A2A3A300A1A2A200A0A0A100A0A0A100A1A2
      A200A2A2A200D3D1D200F6FCFF00B67D0A00B47B0800FFFFFF00DADFE900B276
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B8821700B57C0A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B57C0A000000000000000000C5A58300C9AA
      8B00FFFFFF00B68C6200A3723D00A2703B00A2703B00A6764300A6764300B78D
      6300FFFFFF00C9AA8B00C5A5830000000000B67D0A00F6FCFF00CACBCC00CCCC
      CC00CCCCCC00CCCCCC00CDCCCD00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CDCDCD00CBCBCD00F6FCFF00B67D0A00B57C0A00FFFFFF00FFFFFF00CDAB
      6200B27C0C00B37D0F00B37E0F00B37E1000B37E1000B37D0F00B37C0E00B37C
      0D00B57F1200B7811500B8821700CCA55700B57E0F00F7E0BF00E0A64900E0A7
      4C00E0A84D00E0A84D00E0A84D00E0A84D00E0A84D00E0A84D00E0A84D00E0A8
      4D00E0A74C00E0A64900F7E0BF00B57E0F00000000000000000000000000C5A5
      8300CAAB8C00FFFFFF00B58C6100BA946B00FFFFFE00A3713D00B68E6300FFFF
      FF00CAAB8C00C5A583000000000000000000B67D0C00F5FDFF00F2F7FF00F3F7
      FF00F3F7FF00F3F7FF00F3F7FF00F3F8FF00F3F8FF00F3F8FF00F3F8FF00F3F8
      FF00F3F7FF00F3F7FF00F5FDFF00B67D0C00B57E0F00F8E1C000E2A84E00E4AE
      5900E6B16000E6B26200E6B36200E6B36200E6B36200E6B26100E6B05D00FCE8
      CE00B7811400000000000000000000000000B6801300F2D8AE00D4922200D494
      2600D4942700D4942700D4942700D4942700D4942700D4942700D4942700D494
      2700D4942600D4922200F2D8AE00B68013000000000000000000000000000000
      0000C5A58300CAAC8E00FFFFFF00B38A5F00A06C3600B48B6000FFFFFF00CAAC
      8E00C5A58300000000000000000000000000B67F1000F7E4C000DCAA4A00DCAB
      4A00DCAB4B00DCAB4B00DCAB4B00DCAB4B00DCAB4B00DCAB4B00DCAB4B00DCAB
      4B00DCAB4A00DCAA4A00F7E4C000B67F1000B6801300F2D8AE00D4932400D595
      2800D5962B00D5962B00D5962B00D5962B00D5962B00D5962A00D5942600F3D9
      B100B7811400000000000000000000000000B8821700EED09B00ECCE9800ECCE
      9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE
      9A00ECCE9A00ECCE9800EED09B00B88217000000000000000000000000000000
      000000000000C4A58300CBAD8E00FFFFFF00C6A88600FFFFFF00CBAD8F00C4A5
      830000000000000000000000000000000000B8821600EFD2A000EDCF9B00ECCF
      9B00ECCF9B00ECCF9B00ECCF9B00ECCF9B00ECCF9B00ECCF9B00ECCF9B00ECCF
      9B00ECCF9B00EDCF9B00EFD2A000B8821600B8821700EED09B00ECCE9800ECCE
      9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9800EED0
      9B00B8821700000000000000000000000000CFAB6200B8821700B7811600B781
      1600B7811600B7811600B7811600B7811600B7811600B7811600B7811600B781
      1600B7811600B7811600B8821700C4973D000000000000000000000000000000
      00000000000000000000C4A58300CBAE9100FFFFFF00CBAE9100C4A583000000
      000000000000000000000000000000000000CFAA6100B8821700B7811400B681
      1400B6811400B6811400B6811400B6811400B6811400B6811400B6811400B681
      1400B6811400B7811400B8821700CFAA6100CCA55700B8821700B7811600B781
      1600B7811600B7811600B7811600B7811600B7811600B7811600B7811600B882
      1700CCA557000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C4A38200A6754100C4A38200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BABAB900AFAFAD00AEAEAB00ADAD
      AB00ADADAB00ADADAB00ADADAB00AEAEAC00B3B0AF00C5B5B900529F7A00008B
      4800008B4900008C4C0053A88200000000000000000000000000000000000000
      0000000000000000000068A4CE004195D100469AD40000000000000000000000
      000000000000000000000000000000000000C2A97500B7821800B6801400B37A
      0600D7CFD200D8CEC900CFCECD00C9BFAC00D9CFCE00D5CAC300D4CAC400D6CF
      D200B37A0600B6801400B7821800C2A97500B1B1B100A2A2A2009F9F9F009F9F
      9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F
      9F009F9F9F009F9F9F00A2A2A200B1B1B100B0B0AD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006DC29B000094520000BA
      840077E0C60000BB860000995C0053A8820000000000000000000000000068A4
      CF004092CE0054ADDE0066C4ED0078E0FE003591D100BBB2AA00B0AEAB00ADAD
      AB00AEAEAB00AFAFAD00BABAB90000000000B7821800F6CD8B00F2C67D00F0C1
      7100FAF7FB00FFFFFF004C48480098939200FFFFFF00F7EFEA00F6EFEB00F9F6
      FA00F0C17100F2C67D00F6CD8B00B7821800A2A2A200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A2A2A200AEAEAB00FFFFFF00FDFDFD00FCFC
      FD00FCFCFD00FCFCFD00FCFCFD00FFFEFF00FFFFFF00007F360000BE880000BC
      8300FFFFFF0000BC830000C18D00008C4C00000000004E9CD10058B0DF006DC9
      EF007FE2FD007EE3FE007ADEFC007EE1FF00308CCD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00B0B0AD0000000000B6811600F3CA8700EDBC6D00EBB7
      6100F8F5F700FFFFFF004A454100948C8800FFFFFF00F1E8E000F0E7E000F7F4
      F700EBB76100EDBC6D00F3CA8700B6811600A0A0A000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A0A0A000ADADAB00FFFFFF00FAF8F800F9F8
      F800F9F8F800F9F8F800F9F8F800FDFAFB00FFFFFF00007F370072E5CB00FFFF
      FF00FFFFFF00FFFFFF0077E7CE00008B4900000000004094CF0092F1FF0085E7
      FF0080E1FD007ADEFB0077DBFB0083E1FF00308ACB00FFFFFB00FFFFFD00FCFC
      FC00FCFCFC00FFFFFF00AEAEAB0000000000B6811600F1CB8900E9B76200E7B2
      5700F9F8FB00FDF7F200877F79004A444100FEF7F200EEE3D800EDE2D900F8F7
      FB00E8B25700E9B76200F1CB8900B6811600A0A0A000FFFFFF00454341005F5D
      5C0074716F00646261004A474500FFFFFF00FFFFFF00454240005F5D5C007471
      6F00646261004A484500FFFFFF00A0A0A000ADADAB00FFFFFF00F6F6F600F6F6
      F600F6F6F600F6F6F600F6F6F600F9F7F800FFFFFF00007E360000CA940000C8
      8F00FFFFFF0000C9900000CD9900008C4B00000000003E92CE009AF0FF0083E4
      FD007EDFFC007ADDFB0076DAFA0089E2FE0048A8DD0070AED900FFFCF800F9F6
      F600F7F6F600FFFFFF00ADADAB0000000000B6811600F3CC8E00E8B25A00E7AE
      5100FCFFFF00ECE0D700F1E4DA00F1E5DA00EDE0D500EADDD300E9DED500FBFF
      FF00E7AE5100E8B25A00F3CC8E00B6811600A0A0A000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FEFEFE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A0A0A000ADADAB00FFFFFF00F4F4F300F4F4
      F300F4F4F300F4F4F300F4F4F300F6F5F500FFFAFC0063B68F00009B590000D1
      9A0074EED40000D49F0000A3670068BC9600000000003E92CE00A3F1FF0082E3
      FC007EDFFC007ADDFB0076DAFA0071D9FB009DE8FF002A89CB00FFFBF600F6F4
      F300F4F3F300FFFFFF00ADADAB0000000000B6811500F3CE9400E6AE5100E5AB
      4B00E6C9A400FFFFFF00FFFFFF00FFFFFF00FEFFFF00FDFFFF00FEFFFF00E6C9
      A400E5AC4B00E6AE5100F3CE9400B6811500A0A0A000FFFFFF0048454300625F
      5F0077747200676564004C4A4800FDFDFC00FDFDFC004845430062605F007774
      7200676564004D4A4800FFFFFF00A0A0A000ADADAB00FFFFFF00F2F1F000F2F1
      F000F2F1F000F2F1F000F2F1F000F3F1F000F8F3F400FFF9FD0062B58E000080
      370000843E000089470069BD960000000000000000003D92CE00ADF3FF0081E3
      FC007EDFFC007ADDFB0076DAFA006FD8FA00ABEBFF002B89CC00FFF8F100F2F1
      EF00EFF0EE00FFFFFF00ADADAB0000000000B6811500F3D09A00E5A84500E3A6
      4000E2A13600E29E2F00E19D2D00E19D2C00E19D2C00E19D2D00E29E2F00E2A1
      3600E3A64000E5A84500F3D09A00B6811500A0A0A000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FAF9F800FAF9F800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A0A0A000ADADAB00FFFFFF00EFEFEE00EFEF
      EE00EFEFEE00EFEFEE00EFEFEE00EFEFEE00F0EFEF00F4F1F100FDF4F600FFFF
      FF00CBB4BB00000000000000000000000000000000003C92CE00B6F6FF0080E3
      FC007DDFFC007ADDFB0076DAFA006ED7FA00B9EFFF002A89CC00FCF2ED00EEEC
      EB00EBEAEA00FFFFFF00ADADAB0000000000B6811400F4D4A000E1A13600F2DE
      B700FCFFFF00FBFFFD00FBFFFC00FBFFFD00FBFFFD00FBFFFD00FBFFFD00FBFF
      FF00F2DEB700E1A13600F4D4A000B6811400A0A0A000FFFFFF00484644006360
      600077757300686665004D4B4900F7F8F700F7F8F70049464400636160007775
      7300686564004D4B4900FFFFFF00A0A0A000ADADAB00FFFFFF00ECEBEA00EDEC
      EB00EDECEB00EDECEB00EDECEB00ECEBEA00ECEBE900ECEBEA00EEEBEB00FFFF
      FF00B7AFB000000000000000000000000000000000003C91CE00C0F8FF007FE2
      FC007DDFFC007ADDFB0075DAFA006DD7FA00C6F3FF002989CB00FFF9F400FFFF
      FF00FFFFFF00FFFFFF00AEAEAB0000000000B6801400F6D8A700E09C2700FBFF
      FF00FCFBF300FCF9EF00FBF8EE00FCFAF000FCFAF000FBF9EE00F9F8ED00FAF9
      F100FAFEFE00E09B2700F6D8A700B6801400A0A0A000FFFFFF00FDFCFB00FFFF
      FF00FFFFFF00FFFFFF00FDFCFB00F4F3F200F4F3F200FDFCFB00FFFFFF00FFFF
      FF00FFFFFE00FCFBFA00FFFFFF00A0A0A000ADADAB00FFFFFF00E9E9E800EAEA
      E900EAEAE900EAEAE900E9E9E800F3F4F200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00AFAEAC00000000000000000000000000000000003B91CE00C9F9FF007EE2
      FC007CDEFC0078DCFB0072D9FA006AD6FA00D2F6FF002888CB00FFFFFF00CDCB
      C900A4A4A200FFFFFF00AFAFAD0000000000B6801400F8DCB000E0981C00FBFB
      F80079787B00A2A0A200FCF6EA0079787900A3A1A300A09FA100FAF4E9009D9D
      A000F9F9F600E0981C00F8DCB000B6801400A0A0A000FFFFFF00494644006361
      600078767400696766004F4C4A00F2F2F100F2F2F1004A474500646261007876
      7400686665004E4B4900FFFFFF00A0A0A000ADAEAB00FFFFFF00E7E5E400E8E7
      E600E8E7E600E8E7E600E7E5E400FFFFFF00CBCBCA00A7A7A400A5A5A300FFFF
      FF00AFAFAD00000000000000000000000000000000003A91CE00D2FCFF007AE2
      FC0077DDFC007FDFFB009BE6FD00B3EDFF00D4F9FF002688CB00FFFFFF00A7A5
      A200FFFFFF00E9E9E900CACAC80000000000B6811300FCE3BC009B610400FDFC
      F900FDF5E800FEF4E700FBF2E500FCF2E500FBF2E500FBF2E500FAF1E300F9F1
      E500FCFAF7009A610400FCE3BC00B6811300A0A0A000FFFFFF00F6F5F400FBFA
      F900FBFAF900FBFAF900F7F6F500EFEEED00EFEEED00F8F7F600FBFAF900FBFA
      F900FAF9F800F6F5F400FFFFFF00A0A0A000AEAEAB00FFFFFF00E3E3E200E4E4
      E300E4E5E400E4E4E300E3E3E200FFFFFF00A7A7A400EBEBEA00FFFFFF00E9E9
      E900CACAC800000000000000000000000000000000003991CF00E9FFFF00AFF0
      FF00CEF7FF00DAFAFF00C4ECFC008CCAEC005FAEE00082BDE600FFFFFF00FFFF
      FF00E9E9E900CBCBC9000000000000000000B6801200FEE9C60071410000FFFF
      FF0079797A007A7A7A00A2A1A1009F9F9F00F6ECDE0077777700A1A1A1009E9F
      A000FFFFFF0070410000FEE9C600B6801200A0A0A000FFFFFF00484643006260
      5F0077757300686564004E4C4900EBECEB00ECECEB0049474400636060007775
      7300676564004D4B4800FFFFFF00A0A0A000AEAEAC00FFFFFF00E0DFDE00E1DF
      DE00E1E0DF00E1DFDE00E0DFDE00FFFFFF00A5A5A300FFFFFF00E8E8E800CBCB
      C90000000000000000000000000000000000000000003C93D000E9FFFF00A8DA
      F3007BBDE4004398D200408EC7006E9CBC0090A5B200BAAFA600B5ADA600B5AF
      A900CFCDCA00000000000000000000000000B6801200FDECD100DA860000FFFF
      FF00F1E5D800F2E5D800F2E5D700F0E3D600EFE2D500F1E4D700F1E4D600EFE3
      D600FFFFFF00DA860000FDECD100B6801200A0A0A000FFFFFF00E8E7E600EAE9
      E800EAE9E800EAE9E800E9E7E600E5E4E300E5E4E300E9E8E700EAE9E800EAE9
      E800EAE9E800E8E7E600FFFFFF00A0A0A000AFAFAD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E9E9E900CACAC9000000
      000000000000000000000000000000000000000000004297D2003B93D00062AD
      DC0093CDED00BBE7FA00D8FCFF00D6FCFF00D3FBFF00D1FBFF00D3FCFF002E91
      D50000000000000000000000000000000000B7811500FFECCD00FCE7C300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FCE7C300FFECCD00B7811500A2A2A200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A2A2A200B8B8B600B0B0AD00AEAEAC00AEAE
      AB00AEAEAB00AEAEAB00ADAEAB00AEAEAB00AFAFAD00B7B7B500000000000000
      0000000000000000000000000000000000000000000051A0D6004498D2004197
      D1003F95D1003D94D0003B93D0003A92D0003A92D0003A93D0003C94D1004B9E
      D60000000000000000000000000000000000DCC28F00B7811400B57E0F00B57C
      0B00B57C0900B57C0900B57C0900B57C0900B57C0900B57C0900B57C0900B57C
      0900B57C0B00B57E0F00B7811400DCC28F00ABABAB00A2A2A200A0A0A0009F9F
      9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F
      9F009F9F9F00A0A0A000A2A2A200ABABAB00424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFC000000000000
      0000000000000000E000000000000000E000000000000000E000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E000000000000000E000000000000000E000000000000000E000000000000000
      E000000000000000FFFC000000000000FFFFFFFFFFFFFFFF0000E0000000FE3F
      0000E0000000FC1F0000E0000000F80F0000E0000000F007000000000000E003
      000000000000C001000000000000800000000000000080000000000000008000
      000000000000C001000000000000E003000000070000F007000000070000F80F
      000000070000FC1F00000007FFFFFE3FFFFFFFFFFFFFFFFF0001FC7F00000000
      0000E00100000000000080010000000000008001000000000000800100000000
      0000800100000000000180010000000000078001000000000007800100000000
      000780010000000000078001000000000007800300000000000F800700000000
      001F800F00000000003F800F0000000000000000000000000000000000000000
      000000000000}
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 186
    Top = 72
    object FileNewAction: TAction
      Caption = 'NewAction'
      Hint = 'Create a new language file'
      ImageIndex = 0
      OnExecute = FileNewActionExecute
    end
    object FileOpenAction: TAction
      Caption = 'Open...'
      Hint = 'Open an existing language file'
      ImageIndex = 1
      OnExecute = FileOpenActionExecute
    end
    object FileSaveAction: TAction
      Caption = 'FileSaveAction'
      Hint = 'Save file'
      ImageIndex = 2
      OnExecute = FileSaveActionExecute
    end
    object CloseAction: TAction
      Hint = 'Close the language editor'
      ImageIndex = 8
      OnExecute = CloseActionExecute
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    OnMessage = ApplicationEventsMessage
    Left = 84
    Top = 128
  end
end
