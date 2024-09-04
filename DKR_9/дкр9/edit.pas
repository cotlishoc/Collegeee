unit edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

 type

  CompInfo=record
    index,top,left,width,height,fontsize:integer;
  end;
  complist=array of CompInfo;

  { TfEdit }

  TfEdit = class(TForm)
    bCancel: TBitBtn;
    bSave: TBitBtn;
    CBNote1: TComboBox;
    CBNote2: TComboBox;
    eName: TEdit;
    eP: TEdit;
    eDiag: TEdit;
    NModel: TLabel;
    NP: TLabel;
    NDiag: TLabel;
    NBall: TLabel;
    NRus: TLabel;
    procedure eDiagKeyPress(Sender: TObject; var Key: char);
    procedure ePKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    DefWidth,defHeight:integer;
    clist:complist;
  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormShow(Sender: TObject);
begin
  eName.SetFocus;
end;

procedure TfEdit.ePKeyPress(Sender: TObject; var Key: char);
begin
   if not (Key in ['0'..'9', ',', #8]) then
  begin
    Key := #0;
  end
  else if (Key = ',') and (Pos(',', eP.Text) > 0) then
  begin
    Key := #0;
  end;
end;

procedure TfEdit.FormCreate(Sender: TObject);
  var i:integer;
  begin
    defwidth:=width;
    defheight:=height;
    Constraints.MinWidth := 400;
    Constraints.MinHeight := 333;
    for i:= 0 to ComponentCount-1 do
      if (Components[i].Classname ='TBitBtn')
      or (Components[i].Classname ='TComboBox')
      or (Components[i].Classname ='TEdit')
      or (Components[i].Classname ='TLabel') then begin
        setlength(clist,Length(clist)+1);
        clist[Length(clist)-1].top:=(Components[i] as tcontrol).top;
        clist[Length(clist)-1].left:=(Components[i]as tcontrol).left;
        clist[Length(clist)-1].width:=(Components[i] as tcontrol).width;
        clist[Length(clist)-1].height:=(Components[i]as tcontrol).height;
        clist[Length(clist)-1].fontsize:=(Components[i]as tcontrol).font.Size;
        clist[Length(clist)-1].index:=i;
      end;
  end;

procedure TfEdit.FormResize(Sender: TObject);
var i:integer;
begin
  For i:=0 to length(clist)-1 do begin
    (components[clist[i].index] as tcontrol).Top:=round(clist[i].top*height/defheight);
    (components[clist[i].index] as tcontrol).height:=round(clist[i].height*height/defheight);
    (components[clist[i].index] as tcontrol).left:=round(clist[i].left*width/defwidth);
    (components[clist[i].index] as tcontrol).width:=round(clist[i].width*width/defwidth);
  end;
end;



procedure TfEdit.eDiagKeyPress(Sender: TObject; var Key: char);
begin
   if not (Key in ['0'..'9', ',', #8]) then
  begin
    Key := #0;
  end
  else if (Key = ',') and (Pos(',', eP.Text) > 0) then
  begin
    Key := #0;
  end;
end;

end.

