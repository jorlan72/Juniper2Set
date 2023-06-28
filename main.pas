unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, system.StrUtils,
  ShellAPI, vcl.Clipbrd;

type
  TfrmMain = class(TForm)
    memoInput: TMemo;
    memoOutput: TMemo;
    btnConvert: TButton;
    lblInput: TLabel;
    lblOutput: TLabel;
    procedure btnConvertClick(Sender: TObject);
  private
    tree: TStringList;
    function EndsWith(const s, suffix: string): Boolean;
    function AddToTree(const tree: TStringList; const word: string): TStringList;
    function RemoveWordFromTree(const tree: TStringList): TStringList;
    function PrintTree(const tree: TStringList): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

procedure OpenNotepadWithMemoText(Memo: TMemo);

var
  frmMain: TfrmMain;

implementation

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  tree := TStringList.Create;
end;

destructor TfrmMain.Destroy;
begin
  tree.Free;
  inherited Destroy;
end;

{$R *.dfm}


function TfrmMain.EndsWith(const s, suffix: string): Boolean;
begin
  Result := RightStr(s, Length(suffix)) = suffix;
end;

function TfrmMain.AddToTree(const tree: TStringList; const word: string): TStringList;
begin
  tree.Add(word);
  Result := tree;
end;

function TfrmMain.RemoveWordFromTree(const tree: TStringList): TStringList;
begin
  if tree.Count > 0 then
    tree.Delete(tree.Count - 1);
  Result := tree;
end;

function TfrmMain.PrintTree(const tree: TStringList): string;
begin
  Result := tree.CommaText.Replace(',', ' ');
end;

procedure TfrmMain.btnConvertClick(Sender: TObject);
var
  statements: TStringList;
  line, processedLine: string;
  i: Integer;
  outputLine: string;
begin
  statements := TStringList.Create;
  try
    statements.Text := memoInput.Text;

    memoOutput.Clear;
    tree.Clear;

    for line in statements do
    begin
      // Skip any commented lines
      if Pos('#', line) = 1 then
        Continue;

      // Trim white space from the line
      processedLine := Trim(line);

      // Check if the line ends with ';'
      if EndsWith(processedLine, ';') then
      begin
        processedLine := StringReplace(processedLine, ';', '', [rfReplaceAll]);

        // Check if the tree is empty to avoid excess white spaces
        if tree.Count = 0 then
          memoOutput.Lines.Add('set ' + processedLine)
        else
          memoOutput.Lines.Add('set ' + PrintTree(tree) + ' ' + processedLine);
      end;

      // Check if the line ends with '{'
      if EndsWith(processedLine, '{') then
      begin
        processedLine := StringReplace(processedLine, '{', '', [rfReplaceAll]);
        processedLine := Trim(processedLine);
        tree := AddToTree(tree, processedLine);
      end;

      // Check if the line ends with '}'
      if EndsWith(processedLine, '}') then
      begin
        tree := RemoveWordFromTree(tree);
      end;
    end;
    for i := 0 to memoOutput.Lines.Count - 1 do
  begin
    outputLine := memoOutput.Lines[i];

    if Pos('inactive:', outputLine) > 0 then
    begin
      outputLine := StringReplace(outputLine, 'inactive: ', '', [rfReplaceAll]);
      outputLine := StringReplace(outputLine, 'set', 'deactivate', []);
      memoOutput.Lines[i] := outputLine;
    end;
    memoOutput.Text := StringReplace(memoOutput.Text, '"', '', [rfReplaceAll]);
  end;
  finally
    statements.Free;
//    OpenNotepadWithMemoText(memoOutput);
  end;
end;

procedure OpenNotepadWithMemoText(Memo: TMemo);
var
  NotepadHandle, EditHandle: HWND;
begin
  // Launch a new instance of Notepad
  if ShellExecute(0, 'open', 'notepad.exe', nil, nil, SW_SHOWNORMAL) <= 32 then
  begin
    raise Exception.Create('Unable to open Notepad.');
    Exit;
  end;
  // Wait for the new Notepad instance to be launched
  repeat
    Sleep(100);
    NotepadHandle := FindWindow('Notepad', nil);
  until NotepadHandle <> 0;
  // Bring the new Notepad instance to the foreground
  SetForegroundWindow(NotepadHandle);
  // Get the handle of the Edit control inside Notepad
  EditHandle := FindWindowEx(NotepadHandle, 0, 'Edit', nil);
  if EditHandle = 0 then
  begin
    raise Exception.Create('Unable to find Notepad Edit control.');
    Exit;
  end;
  // Copy the text from the Memo to the clipboard
  Clipboard.AsText := Memo.Lines.Text;
  // Set focus to the Edit control in Notepad
  SetFocus(EditHandle);
  // Paste the text from the clipboard into the Edit control
  SendMessage(EditHandle, WM_PASTE, 0, 0);
  // Move the cursor to the beginning of the Edit control
  SendMessage(EditHandle, EM_SETSEL, 0, 0);
  // Scroll the document to the top
  SendMessage(EditHandle, EM_SCROLLCARET, 0, 0);
end;

end.
