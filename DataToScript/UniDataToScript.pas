unit UniDataToScript;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, RzLabel, RzCmboBx, Data.DB,
  Data.Win.ADODB, System.IniFiles, Vcl.CheckLst, Winapi.ShellAPI;

type
  TForm3 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    BitBtn1: TBitBtn;
    RzLabel1: TRzLabel;
    BitBtn2: TBitBtn;
    LabeledEdit4: TLabeledEdit;
    ADOConnection1: TADOConnection;
    ListBox1: TListBox;
    RzLabel2: TRzLabel;
    ADOQuery1: TADOQuery;
    RzLabel3: TRzLabel;
    CheckListBox1: TCheckListBox;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FTabelName: string;
    FStrList: TStringList;
    FIniFile: TIniFile;
    procedure SaveToIni;
    procedure ReadFromIni;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.BitBtn1Click(Sender: TObject);
var
  ConnectionString: string;
begin
  ADOConnection1.Connected := False;
  ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;' +
    'User ID=' + Trim(LabeledEdit2.Text) + ';' + 'Initial Catalog=' +
    Trim(LabeledEdit4.Text) + ';' + 'Data Source=' + Trim(LabeledEdit1.Text);
  if Trim(LabeledEdit3.Text) <> '' then
    ConnectionString := ConnectionString+';Password=' + Trim(LabeledEdit3.Text);
  ADOConnection1.ConnectionString := ConnectionString;
  ADOConnection1.Connected := True;
  ADOConnection1.KeepConnection := True;
  with ListBox1 do
  begin
    Items.Clear;
    ADOConnection1.GetTableNames(Items);
  end;
  SaveToIni;
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
const
  CField = '''%s'', ';
var
  TemStr, TemStr2, TemSqlStr, TemField, TemFileName, TemDir: string;
  i: Integer;
begin
  if ListBox1.ItemIndex < 0 then Exit;

  TemStr := 'insert into ' + FTabelName + ' (';
  for i := 0 to CheckListBox1.Items.Count - 1 do
  begin
    if CheckListBox1.Checked[i] then
      TemStr := TemStr + CheckListBox1.Items[i] + ', ';
  end;
  TemStr := Copy(TemStr, 1, Length(TemStr)-2);
  TemStr := TemStr + ') values (';

  TemSqlStr := 'select * from ' + FTabelName + ' order by ' + CheckListBox1.Items[0];
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add(TemSqlStr);
  ADOQuery1.Open;
  if ADOQuery1.RecordCount > 0 then
  begin
    FStrList.Clear;
    FStrList.Add('--数据来源：' + Trim(LabeledEdit1.Text) + '  ' + Trim(LabeledEdit4.Text));
    FStrList.Add('--导出时间：' + DateTimeToStr(Now));
    while not ADOQuery1.Eof do
    begin
      TemStr2 := TemStr;
      for i := 0 to CheckListBox1.Items.Count - 1 do
      begin
        if CheckListBox1.Checked[i] then
        begin
          TemField := Format(CField, [ADOQuery1.FieldByName(CheckListBox1.Items[i]).AsString]);
          TemStr2 := TemStr2 + TemField;
        end;
      end;
      TemStr2 := Copy(TemStr2, 1, Length(TemStr2)-2) + ');';
      FStrList.Add(TemStr2);
      ADOQuery1.Next;
    end;
    TemFileName := FTabelName + '_' + FormatDateTime('yyyymmddhhmmss', Now) + '.sql';
    TemDir := GetCurrentDir + '\Save\';
    if not DirectoryExists(TemDir) then
      ForceDirectories(TemDir);
    FStrList.SaveToFile(TemDir + TemFileName);

    ShowMessage('导出完成：' + TemFileName);
  end;
end;

procedure TForm3.BitBtn3Click(Sender: TObject);
var
  TemDir: PWideChar;
begin
  TemDir := PWideChar(GetCurrentDir + '\Save\');
  if not DirectoryExists(TemDir) then
    ForceDirectories(TemDir);
  ShellExecute(0, nil, TemDir, nil, nil, SW_SHOW);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FStrList := TStringList.Create;
  FIniFile := TIniFile.Create(GetCurrentDir + '\Config.ini');
  ReadFromIni;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  FStrList.Free;
  FIniFile.Free;
end;

procedure TForm3.ListBox1Click(Sender: TObject);
var
  TemSql: AnsiString;
  i: Integer;
begin
  if ListBox1.ItemIndex < 0 then Exit;

  FTabelName := ListBox1.Items[ListBox1.ItemIndex];
  if FTabelName <> '' then
  begin
    CheckListBox1.Items.Clear;
    ADOConnection1.GetFieldNames(FTabelName, CheckListBox1.Items);
    CheckListBox1.CheckAll(cbChecked);

    TemSql := 'select colstat, name from syscolumns where id=object_id(' + QuotedStr(FTabelName) + ')';
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add(TemSql);
    ADOQuery1.Open;
    for i := 0 to ADOQuery1.RecordCount - 1 do
    begin
      if (ADOQuery1.Fields[0].AsInteger in [1, 4]) and (ADOQuery1.Fields[1].AsString = CheckListBox1.Items[i]) then
        CheckListBox1.Checked[i] := False
      else
        CheckListBox1.Checked[i] := True;
      ADOQuery1.Next;
    end;
  end;
end;

procedure TForm3.ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  TemIndex: Integer;
  TemPoint: TPoint;
begin
  TemPoint.X := X;
  TemPoint.Y := Y;
  TemIndex := ListBox1.ItemAtPos(TemPoint, True);
  if TemIndex >=0 then
    ListBox1.Hint := ListBox1.Items[TemIndex];
end;

procedure TForm3.ReadFromIni;
begin
  LabeledEdit1.Text := FIniFile.ReadString('Connect', 'IP', '192.168.1.1');
  LabeledEdit2.Text := FIniFile.ReadString('Connect', 'User', 'sa');
  LabeledEdit3.Text := FIniFile.ReadString('Connect', 'Password', '');
  LabeledEdit4.Text := FIniFile.ReadString('Connect', 'DBName', '');
end;

procedure TForm3.SaveToIni;
begin
  FIniFile.WriteString('Connect', 'IP', Trim(LabeledEdit1.Text));
  FIniFile.WriteString('Connect', 'User', Trim(LabeledEdit2.Text));
  FIniFile.WriteString('Connect', 'Password', Trim(LabeledEdit3.Text));
  FIniFile.WriteString('Connect', 'DBName', Trim(LabeledEdit4.Text));
end;

end.
