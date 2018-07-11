unit EditBone.Form.LanguageEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ExtCtrls, VirtualTrees, Vcl.AppEvnts, BCControl.Edit,
  System.Actions, BCCommon.Images, BCControl.Panel, sPanel, Vcl.Dialogs, sDialogs, BCControl.Statusbar,
  sStatusBar, sSkinProvider, Vcl.Buttons, sSpeedButton, BCControl.SpeedButton;

type
  TValueType = (vtString, vtPickString);

  PObjectNodeRec = ^TObjectNodeRec;
  TObjectNodeRec = record
    Level: Byte;
    ValueType: array[0..3] of TValueType;
    Value: array[0..4] of string;
    ImageIndex: Byte;
  end;

  TLanguageEditorForm = class(TForm)
    ActionList: TActionList;
    ApplicationEvents: TApplicationEvents;
    ButtonPanel: TBCPanel;
    ActionExit: TAction;
    ActionFileNew: TAction;
    ActionFileOpen: TAction;
    ActionFileSave: TAction;
    StatusBar: TBCStatusBar;
    VirtualDrawTree: TVirtualDrawTree;
    VirtualTreePanel: TBCPanel;
    OpenDialog: TsOpenDialog;
    SaveDialog: TsSaveDialog;
    SkinProvider: TsSkinProvider;
    SpeedButtonOpen: TBCSpeedButton;
    SpeedButtonNew: TBCSpeedButton;
    SpeedButtonDivider1: TBCSpeedButton;
    SpeedButtonSave: TBCSpeedButton;
    SpeedButtonDivider2: TBCSpeedButton;
    SpeedButtonClose: TBCSpeedButton;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionFileNewExecute(Sender: TObject);
    procedure ActionFileOpenExecute(Sender: TObject);
    procedure ActionFileSaveExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VirtualDrawTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure VirtualDrawTreeCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeEdited(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VirtualDrawTreeEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
    procedure VirtualDrawTreeInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
    procedure VirtualDrawTreeInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  private
    FLanguageFileName: string;
    function GetCaption: string;
    function GetModifiedInfo: string;
    function SaveAs(FileName: string): Boolean;
    procedure AddTreeNode(NodeText: string; TranslationNeeded: Boolean);
    procedure LoadLanguageFile(FileName: string);
    procedure ReadIniFile;
    procedure Save;
    procedure SaveToFile(FileName: string);
    procedure WriteIniFile;
  public
    procedure Open;
  end;

  TEditLink = class(TInterfacedObject, IVTEditLink)
  private
    FEdit: TWinControl;
    FTree: TVirtualDrawTree; // A back reference to the tree calling.
    FNode: PVirtualNode;       // The node being edited.
    FColumn: Integer;          // The column of the node being edited.
  protected
    procedure EditKeyPress(Sender: TObject; var Key: Char);
  public
    destructor Destroy; override;
    function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(R: TRect); stdcall;
  end;

function LanguageEditorForm: TLanguageEditorForm;

implementation

{$R *.dfm}

uses
  System.IniFiles, BCCommon.Utils, BCCommon.Language.Strings, BCCommon.Language.Utils,
  Vcl.StdCtrls, Vcl.Menus, BCCommon.Messages, BCCommon.FileUtils, System.Types, VirtualTrees.Utils, BCCommon.Consts;

var
  FLanguageEditorForm: TLanguageEditorForm;

function LanguageEditorForm: TLanguageEditorForm;
begin
  if not Assigned(FLanguageEditorForm) then
    Application.CreateForm(TLanguageEditorForm, FLanguageEditorForm);
  Result := FLanguageEditorForm;
end;

procedure TLanguageEditorForm.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[2].Text := Application.Hint;
end;

procedure TLanguageEditorForm.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
var
  InfoText: string;
  KeyState: TKeyboardState;
begin
  ActionFileSave.Enabled := VirtualDrawTree.Tag = 1;

  InfoText := GetModifiedInfo;
  if StatusBar.Panels[1].Text <> InfoText then
    StatusBar.Panels[1].Text := InfoText;

  GetKeyboardState(KeyState);
  if KeyState[VK_INSERT] = 0 then
    if StatusBar.Panels[0].Text <> LanguageDataModule.GetConstant('Insert') then
      StatusBar.Panels[0].Text := ' ' + LanguageDataModule.GetConstant('Insert');
  if KeyState[VK_INSERT] = 1 then
    if StatusBar.Panels[0].Text <> LanguageDataModule.GetConstant('Overwrite') then
      StatusBar.Panels[0].Text := ' ' + LanguageDataModule.GetConstant('Overwrite');
end;

procedure TLanguageEditorForm.ActionExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TLanguageEditorForm.ActionFileNewExecute(Sender: TObject);
var
  SelectedLanguage, LanguagePath: string;
begin
  SelectedLanguage := GetSelectedLanguage('English');
  LanguagePath := IncludeTrailingPathDelimiter(Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Languages']));
  if not DirectoryExists(LanguagePath) then
    Exit;
  if SaveAs(LanguagePath) then
  begin
    Application.ProcessMessages; { style fix }
    FLanguageFileName := Format('%s%s.%s', [LanguagePath, SelectedLanguage, 'lng']);
    Winapi.Windows.CopyFile(PWideChar(FLanguageFileName), PWideChar(SaveDialog.Files[0]), False);
    LoadLanguageFile(SaveDialog.Files[0]);
  end;
end;

procedure TLanguageEditorForm.ActionFileOpenExecute(Sender: TObject);
var
  DefaultPath: string;
begin
  DefaultPath := IncludeTrailingPathDelimiter(Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Languages']));

  OpenDialog.InitialDir := DefaultPath;
  OpenDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('Language'), '|', #0, [rfReplaceAll])) + #0#0;
  OpenDialog.Title := LanguageDataModule.GetConstant('Open');
  if OpenDialog.Execute(Handle) then
    LoadLanguageFile(OpenDialog.Files[0]);
end;

procedure TLanguageEditorForm.ActionFileSaveExecute(Sender: TObject);
begin
  Save;
  Repaint;
end;

procedure TLanguageEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIniFile;

  if VirtualDrawTree.Tag = 1 then
    if BCCommon.Messages.SaveChanges(False) = mrYes then
      Save;

  Action := caFree;
end;

procedure TLanguageEditorForm.FormCreate(Sender: TObject);
begin
  VirtualDrawTree.NodeDataSize := SizeOf(TObjectNodeRec);
  { IDE can lose these properties }
  ActionList.Images := ImagesDataModule.ImageList;
  VirtualDrawTree.Images := ImagesDataModule.ImageListSmall;
end;

procedure TLanguageEditorForm.FormDestroy(Sender: TObject);
begin
  FLanguageEditorForm := nil;
end;

procedure TLanguageEditorForm.ReadIniFile;
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

procedure TLanguageEditorForm.WriteIniFile;
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

procedure TLanguageEditorForm.SaveToFile(FileName: string);
var
  Node, ChildNode: PVirtualNode;
  Data, ChildData: PObjectNodeRec;
begin
  with TMemIniFile.Create(FileName, TEncoding.Unicode) do
  try
     Node := VirtualDrawTree.GetFirst;
     while Assigned(Node) do
     begin
       Data := VirtualDrawTree.GetNodeData(Node);

       ChildNode := Node.FirstChild;
       while Assigned(ChildNode) do
       begin
         ChildData := VirtualDrawTree.GetNodeData(ChildNode);

         if Trim(ChildData.Value[1]) <> '' then
           WriteString(Data.Value[0], ChildData.Value[0], ChildData.Value[1])
         else
           DeleteKey(Data.Value[0], ChildData.Value[0]);
         if Trim(ChildData.Value[2]) <> '' then
           WriteString(Data.Value[0], Format('%s:h', [ChildData.Value[0]]), ChildData.Value[2])
         else
           DeleteKey(Data.Value[0], Format('%s:h', [ChildData.Value[0]]));
         if Trim(ChildData.Value[3]) <> '' then
           WriteString(Data.Value[0], Format('%s:s', [ChildData.Value[0]]), ChildData.Value[3])
         else
           DeleteKey(Data.Value[0], Format('%s:s', [ChildData.Value[0]]));
         if Trim(ChildData.Value[4]) = 'Changed' then
         begin
           DeleteKey(Data.Value[0], Format('%s:t', [ChildData.Value[0]]));
           ChildData.Value[4] := '';
         end;
         ChildNode := ChildNode.NextSibling;
       end;
       Node := Node.NextSibling;
     end;
  finally
    UpdateFile;
    Free;
    VirtualDrawTree.Repaint;
  end;
end;

function TLanguageEditorForm.SaveAs(FileName: string): Boolean;
begin
  SaveDialog.InitialDir := ExtractFilePath(FileName);
  SaveDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('Language'), '|', #0, [rfReplaceAll])) + #0#0;
  SaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
  SaveDialog.FileName := ExtractFileName(FileName);
  SaveDialog.DefaultExt := 'lng';
  Result := SaveDialog.Execute(Handle);
end;

procedure TLanguageEditorForm.Save;
var
  AFileName: string;
begin
  AFileName := FLanguageFileName;
  if Pos('~', FLanguageFileName) = Length(FLanguageFileName) then
    AFileName := System.Copy(AFileName, 0, Length(AFileName) - 1);
  SaveToFile(AFileName);
  VirtualDrawTree.Tag := 0;
  FLanguageFileName := AFileName;
  Caption := GetCaption;
end;

procedure TLanguageEditorForm.VirtualDrawTreeCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PObjectNodeRec;
begin
  if Result = 0 then
  begin
    Data1 := VirtualDrawTree.GetNodeData(Node1);
    Data2 := VirtualDrawTree.GetNodeData(Node2);

    Result := -1;

    if not Assigned(Data1) or not Assigned(Data2) then
      Exit;

    Result := AnsiCompareText(string(Data1.Value[0]), string(Data2.Value[0]));
  end;
end;

procedure TLanguageEditorForm.VirtualDrawTreeCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  EditLink := TEditLink.Create;
end;

procedure TLanguageEditorForm.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree;
  const PaintInfo: TVTPaintInfo);
var
  Data: PObjectNodeRec;
  S: string;
  R: TRect;
  Format: Cardinal;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    if Data.Value[4] <> '' then
      Canvas.Font.Color := clRed
    else
    if Assigned(SkinProvider.SkinData) and Assigned(SkinProvider.SkinData.SkinManager) then
      Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetActiveEditFontColor //clWindowText; //LColor;
    else
      Canvas.Font.Color := clWindowText;

    if vsSelected in PaintInfo.Node.States then
    begin
      if Assigned(SkinProvider.SkinData) and Assigned(SkinProvider.SkinData.SkinManager) then
      begin
        Canvas.Brush.Color := SkinProvider.SkinData.SkinManager.GetHighLightColor;
        if Data.Value[4] <> '' then
          Canvas.Font.Color := clRed
        else
          Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetHighLightFontColor
      end
      else
      begin
        Canvas.Brush.Color := clHighlight;
        if Data.Value[4] <> '' then
          Canvas.Font.Color := clRed
        else
          Canvas.Font.Color := clHighlightText;
      end;
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);
    S := Data.Value[Column];

    if Length(S) > 0 then
    begin
      with R do
        if (NodeWidth - 2 * Margin) > (Right - Left) then
          S := ShortenString(Canvas.Handle, S, Right - Left);

      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;

      DrawText(Canvas.Handle, S, Length(S), R, Format);
    end;

  end;
end;

procedure TLanguageEditorForm.VirtualDrawTreeEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
var
  Data: PObjectNodeRec;
begin
  if (VirtualDrawTree.Tag = 1) and (Pos('~', FLanguageFileName) = 0) then
  begin
    FLanguageFileName := FLanguageFileName + '~';
    Data := VirtualDrawTree.GetNodeData(Node);
    Data.Value[4] := 'Changed';
    Caption := GetCaption;
  end;
end;

procedure TLanguageEditorForm.VirtualDrawTreeEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := Column > 0
end;

procedure TLanguageEditorForm.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PObjectNodeRec;
begin
  Data := VirtualDrawTree.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TLanguageEditorForm.VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
  var ImageIndex: Integer);
var
  Data: PObjectNodeRec;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    Data := VirtualDrawTree.GetNodeData(Node);
    if (Column = 0) and (Data.Level = 0) then
      ImageIndex := Data.ImageIndex;
  end;
end;

procedure TLanguageEditorForm.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree;
  HintCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  Data: PObjectNodeRec;
  AMargin: Integer;
begin
  with Sender as TVirtualDrawTree do
  begin
    AMargin := TextMargin;
    Data := Sender.GetNodeData(Node);
    if Assigned(Data) then
      NodeWidth := Canvas.TextWidth(Data.Value[Column]) + 2 * AMargin;
  end;
end;

procedure TLanguageEditorForm.VirtualDrawTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PObjectNodeRec;
begin
  inherited;
  Data := VirtualDrawTree.GetNodeData(Node);

  if Data.Level = 0 then
    Include(InitialStates, ivsHasChildren);
end;

procedure TLanguageEditorForm.AddTreeNode(NodeText: string; TranslationNeeded: Boolean);
var
  RootNode: PVirtualNode;
  Data: PObjectNodeRec;
begin
  RootNode := VirtualDrawTree.AddChild(nil);
  Data := VirtualDrawTree.GetNodeData(RootNode);
  Data.Value[0] := Trim(NodeText);
  Data.ValueType[0] := vtString;
  if TranslationNeeded then
    Data.Value[4] := 'Translation needed';
  if Pos('About Language File', NodeText) <> 0 then
    Data.ImageIndex := 74
  else
  if Pos('Dialog', NodeText) <> 0 then
    Data.ImageIndex := 131
  else
  if Pos('Form', NodeText) <> 0 then
    Data.ImageIndex := 132
  else
  if Pos('Frame', NodeText) <> 0 then
    Data.ImageIndex := 133
  else
  if (Pos('Message', NodeText) <> 0) or (Pos('AskYes', NodeText) <> 0) then
    Data.ImageIndex := 134
  else
  if Pos('FileTypes', NodeText) <> 0 then
    Data.ImageIndex := 120
  else
    Data.ImageIndex := 135;
  Data.Level := 0;
end;

procedure TLanguageEditorForm.LoadLanguageFile(FileName: string);
var
  i, j: Integer;
  SectionStringList, StringList: TStringList;
  TranslationNeeded: Boolean;
begin
  if not FileExists(FileName) then
    Exit;
  FLanguageFileName := FileName;
  Caption := GetCaption;
  VirtualDrawTree.BeginUpdate;
  VirtualDrawTree.Clear;
  SectionStringList := TStringList.Create;
  StringList := TStringList.Create;
  with TMemIniFile.Create(FileName, TEncoding.Unicode) do
  try
    ReadSections(SectionStringList);
    for i := 0 to SectionStringList.Count - 1 do
    begin
      ReadSectionValues(SectionStringList.Strings[i], StringList);
      TranslationNeeded := False;
      for j := 0 to StringList.Count - 1 do
        if Pos(':t', Copy(StringList.Strings[j], 1, Pos('=', StringList.Strings[j]) - 1)) <> 0 then
        begin
          TranslationNeeded := True;
          Break;
        end;
      AddTreeNode(SectionStringList.Strings[i], TranslationNeeded);
    end;
  finally
    SectionStringList.Free;
    StringList.Free;
    Free;
  end;
  VirtualDrawTree.Sort(nil, 0, sdAscending, False);
  VirtualDrawTree.EndUpdate;
end;

procedure TLanguageEditorForm.VirtualDrawTreeInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  i: Integer;
  Data: PObjectNodeRec;
  StringList: TStringList;
  FileName: string;

  procedure AddChildNode(NodeText: string);
  var
    NodeKey, NodeValue: string;
    ChildData: PObjectNodeRec;
    ChildNode: PVirtualNode;

    function GetNodeKey(Text: string): string;
    begin
      Result := Copy(Text, 1, Pos('=', Text) - 1);
      { remove hint }
      Result := StringReplace(Result, ':h', '', []);
      { remove shortcut }
      Result := StringReplace(Result, ':s', '', []);
      { remove translation needed }
      Result := StringReplace(Result, ':t', '', []);
    end;

  begin
    NodeKey := GetNodeKey(NodeText);

    { check if node already exists }
    ChildNode := Node.FirstChild;
    Data := VirtualDrawTree.GetNodeData(ChildNode);
    while Assigned(ChildNode) and (AnsiCompareText(NodeKey, Data.Value[0]) <> 0) do
    begin
      ChildNode := ChildNode.NextSibling;
      Data := VirtualDrawTree.GetNodeData(ChildNode);
    end;
    if not Assigned(ChildNode) then
      ChildNode := VirtualDrawTree.AddChild(Node);
    ChildData := VirtualDrawTree.GetNodeData(ChildNode);
    ChildData.Level := 1;
    ChildData.Value[0] := NodeKey;
    ChildData.ValueType[0] := vtString;
    NodeKey := Copy(NodeText, 1, Pos('=', NodeText) - 1);
    NodeValue := Copy(NodeText, Pos('=', NodeText) + 1, Length(NodeText));
    if Pos(':t', NodeKey) <> 0 then
      ChildData.Value[4] := NodeValue
    else
    if (Pos(':h', NodeKey) = 0) and (Pos(':s', NodeKey) = 0) then
      ChildData.Value[1] := NodeValue
    else
    if Pos(':h', NodeKey) <> 0 then
      ChildData.Value[2] := NodeValue
    else
    if Pos(':s', NodeKey) <> 0 then
      ChildData.Value[3] := NodeValue;
    ChildData.ValueType[1] := vtString;
    ChildData.ValueType[2] := vtString;
    ChildData.ValueType[3] := vtPickString;
  end;

begin
  if Assigned(Node) then
  begin
    Data := VirtualDrawTree.GetNodeData(Node);

    FileName := FLanguageFileName;
    FileName := FormatFileName(FileName);

    StringList := TStringList.Create;
    with TMemIniFile.Create(FileName, TEncoding.Unicode) do
    try
      ReadSectionValues(Data.Value[0], StringList);
      for i := 0 to StringList.Count - 1 do
        AddChildNode(StringList.Strings[i]);
    finally
      StringList.Free;
      Free;
    end;
    ChildCount := VirtualDrawTree.ChildCount[Node];
  end;
end;

procedure TLanguageEditorForm.Open;
var
  SelectedLanguage, LanguagePath: string;
begin
  ReadIniFile;

  SelectedLanguage := GetSelectedLanguage('English');
  UpdateLanguage(Self, SelectedLanguage);
  LanguagePath := IncludeTrailingPathDelimiter(Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Languages']));
  if not DirectoryExists(LanguagePath) then
    Exit;
  FLanguageFileName := Format('%s%s.%s', [LanguagePath, SelectedLanguage, 'lng']);
  if not FileExists(FLanguageFileName) then
    Exit;

  LoadLanguageFile(FLanguageFileName);
  ShowModal;
end;

function TLanguageEditorForm.GetModifiedInfo: string;
begin
  Result := '';
  if VirtualDrawTree.Tag = 1 then
    Result := 'Modified';
end;

function TLanguageEditorForm.GetCaption: string;
begin
  Result := Format(LanguageDataModule.GetConstant('LanguageEditor'), [FLanguageFileName]);
end;

{ TEditLink }

destructor TEditLink.Destroy;
begin
  //FEdit.Free; This gives AV
  if FEdit.HandleAllocated then
    PostMessage(FEdit.Handle, CM_RELEASE, 0, 0);
  inherited;
end;

procedure TEditLink.EditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  case Key of
    #27:
      begin
        FTree.CancelEditNode;
        Key := #0;
      end;
    #13:
      begin
        FTree.EndEditNode;
        Key := #0;
      end;
  end;
end;

function TEditLink.BeginEdit: Boolean;
begin
  Result := True;
  FEdit.Show;
  FEdit.SetFocus;
end;

function TEditLink.CancelEdit: Boolean;
begin
  Result := True;
  FEdit.Hide;
end;

function TEditLink.EndEdit: Boolean;
var
  Data: PObjectNodeRec;
  Buffer: array[0..1024] of Char;
  S: string;
begin
  Result := True;

  Data := FTree.GetNodeData(FNode);
  try
    GetWindowText(FEdit.Handle, Buffer, 1024);
    S := Buffer;

    if S <> Data.Value[FColumn] then
    begin
      Data.Value[FColumn] := S;
      FTree.Tag := 1;
      FTree.InvalidateNode(FNode);
    end;
  finally
    FEdit.Hide;
    FTree.SetFocus;
  end;
end;

function TEditLink.GetBounds: TRect;
begin
  Result := FEdit.BoundsRect;
end;

function TEditLink.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
  i: Integer;
  Data: PObjectNodeRec;
begin
  Result := Column <> 0;
  if not Result then
    Exit;
  FTree := Tree as TVirtualDrawTree;
  FNode := Node;
  FColumn := Column;

  FEdit.Free;
  FEdit := nil;
  Data := FTree.GetNodeData(Node);

  Result := Data.Level = 1;
  if not Result then
    Exit;

  case Data.ValueType[FColumn] of
    vtString:
      begin
        FEdit := TBCEdit.Create(nil);
        with FEdit as TBCEdit do
        begin
          Visible := False;
          Parent := Tree;
          //Flat := True;
          Text := Data.Value[FColumn];
          OnKeyPress := EditKeyPress;
        end;
      end;
    vtPickString:
      begin
        FEdit := TComboBox.Create(nil);
        with FEdit as TComboBox do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data.Value[FColumn];
          Items.Add(Text);
          for i := 1 to High(ShortCuts) do
            Items.Add(ShortCutToText(ShortCuts[i]));
          OnKeyPress := EditKeyPress;
        end;
      end;
  end;
end;

procedure TEditLink.ProcessMessage(var Message: TMessage);
begin
  FEdit.WindowProc(Message);
end;

procedure TEditLink.SetBounds(R: TRect);
begin
  // Since we don't want to activate grid extensions in the tree (this would influence how the selection is drawn)
  // we have to set the edit's width explicitly to the width of the column.
  FTree.Header.Columns.GetColumnBounds(FColumn, R.Left, R.Right);
  FEdit.BoundsRect := R;
end;

end.
