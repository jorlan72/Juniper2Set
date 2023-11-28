program Juniper2Set;

uses
  Vcl.Forms,
  main in 'main.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Juniper2SET';
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
