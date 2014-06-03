unit Output;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ActnList, Vcl.ImgList, JvExComCtrls, JvComCtrls, Vcl.Menus, VirtualTrees, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup, Vcl.Themes, OutputTabSheet, BCControls.PageControl, System.Actions, BCCommon.Images;

type
  TOpenAllEvent = procedure(var FileNames: TStrings);

  TOutputFrame = class(TFrame)
    CloseAllMenuItem: TMenuItem;
    CloseAllOtherPagesAction: TAction;
    CloseAllOtherPagesMenuItem: TMenuItem;
    CloseMenuItem: TMenuItem;
    OutputActionList: TActionList;
    OutputCloseAction: TAction;
    OutputCloseAllAction: TAction;
    PageControl: TBCPageControl;
    PopupActionBar: TPopupActionBar;
    Separator2MenuItem: TMenuItem;
    CopytoClipboardMenuItem: TMenuItem;
    CopyAllToClipboardAction: TAction;
    OpenAllMenuItem: TMenuItem;
    OpenAllAction: TAction;
    N1: TMenuItem;
    OpenSelectedAction: TAction;
    OpenSelectedAction1: TMenuItem;
    CopySelectedToClipboardAction: TAction;
    CopyselectedtoClipboard1: TMenuItem;
    SelectAllAction: TAction;
    UnselectAllAction: TAction;
    N2: TMenuItem;
    Selectall1: TMenuItem;
    Unselectall1: TMenuItem;
    procedure CloseAllOtherPagesActionExecute(Sender: TObject);
    procedure OutputCloseActionExecute(Sender: TObject);
    procedure OutputCloseAllActionExecute(Sender: TObject);
    procedure TabsheetDblClick(Sender: TObject);
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
    procedure PageControlCloseButtonClick(Sender: TObject);
    procedure PageControlDblClick(Sender: TObject);
    procedure CopyAllToClipboardActionExecute(Sender: TObject);
    procedure OpenAllActionExecute(Sender: TObject);
    procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OpenSelectedActionExecute(Sender: TObject);
    procedure CopySelectedToClipboardActionExecute(Sender: TObject);
    procedure SelectAllActionExecute(Sender: TObject);
    procedure UnselectAllActionExecute(Sender: TObject);
  private
    { Private declarations }
    FCancelSearch: Boolean;
    FProcessingTabSheet: Boolean;
    FProcessingPage: TTabSheet;
    FTabsheetDblClick: TNotifyEvent;
    FOpenAll: TOpenAllEvent;
    FErrorTabSheet: TTabSheet;
    function GetCount: Integer;
    function GetIsAnyOutput: Boolean;
    function GetIsEmpty: Boolean;
    function GetOutputTabSheetFrame(TabSheet: TTabSheet): TOutputTabSheetFrame;
    function TabFound(TabCaption: string): Boolean;
    procedure CloseAllOtherTabSheets;
    procedure CloseAllTabSheets;
    procedure CopyToClipboard(OnlySelected: Boolean = False);
    procedure SetProcessingTabSheet(Value: Boolean);
    procedure OpenFiles(OnlySelected: Boolean = False);
    procedure SetCheckedState(Value: TCheckState);
    function CheckCancel: Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function SelectedLine(var Filename: string; var Ln: LongWord; var Ch: LongWord): Boolean;
    function AddErrorTreeView: TVirtualDrawTree;
    function AddTreeView(TabCaption: string): TVirtualDrawTree;
    procedure AddTreeViewLine(OutputTreeView: TVirtualDrawTree; var Root: PVirtualNode; Filename: WideString; Ln, Ch: LongInt; Text: WideString; SearchString: WideString = '');
    //procedure Clear;
    procedure CloseTabSheet;
    procedure UpdateControls;
    procedure ReadOutputFile;
    procedure SetOptions;
    procedure ShowErrorTabSheet;
    procedure CloseErrorTabSheet;
    procedure WriteOutputFile;
    property Count: Integer read GetCount;
    property IsAnyOutput: Boolean read GetIsAnyOutput;
    property IsEmpty: Boolean read GetIsEmpty;
    property OnTabsheetDblClick: TNotifyEvent read FTabsheetDblClick write FTabsheetDblClick;
    property OnOpenAll: TOpenAllEvent read FOpenAll write FOpenAll;
    property ProcessingTabSheet: Boolean read FProcessingTabSheet write SetProcessingTabSheet;
    property CancelSearch: Boolean read FCancelSearch write FCancelSearch;
  end;

implementation

{$R *.dfm}

uses
  Lib, BCCommon.OptionsContainer, BCCommon.Lib, BCCommon.StyleUtils, System.Math, System.UITypes, Vcl.Clipbrd, BCCommon.Messages,
  BCCommon.LanguageStrings, BCCommon.FileUtils, BCCommon.StringUtils, System.Types;

constructor TOutputFrame.Create(AOwner: TComponent);
begin
  inherited;
  { IDE can lose there properties }
  OutputActionList.Images := ImagesDataModule.ImageList;
  PopupActionBar.Images := ImagesDataModule.ImageList;
end;

procedure TOutputFrame.OpenAllActionExecute(Sender: TObject);
begin
  OpenFiles;
end;

procedure TOutputFrame.OutputCloseActionExecute(Sender: TObject);
begin
  CloseTabSheet;
end;

procedure TOutputFrame.OutputCloseAllActionExecute(Sender: TObject);
begin
  CloseAllTabSheets;
end;

procedure TOutputFrame.PageControlCloseButtonClick(Sender: TObject);
begin
  OutputCloseAction.Execute;
end;

procedure TOutputFrame.PageControlDblClick(Sender: TObject);
begin
  if OptionsContainer.OutputCloseTabByDblClick then
    OutputCloseAction.Execute;
end;

procedure TOutputFrame.PageControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbMiddle) and OptionsContainer.OutputCloseTabByMiddleClick then
    OutputCloseAction.Execute;
end;

procedure TOutputFrame.TabsheetDblClick(Sender: TObject);
begin
  if Assigned(FTabsheetDblClick) then
    FTabsheetDblClick(Sender);
end;

procedure TOutputFrame.OpenFiles(OnlySelected: Boolean);
var
  FileNames: TStrings;

  procedure GetFileNames;
  var
    OutputTreeView: TVirtualDrawTree;
    Node: PVirtualNode;
    Data: POutputRec;
  begin
    OutputTreeView := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
    Node := OutputTreeView.GetFirst;
    while Assigned(Node) do
    begin
      if not OnlySelected or OnlySelected and (OutputTreeView.CheckState[Node] = csCheckedNormal) then
      begin
        Data := OutputTreeView.GetNodeData(Node);
        FileNames.Add(Data.FileName);
      end;
      Node := Node.NextSibling;
    end;
  end;

begin
  if Assigned(FOpenAll) then
  begin
    FileNames := TStringList.Create;
    try
      GetFileNames;
      FOpenAll(FileNames);
    finally
      FileNames.Free;
    end;
  end;
end;

procedure TOutputFrame.OpenSelectedActionExecute(Sender: TObject);
begin
  OpenFiles(True);
end;

function TOutputFrame.TabFound(TabCaption: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  { check if there already is a tab with same name }
  for i := 0 to PageControl.PageCount - 1 do
    if Trim(PageControl.Pages[i].Caption) = TabCaption then
    begin
      PageControl.ActivePageIndex := i;
      Result := True;
      Break;
    end;
end;

procedure TOutputFrame.ShowErrorTabSheet;
begin
  if Assigned(FErrorTabSheet) then
  begin
    PageControl.ActivePage := FErrorTabSheet;
    FErrorTabSheet.TabVisible := True;
  end;
end;

procedure TOutputFrame.CloseErrorTabSheet;
begin
  if Assigned(FErrorTabSheet) then
    FreeAndNil(FErrorTabSheet)
end;

function TOutputFrame.AddErrorTreeView: TVirtualDrawTree;
var
  OutputTabSheetFrame: TOutputTabSheetFrame;
begin
  { check if there already is a tab with same name }
  if Assigned(FErrorTabSheet) then
  begin
    Result := GetOutputTabSheetFrame(FErrorTabSheet).VirtualDrawTree;
    if Assigned(Result) then
      Result.Clear;
    Exit;
  end;

  FErrorTabSheet := TTabSheet.Create(PageControl);
  FErrorTabSheet.PageControl := PageControl;
  FErrorTabSheet.TabVisible := False;
  FErrorTabSheet.ImageIndex := 170; { errors }
  FErrorTabSheet.Caption := LanguageDataModule.GetConstant('Errors');

  OutputTabSheetFrame := TOutputTabSheetFrame.Create(FErrorTabSheet);
  with OutputTabSheetFrame do
  begin
    Parent := FErrorTabSheet;
    with VirtualDrawTree do
    begin
      TreeOptions.AutoOptions := VirtualDrawTree.TreeOptions.AutoOptions + [toAutoExpand];
      OnDrawNode := VirtualDrawTreeDrawNode;
      OnFreeNode := VirtualDrawTreeFreeNode;
      OnGetNodeWidth := VirtualDrawTreeGetNodeWidth;
      OnDblClick := TabsheetDblClick;
      NodeDataSize := SizeOf(TOutputRec);
    end;
    Result := VirtualDrawTree;
  end;
  UpdateControls;
end;

function TOutputFrame.AddTreeView(TabCaption: string): TVirtualDrawTree;
var
  TabSheet: TTabSheet;
  OutputTabSheetFrame: TOutputTabSheetFrame;
begin
  { check if there already is a tab with same name }
  if TabFound(StringReplace(TabCaption, '&', '&&', [rfReplaceAll])) then
  begin
    Result := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
    if Assigned(Result) then
    begin
      Result.Clear;
      Result.Tag := 0;
    end;
    Exit;
  end;

  TabSheet := TTabSheet.Create(PageControl);
  TabSheet.PageControl := PageControl;
  TabSheet.TabVisible := False;
  TabSheet.ImageIndex := IMAGE_INDEX_FIND_IN_FILES;
  TabSheet.Caption := StringReplace(TabCaption, '&', '&&', [rfReplaceAll]);
  PageControl.ActivePage := TabSheet;

  OutputTabSheetFrame := TOutputTabSheetFrame.Create(TabSheet);
  with OutputTabSheetFrame do
  begin
    Parent := TabSheet;
    with VirtualDrawTree do
    begin
      OnDrawNode := VirtualDrawTreeDrawNode;
      OnFreeNode := VirtualDrawTreeFreeNode;
      OnGetNodeWidth := VirtualDrawTreeGetNodeWidth;
      OnDblClick := TabsheetDblClick;
      NodeDataSize := SizeOf(TOutputRec);
    end;
    Result := VirtualDrawTree;
  end;
  UpdateControls;
  TabSheet.TabVisible := True;
end;

procedure TOutputFrame.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree;
  const PaintInfo: TVTPaintInfo);
var
  Data: POutputRec;
  S, Temp: UnicodeString;
  R: TRect;
  Format: Cardinal;
  LStyles: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  LColor: TColor;
begin
  LStyles := StyleServices;
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    if LStyles.Enabled then
      Color := LStyles.GetStyleColor(scEdit);

    if LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
      R := ContentRect;
      R.Right := R.Left + NodeWidth;

      LDetails := LStyles.GetElementDetails(tgCellSelected);
      LStyles.DrawElement(Canvas.Handle, LDetails, R);
    end;

    if not LStyles.GetElementColor(LStyles.GetElementDetails(tgCellNormal), ecTextColor, LColor) or  (LColor = clNone) then
      LColor := LStyles.GetSystemColor(clWindowText);
    //get and set the background color
    Canvas.Brush.Color := LStyles.GetStyleColor(scEdit);
    Canvas.Font.Color := LColor;

    if LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
       Canvas.Brush.Color := LStyles.GetSystemColor(clHighlight);
       Canvas.Font.Color := LStyles.GetStyleFontColor(sfMenuItemTextSelected);// GetSystemColor(clHighlightText);
    end
    else
    if not LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end;

    if Data.Level = 0 then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold]
    else
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);
    if Data.Level = 2 then
      R.Left := 4;

    if (Data.Level = 0) or (Data.Level = 2) then
      S := Data.Filename
    else
      S := String(Data.Text);

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;
      if (Data.Level = 0) or (Data.Level = 2) or (Data.SearchString = '') then
      begin
        if Data.Level = 0 then
          S := System.SysUtils.Format('%s [%d]', [S, Node.ChildCount]);
        if Data.Level = 1 then
          S := System.SysUtils.Format('%s (%d, %d): ', [ExtractFilename(String(Data.Filename)), Data.Ln, Data.Ch]) + S;
        DrawText(Canvas.Handle, S, Length(S), R, Format)
      end
      else
      begin
        S := String(Data.Text);
        S := System.Copy(S, 0, Data.TextCh - 1);

        S := System.SysUtils.Format('%s (%d, %d): ', [ExtractFilename(String(Data.Filename)), Data.Ln, Data.Ch]) + S;

        DrawText(Canvas.Handle, S, Length(S), R, Format);
        S := StringReplace(S, Chr(9), '', [rfReplaceAll]); { replace tabs }
        R.Left := R.Left + Canvas.TextWidth(S);
        Canvas.Font.Color := clRed;
        S := Copy(String(Data.Text), Data.TextCh, Length(Data.SearchString));
        Temp := StringReplace(S, '&', '&&', [rfReplaceAll]);
        Canvas.Font.Style := Canvas.Font.Style + [fsBold];
        DrawText(Canvas.Handle, Temp, Length(Temp), R, Format);
        Canvas.Font.Color := LColor;
        R.Left := R.Left + Canvas.TextWidth(S);
        Canvas.Font.Style := Canvas.Font.Style - [fsBold];
        S := System.Copy(Data.Text, Integer(Data.TextCh) + Integer(System.Length(Data.SearchString)), Length(Data.Text));
        DrawText(Canvas.Handle, S, Length(S), R, Format);
      end;
    end;
  end;
end;

procedure TOutputFrame.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree;
  HintCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  Data: POutputRec;
  AMargin, BoldWidth: Integer;
  S: string;
begin
  with Sender as TVirtualDrawTree do
  begin
    AMargin := TextMargin;
    Data := Sender.GetNodeData(Node);
    if Assigned(Data) then
    case Data.Level of
      0: begin
           Canvas.Font.Style := Canvas.Font.Style + [fsBold];
           NodeWidth := Canvas.TextWidth(Trim(Format('%s [%d]', [String(Data.FileName), Node.ChildCount]))) + 2 * AMargin;
         end;
      1: begin
           S := System.SysUtils.Format('%s (%d, %d): ', [ExtractFilename(String(Data.Filename)), Data.Ln, Data.Ch]);
           Canvas.Font.Style := Canvas.Font.Style + [fsBold];
           BoldWidth := Canvas.TextWidth(String(Data.SearchString));
           Canvas.Font.Style := Canvas.Font.Style - [fsBold];
           BoldWidth := BoldWidth - Canvas.TextWidth(string(Data.SearchString));
           NodeWidth := Canvas.TextWidth(Trim(S + String(Data.Text))) + 2 * AMargin + BoldWidth;
         end;
    end;
  end;
end;

procedure TOutputFrame.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: POutputRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TOutputFrame.AddTreeViewLine(OutputTreeView: TVirtualDrawTree; var Root: PVirtualNode; Filename: WideString; Ln, Ch: LongInt; Text: WideString; SearchString: WideString);
var
  Node: PVirtualNode;
  NodeData: POutputRec;
  s: WideString;
begin
  if not FProcessingTabSheet then
    Exit;
  if FCancelSearch then
    Exit;
  if not Assigned(OutputTreeView) then
    Exit;
  OutputTreeView.BeginUpdate;
  if not Assigned(Root) then
  begin
    Root := OutputTreeView.GetFirst;
    while Assigned(Root) do
    begin
      NodeData := OutputTreeView.GetNodeData(Root);
      if String(NodeData.Filename) = FileName then
        Break;
      Root := OutputTreeView.GetNext(Root);
    end;
  end;

  if not Assigned(Root) then
  begin
    Root := OutputTreeView.AddChild(nil);
    NodeData := OutputTreeView.GetNodeData(Root);
    NodeData.Level := 0;
    if Ln = -1 then
    begin
      NodeData.Level := 2;
      NodeData.Filename := Text;
    end
    else
      NodeData.Filename := Filename;
  end;
  if Ln <> -1  then
  begin
    Node := OutputTreeView.AddChild(Root);
    NodeData := OutputTreeView.GetNodeData(Node);
    NodeData.Level := 1;
    NodeData.Ln := Ln;
    NodeData.Ch := Ch;
    NodeData.SearchString := SearchString;
    NodeData.Filename := Filename;

    s := Text;

    if NodeData.SearchString <> '' then
    begin
      if Ch > 255 then
      begin
        NodeData.TextCh := 11;
        s := System.Copy(s, Ch - 10, System.Length(s));
      end
      else
        NodeData.TextCh := Ch;
      if System.Length(s) > 255 then
        s := Format('%s...', [System.Copy(s, 0, 251)]);
    end;

    if toAutoExpand in OutputTreeView.TreeOptions.AutoOptions then
      if not OutputTreeView.Expanded[Root] then
        OutputTreeView.FullExpand(Root);

    NodeData.Text := s;
    OutputTreeView.Tag := OutputTreeView.Tag + 1;
  end;
  OutputTreeView.EndUpdate;
  { fix for scrollbar resize bug }
  SetWindowPos(OutputTreeView.Handle, 0, 0, 0, OutputTreeView.Width, OutputTreeView.Height, SWP_DRAWFRAME);
  Application.ProcessMessages;
end;

{procedure TOutputFrame.Clear;
var
  OutputTreeView: TVirtualDrawTree;
begin
  OutputTreeView := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
  if Assigned(OutputTreeView) then
  begin
    OutputTreeView.Clear;
    OutputTreeView.Tag := 0;
  end;
end;}

procedure TOutputFrame.SelectAllActionExecute(Sender: TObject);
begin
  SetCheckedState(csCheckedNormal);
end;

function TOutputFrame.SelectedLine(var Filename: string; var Ln: LongWord; var Ch: LongWord): Boolean;
var
  Node: PVirtualNode;
  NodeData: POutputRec;
  OutputTreeView: TVirtualDrawTree;
begin
  Result := False;
  OutputTreeView := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
  if not Assigned(OutputTreeView) then
    Exit;

  Node := OutputTreeView.GetFirstSelected;
  NodeData := OutputTreeView.GetNodeData(Node);

  Result := Assigned(NodeData) and (NodeData.Text <> '');
  if Result then
  begin
    Filename := String(NodeData.Filename);
    Ln := NodeData.Ln;
    Ch := NodeData.Ch;
  end;
end;

function TOutputFrame.GetIsEmpty: Boolean;
var
  OutputTreeView: TVirtualDrawTree;
begin
  Result := True;
  if FCancelSearch then
    Exit;
  OutputTreeView := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
  if not Assigned(OutputTreeView) then
    Exit;
  Result := OutputTreeView.GetFirst = nil;
end;

function TOutputFrame.GetCount: Integer;
var
  OutputTreeView: TVirtualDrawTree;
begin
  Result := 0;
  if FCancelSearch then
    Exit;
  OutputTreeView := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
  if not Assigned(OutputTreeView) then
    Exit;
  Result := OutputTreeView.Tag;
end;

procedure TOutputFrame.CopyToClipboard(OnlySelected: Boolean);
var
  OutputTreeView: TVirtualDrawTree;
  Node, ChildNode: PVirtualNode;
  Data, ChildData: POutputRec;
  StringList: TStrings;
begin
  OutputTreeView := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
  if Assigned(OutputTreeView) then
  begin
    StringList := TStringList.Create;
    try
      Node := OutputTreeView.GetFirst;
      while Assigned(Node) do
      begin
        if not OnlySelected or OnlySelected and (OutputTreeView.CheckState[Node] = csCheckedNormal) then
        begin
          Data := OutputTreeView.GetNodeData(Node);
          StringList.Add(Data.FileName);
          ChildNode := Node.FirstChild;
          while Assigned(ChildNode) do
          begin
            ChildData := OutputTreeView.GetNodeData(ChildNode);
            StringList.Add(System.SysUtils.Format('  %s (%d, %d): %s', [ExtractFilename(String(ChildData.Filename)),
              ChildData.Ln, ChildData.Ch, ChildData.Text]));
            ChildNode := ChildNode.NextSibling;
          end;
        end;
        Node := Node.NextSibling;
      end;
    finally
      Clipboard.AsText := StringList.Text;
      StringList.Free;
    end;
  end;
end;

procedure TOutputFrame.CopyAllToClipboardActionExecute(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TOutputFrame.CopySelectedToClipboardActionExecute(Sender: TObject);
begin
  CopyToClipboard(True);
end;

function TOutputFrame.GetIsAnyOutput: Boolean;
begin
  Result := False;
  if Assigned(PageControl) then
    Result := PageControl.PageCount <> 0;
end;

function TOutputFrame.CheckCancel: Boolean;
begin
  Result := False;
  Application.ProcessMessages;
  if FProcessingTabSheet then
    if FProcessingPage = PageControl.ActivePage then
    begin
      if AskYesOrNo(LanguageDataModule.GetYesOrNoMessage('CancelSearch')) then
        FCancelSearch := True
      else
        Result := True;
    end;
end;

procedure TOutputFrame.CloseTabSheet;
var
  ActivePageIndex: Integer;
begin
  if CheckCancel then
    Exit;
  if PageControl.PageCount > 0 then
  begin
    PageControl.TabClosed := True;
    //Self.Clear;
    ActivePageIndex := PageControl.ActivePageIndex;
    { Fixed Delphi Bug: http://qc.embarcadero.com/wc/qcmain.aspx?d=5473 }
    if (ActivePageIndex = PageControl.PageCount - 1) and (PageControl.PageCount > 1) then
    begin
      Dec(ActivePageIndex);
      PageControl.ActivePage.PageIndex := ActivePageIndex;
    end;
    if PageControl.PageCount > 0 then
      PageControl.Pages[ActivePageIndex].Free;
  end;
end;

procedure TOutputFrame.CloseAllTabSheets;
var
  i, j: Integer;
begin
  if CheckCancel then
    Exit;
  j := PageControl.PageCount - 1;
  for i := j downto 0 do
    PageControl.Pages[i].Free;
end;

procedure TOutputFrame.CloseAllOtherPagesActionExecute(Sender: TObject);
begin
  CloseAllOtherTabSheets;
end;

procedure TOutputFrame.CloseAllOtherTabSheets;
var
  i, j: Integer;
begin
  if CheckCancel then
    Exit;
  PageControl.ActivePage.PageIndex := 0;
  j := PageControl.PageCount - 1;
  for i := j downto 1 do
    PageControl.Pages[i].Free;
end;

procedure TOutputFrame.SetProcessingTabSheet(Value: Boolean);
begin
  FProcessingTabSheet := Value;
  FProcessingPage := PageControl.ActivePage;
  FCancelSearch := False;
end;

function TOutputFrame.GetOutputTabSheetFrame(TabSheet: TTabSheet): TOutputTabSheetFrame;
begin
  Result := nil;
  if Assigned(TabSheet) then
    if TabSheet.ComponentCount <> 0 then
      if Assigned(TabSheet.Components[0]) then
        if TabSheet.Components[0] is TOutputTabSheetFrame then
          Result := TOutputTabSheetFrame(TabSheet.Components[0]);
end;

procedure TOutputFrame.SetOptions;
var
  i: Integer;
  VirtualDrawTree: TVirtualDrawTree;
  Node: PVirtualNode;
begin
  PageControl.DoubleBuffered := OptionsContainer.OutputDoubleBuffered;
  PageControl.MultiLine := OptionsContainer.OutputMultiLine;
  PageControl.ShowCloseButton := OptionsContainer.OutputShowCloseButton;
  PageControl.RightClickSelect := OptionsContainer.OutputRightClickSelect;

  if OptionsContainer.OutputShowImage then
    PageControl.Images := ImagesDataModule.ImageList
  else
    PageControl.Images := nil;
  for i := 0 to PageControl.PageCount - 1 do
  begin
    VirtualDrawTree := TOutputTabSheetFrame(PageControl.Pages[i].Components[0]).VirtualDrawTree;
    VirtualDrawTree.Indent := OptionsContainer.OutputIndent;
    if OptionsContainer.OutputShowTreeLines then
      VirtualDrawTree.TreeOptions.PaintOptions := VirtualDrawTree.TreeOptions.PaintOptions + [toShowTreeLines]
    else
      VirtualDrawTree.TreeOptions.PaintOptions := VirtualDrawTree.TreeOptions.PaintOptions - [toShowTreeLines];
    { check boxes }
    Node := VirtualDrawTree.GetFirst;
    while Assigned(Node) do
    begin
      VirtualDrawTree.ReinitNode(Node, False);
      Node := VirtualDrawTree.GetNextSibling(Node);
    end;
  end;

  CopySelectedToClipboardAction.Visible := OptionsContainer.OutputShowCheckBox;
  OpenSelectedAction.Visible := OptionsContainer.OutputShowCheckBox;
  SelectAllAction.Visible := OptionsContainer.OutputShowCheckBox;
  UnselectAllAction.Visible := OptionsContainer.OutputShowCheckBox;
end;

procedure TOutputFrame.SetCheckedState(Value: TCheckState);
var
  OutputTreeView: TVirtualDrawTree;
  Node: PVirtualNode;
begin
  OutputTreeView := GetOutputTabSheetFrame(PageControl.ActivePage).VirtualDrawTree;
  Node := OutputTreeView.GetFirst;
  while Assigned(Node) do
  begin
    OutputTreeView.CheckState[Node] := Value;
    Node := Node.NextSibling;
  end;
end;

procedure TOutputFrame.UnselectAllActionExecute(Sender: TObject);
begin
  SetCheckedState(csUncheckedNormal);
end;

procedure TOutputFrame.UpdateControls;
var
  i, Right: Integer;
  LStyles: TCustomStyleServices;
  PanelColor: TColor;
  OutputTabSheetFrame: TOutputTabSheetFrame;
begin
  SetOptions;
  Application.ProcessMessages; { Important! }
  LStyles := StyleServices;
  PanelColor := clNone;
  if LStyles.Enabled then
    PanelColor := LStyles.GetStyleColor(scPanel);

  if TStyleManager.ActiveStyle.Name = STYLENAME_WINDOWS then
    Right := 3
  else
  if LStyles.Enabled and
    (GetRValue(PanelColor) + GetGValue(PanelColor) + GetBValue(PanelColor) > 500) then
    Right := 2
  else
    Right := 1;

  for i := 0 to PageControl.PageCount - 1 do
  begin
    OutputTabSheetFrame := GetOutputTabSheetFrame(PageControl.Pages[i]);
    if Assigned(OutputTabSheetFrame) then
      OutputTabSheetFrame.Panel.Padding.Right := Right;
  end;
end;

procedure TOutputFrame.ReadOutputFile;
var
  Filename, S: string;
  OutputFile: TextFile;
  VirtualDrawTree: TVirtualDrawTree;
  Root: PVirtualNode;
  AFilename, AFile, Text, SearchString: WideString;
  Ln, Ch: Cardinal;
begin
  FProcessingTabSheet := True;
  VirtualDrawTree := nil;
  Filename := GetOutFilename;
  if FileExists(Filename) then
  begin
    AssignFile(OutputFile, Filename);
    Reset(OutputFile);
    while not Eof(OutputFile) do
    begin
      Readln(OutputFile, S);
      if Pos('s:', S) = 1 then
      begin
        AFile := '';
        VirtualDrawTree := AddTreeView(Format(LanguageDataModule.GetConstant('SearchFor'), [Copy(S, 3, Length(S))]))
      end
      else
      begin
        if Assigned(VirtualDrawTree) then
        begin
          AFilename := GetNextToken(OUTPUT_FILE_SEPARATOR, S);
          if AFile <> AFilename then
          begin
            AFile := AFilename;
            Root := nil;
          end;
          S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
          Ln := StrToInt(GetNextToken(OUTPUT_FILE_SEPARATOR, S));
          S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
          Ch := StrToInt(GetNextToken(OUTPUT_FILE_SEPARATOR, S));
          S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
          Text := GetNextToken(OUTPUT_FILE_SEPARATOR, S);
          S := RemoveTokenFromStart(OUTPUT_FILE_SEPARATOR, S);
          SearchString := S;
          AddTreeViewLine(VirtualDrawTree, Root, AFilename, Ln, Ch, Text, SearchString);
        end;
      end;
    end;
    CloseFile(OutputFile);
  end;
  FProcessingTabSheet := False;
end;

procedure TOutputFrame.WriteOutputFile;
var
  i: Integer;
  Filename: string;
  OutputFile: TextFile;
  Node: PVirtualNode;
  NodeData: POutputRec;
  VirtualDrawTree: TVirtualDrawTree;
begin
  FProcessingTabSheet := True;
  Filename := GetOutFilename;
  if FileExists(Filename) then
    DeleteFile(Filename);
  if OptionsContainer.OutputSaveTabs then
    if PageControl.PageCount > 0 then
    begin
      AssignFile(OutputFile, Filename);
      ReWrite(OutputFile);
      for i := 0 to PageControl.PageCount - 1 do
      if Pos(LanguageDataModule.GetConstant('Errors'), PageControl.Pages[i].Caption) <> -1  then
      begin
        VirtualDrawTree := TOutputTabSheetFrame(PageControl.Pages[i].Components[0]).VirtualDrawTree;
        if Assigned(VirtualDrawTree) then
        begin
          { tab sheet }
          Node := VirtualDrawTree.GetFirst;
          Node := VirtualDrawTree.GetFirstChild(Node);
          if Assigned(Node) then
          begin
            NodeData := VirtualDrawTree.GetNodeData(Node);
            Writeln(OutputFile, Format('s:%s', [NodeData.SearchString]));
          end;
          { data }
          while Assigned(Node) do
          begin
            NodeData := VirtualDrawTree.GetNodeData(Node);
            if NodeData.SearchString <> '' then
              WriteLn(OutputFile, Format('%s%s%d%s%d%s%s%s%s', [NodeData.Filename, OUTPUT_FILE_SEPARATOR, NodeData.Ln,
                OUTPUT_FILE_SEPARATOR, NodeData.Ch, OUTPUT_FILE_SEPARATOR, NodeData.Text, OUTPUT_FILE_SEPARATOR, NodeData.SearchString]));
            Node := VirtualDrawTree.GetNext(Node);
          end;
        end;
      end;
      CloseFile(OutputFile);
    end;
  FProcessingTabSheet := False;
end;

end.
