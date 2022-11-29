unit USetarFormularioPrincipal;

interface

uses
  Vcl.Forms;

type
  TSetarFormularioPrincipal = class
  public
    class procedure SetarFormularioPrincipal(PNovoFormulario: TForm);
  end;
implementation

{ TSetarFormularioPrincipal }

class procedure TSetarFormularioPrincipal.SetarFormularioPrincipal(
  PNovoFormulario: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := PNovoFormulario;
end;


end.
