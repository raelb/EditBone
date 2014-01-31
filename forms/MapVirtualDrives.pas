unit MapVirtualDrives;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, BCCommon.Images,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ComCtrls, Vcl.ToolWin, BCControls.ToolBar, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList;

type
  PVirtualDriveRec = ^TVirtualDriveRec;
  TVirtualDriveRec = record
    Drive: Char;
    Path: string;
  end;

  TMapVirtualDrivesForm = class(TForm)
    StatusBar: TStatusBar;
    ButtonPanel: TPanel;
    ToolbarSeparator2Bevel: TBevel;
    StandardToolBar: TBCToolBar;
    NewToolButton: TToolButton;
    OpenToolButton: TToolButton;
    CloseToolBar: TBCToolBar;
    CloseToolButton: TToolButton;
    VirtualTreePanel: TPanel;
    VirtualDrawTree: TVirtualDrawTree;
    ActionList: TActionList;
    AddAction: TAction;
    DeleteAction: TAction;
    EditAction: TAction;
    CloseAction: TAction;
    ToolButton1: TToolButton;
    procedure VirtualDrawTreeDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure VirtualDrawTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
  private
    { Private declarations }
    procedure AddTreeNode(Drive: Char; Path: string);
    procedure GetVirtualDrives;
    procedure ReadIniFile;
    procedure WriteIniFile;
  public
    { Public declarations }
    procedure Open;
  end;

function MapVirtualDrivesForm: TMapVirtualDrivesForm;

implementation

{$R *.dfm}

uses
  System.IniFiles, BCCommon.FileUtils, BCCommon.Lib, Vcl.Themes, BCCommon.LanguageUtils;

var
  FMapVirtualDrivesForm: TMapVirtualDrivesForm;

function MapVirtualDrivesForm: TMapVirtualDrivesForm;
begin
  if not Assigned(FMapVirtualDrivesForm) then
    Application.CreateForm(TMapVirtualDrivesForm, FMapVirtualDrivesForm);
  Result := FMapVirtualDrivesForm;
end;

procedure TMapVirtualDrivesForm.CloseActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TMapVirtualDrivesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIniFile;

  Action := caFree;
end;

procedure TMapVirtualDrivesForm.FormCreate(Sender: TObject);
begin
  StatusBar.Font.Name := 'Tahoma';
  StatusBar.Font.Size := 8;
  VirtualDrawTree.NodeDataSize := SizeOf(TVirtualDriveRec);
  { IDE can lose these properties }
  StandardToolBar.Images := ImagesDataModule.ImageList;
  CloseToolBar.Images := ImagesDataModule.ImageList;
  ActionList.Images := ImagesDataModule.ImageList;
  VirtualDrawTree.Images := ImagesDataModule.ImageList;
end;

procedure TMapVirtualDrivesForm.FormDestroy(Sender: TObject);
begin
  FMapVirtualDrivesForm := nil;
end;

procedure TMapVirtualDrivesForm.VirtualDrawTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PVirtualDriveRec;
begin
  if Result = 0 then
  begin
    Data1 := VirtualDrawTree.GetNodeData(Node1);
    Data2 := VirtualDrawTree.GetNodeData(Node2);

    Result := -1;

    if not Assigned(Data1) or not Assigned(Data2) then
      Exit;

    Result := AnsiCompareText(string(Data1.Drive), string(Data2.Drive));
  end;
end;

procedure TMapVirtualDrivesForm.VirtualDrawTreeDblClick(Sender: TObject);
begin
  EditAction.Execute
end;

procedure TMapVirtualDrivesForm.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  Data: PVirtualDriveRec;
  S: UnicodeString;
  R: TRect;
  Format: Cardinal;
  LStyles: TCustomStyleServices;
  LColor: TColor;
begin
  LStyles := StyleServices;
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    if not LStyles.GetElementColor(LStyles.GetElementDetails(tgCellNormal), ecTextColor, LColor) or  (LColor = clNone) then
      LColor := LStyles.GetSystemColor(clWindowText);
    //get and set the background color
    Canvas.Brush.Color := LStyles.GetStyleColor(scEdit);
    Canvas.Font.Color := LColor;

    if LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
       Colors.FocusedSelectionColor := LStyles.GetSystemColor(clHighlight);
       Colors.FocusedSelectionBorderColor := LStyles.GetSystemColor(clHighlight);
       Colors.UnfocusedSelectionColor := LStyles.GetSystemColor(clHighlight);
       Colors.UnfocusedSelectionBorderColor := LStyles.GetSystemColor(clHighlight);
       Canvas.Brush.Color := LStyles.GetSystemColor(clHighlight);
       Canvas.Font.Color := LStyles.GetStyleFontColor(sfMenuItemTextSelected);
    end
    else
    if not LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);

    case Column of
      0: S := Data.Drive;
      1: S := Data.Path;
    end;

    if Length(S) > 0 then
    begin
      with R do
        if (NodeWidth - 2 * Margin) > (Right - Left) then
          S := ShortenString(Canvas.Handle, S, Right - Left);

      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;

      DrawTextW(Canvas.Handle, PWideChar(S), Length(S), R, Format);
    end;

  end;
end;

procedure TMapVirtualDrivesForm.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PVirtualDriveRec;
begin
  Data := VirtualDrawTree.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TMapVirtualDrivesForm.VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PVirtualDriveRec;
begin
  if Kind in [ikNormal, ikSelected] then
    if Column = 0 then
      ImageIndex := IMG_IDX_DRIVE;
end;

procedure TMapVirtualDrivesForm.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
begin
  NodeWidth := VirtualDrawTree.Width
end;

procedure TMapVirtualDrivesForm.ReadIniFile;
begin
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Size }
    Width := ReadInteger('LanguageEditorSize', 'Width', Round(Screen.Width * 0.5));
    Height := ReadInteger('LanguageEditorSize', 'Height', Round(Screen.Height * 0.5));
    { Position }
    Left := ReadInteger('LanguageEditorPosition', 'Left', (Screen.Width - Width) div 2);
    Top := ReadInteger('LanguageEditorPosition', 'Top', (Screen.Height - Height) div 2);
    { Check if the form is outside the workarea }
    Left := SetFormInsideWorkArea(Left, Width);
  finally
    Free;
  end;
end;

procedure TMapVirtualDrivesForm.WriteIniFile;
begin
  if Windowstate = wsNormal then
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Position }
    WriteInteger('LanguageEditorPosition', 'Left', Left);
    WriteInteger('LanguageEditorPosition', 'Top', Top);
    { Size }
    WriteInteger('LanguageEditorSize', 'Width', Width);
    WriteInteger('LanguageEditorSize', 'Height', Height);
  finally
    UpdateFile;
    Free;
  end;
end;

procedure TMapVirtualDrivesForm.AddTreeNode(Drive: Char; Path: string);
var
  RootNode: PVirtualNode;
  Data: PVirtualDriveRec;
begin
  RootNode := VirtualDrawTree.AddChild(nil);
  Data := VirtualDrawTree.GetNodeData(RootNode);
  Data.Drive := Drive;
  Data.Path := Path;
end;

procedure TMapVirtualDrivesForm.GetVirtualDrives;
begin

end;

procedure TMapVirtualDrivesForm.Open;
begin
  ReadIniFile;

  UpdateLanguage(Self, GetSelectedLanguage);

  GetVirtualDrives;
  ShowModal;
end;

end.