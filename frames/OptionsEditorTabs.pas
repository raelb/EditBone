unit OptionsEditorTabs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox;

type
  TEditorTabsFrame = class(TFrame)
    Panel: TPanel;
    MultilineCheckBox: TBCCheckBox;
    ShowCloseButtonCheckBox: TBCCheckBox;
    ShowImageCheckBox: TBCCheckBox;
    CloseTabByDblClickCheckBox: TBCCheckBox;
    CloseTabByMiddleClickCheckBox: TBCCheckBox;
    DoubleBufferedCheckBox: TBCCheckBox;
    SaveTabsCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
