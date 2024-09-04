unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, edit,
  Grids;

Type
  Models = record
    Name: string[60];
    P:integer;
    Diag: double;
    Note1: string[5];
    Note2: string[5];
  end;

type
     CompInfo=record
    index,top,left,width,height,fontsize:integer;
  end;
  complist=array of CompInfo;
  { TfMain }

  TfMain = class(TForm)
    bAdd: TSpeedButton;
    bDel: TSpeedButton;
    bEdit: TSpeedButton;
    bSort: TSpeedButton;
    Panel1: TPanel;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
   DefWidth,defHeight:integer;
    clist:complist;
  public

  end;

var
  fMain: TfMain;
  adres: string;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.bAddClick(Sender: TObject);
begin
  //очищаем поля, если там что-то есть:
  fEdit.eName.Text:= '';
  fEdit.eP.Text:= '';
  fEdit.eDiag.Text:='';
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //если пользователь ничего не ввел - выходим:
  if (fEdit.eName.Text= '') or (fEdit.eDiag.Text='') or (fEdit.eP.Text= '') then exit;
  //если пользователь не нажал "Сохранить" - выходим:
  if fEdit.ModalResult <> mrOk then exit;
  //иначе добавляем в сетку строку, и заполняем её:
  SG.RowCount:= SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1]:= fEdit.eName.Text;
  SG.Cells[1, SG.RowCount-1]:= fEdit.eP.Text;
  SG.Cells[2, SG.RowCount-1]:= fEdit.eDiag.Text;
  SG.Cells[3, SG.RowCount-1]:= fEdit.CBNote1.Text;
  SG.Cells[4, SG.RowCount-1]:= fEdit.CBNote2.Text;
end;

procedure TfMain.bDelClick(Sender: TObject);
begin
  if SG.RowCount = 1 then exit;
  //иначе выводим запрос на подтверждение:
  if MessageDlg('Требуется подтверждение',
                'Вы действительно хотите удалить контакт "' +
                SG.Cells[0, SG.Row] + '"?',
      mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
         SG.DeleteRow(SG.Row);
end;

procedure TfMain.bEditClick(Sender: TObject);
begin
  //если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе записываем данные в форму редактора:
  fEdit.eName.Text:= SG.Cells[0, SG.Row];
  fEdit.eP.Text:= SG.Cells[1, SG.Row];
  fEdit.eDiag.Text:= SG.Cells[2, SG.Row];
  fEdit.CBNote1.Text:= SG.Cells[3, SG.Row];
  fEdit.CBNote2.Text:=SG.Cells[4,Sg.Row];
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //сохраняем в сетку возможные изменения,
  //если пользователь нажал "Сохранить":
  if fEdit.ModalResult = mrOk then begin
    SG.Cells[0, SG.Row]:= fEdit.eName.Text;
    SG.Cells[1, SG.Row]:= fEdit.eP.Text;
    SG.Cells[2, SG.Row]:= fEdit.eDiag.Text;
    SG.Cells[3, SG.Row]:= fEdit.CBNote1.Text;
    SG.Cells[4, SG.Row]:= fEdit.CBNote2.Text;
  end;
end;

procedure TfMain.bSortClick(Sender: TObject);
begin
  if SG.RowCount = 1 then exit;
  //иначе сортируем список:
  SG.SortColRow(true, 0);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Models; //для очередной записи
  f: file of Models; //файл данных
  i: integer; //счетчик цикла
begin
  //если строки данных пусты, просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе открываем файл для записи:
  try
    AssignFile(f, adres + 'Vivo.dat');
    Rewrite(f);
    //теперь цикл - от первой до последней записи сетки:
    for i:= 1 to SG.RowCount-1 do begin
      //получаем данные текущей записи:
      MyCont.Name:= SG.Cells[0, i];
      MyCont.P:= StrToInt(SG.Cells[1, i]);
      MyCont.Diag:= StrToFloat(SG.Cells[2,i]);
      MyCont.Note1:= SG.Cells[3, i];
      MyCont.Note2:= SG.Cells[4, i];
      //записываем их:
      Write(f, MyCont);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Models; //для очередной записи
  f: file of Models; //файл данных
  i: integer;
begin
  //сначала получим адрес программы:
  adres:= ExtractFilePath(ParamStr(0));
  //настроим сетку:
  SG.Cells[0, 0]:= 'Модель';
  SG.Cells[1, 0]:= 'Цена';
  SG.Cells[2, 0]:= 'Диагональ';
  SG.Cells[3, 0]:= 'Оценка';
  SG.Cells[4, 0]:= 'Продается в России';
  SG.ColWidths[0]:= Round(0.25 * ClientWidth);
  SG.ColWidths[1]:= Round(0.2 * ClientWidth);
  SG.ColWidths[2]:= Round(0.2 * ClientWidth);
  SG.ColWidths[3]:= Round(0.18 * ClientWidth);
  SG.ColWidths[4]:= Round(0.17 * ClientWidth);
  //если файла данных нет, просто выходим:
  if not FileExists(adres + 'vivo.dat') then exit;
  //иначе файл есть, открываем его для чтения и
  //считываем данные в сетку:
  try
    AssignFile(f, adres + 'vivo.dat');
    Reset(f);
    //теперь цикл - от первой до последней записи сетки:
    while not Eof(f) do begin
      //считываем новую запись:
      Read(f, MyCont);
      //добавляем в сетку новую строку, и заполняем её:
        SG.RowCount:= SG.RowCount + 1;
        SG.Cells[0, SG.RowCount-1]:= MyCont.Name;
        SG.Cells[1, SG.RowCount-1]:= IntToStr(MyCont.P);
        SG.Cells[2, SG.RowCount-1]:= FloatToStr(MyCont.Diag);
        SG.Cells[3, SG.RowCount-1]:= MyCont.Note1;
        SG.Cells[4, SG.RowCount-1]:= MyCont.Note2;
    end;
  finally
    CloseFile(f);
  end;
  defwidth := width;
  defheight := height;
  Constraints.MinWidth := 804;
  Constraints.MinHeight := 300;
  for i := 0 to ComponentCount - 1 do
    if (Components[i].Classname = 'TSpeedButton')
    or (Components[i].Classname = 'TPanel')
    or (Components[i].Classname = 'TStringGrid') then begin
      setlength(clist, Length(clist) + 1);
      clist[Length(clist) - 1].top := (Components[i] as tcontrol).top;
      clist[Length(clist) - 1].left := (Components[i] as tcontrol).left;
      clist[Length(clist) - 1].width := (Components[i] as tcontrol).width;
      clist[Length(clist) - 1].height := (Components[i] as tcontrol).height;
      clist[Length(clist) - 1].fontsize := (Components[i] as tcontrol).font.Size;
      clist[Length(clist) - 1].index := i;
    end;
end;

procedure TfMain.FormResize(Sender: TObject);
var i:integer;
begin
  For i:=0 to length(clist)-1 do begin
    (components[clist[i].index] as tcontrol).Top:=round(clist[i].top*height/defheight);
    (components[clist[i].index] as tcontrol).height:=round(clist[i].height*height/defheight);
    (components[clist[i].index] as tcontrol).left:=round(clist[i].left*width/defwidth);
    (components[clist[i].index] as tcontrol).width:=round(clist[i].width*width/defwidth);
  end;
  SG.ColWidths[0]:= Round(0.25 * ClientWidth);
  SG.ColWidths[1]:= Round(0.2 * ClientWidth);
  SG.ColWidths[2]:= Round(0.2 * ClientWidth);
  SG.ColWidths[3]:= Round(0.18 * ClientWidth);
  SG.ColWidths[4]:= Round(0.17 * ClientWidth);
end;


end.

