unit DMVC.Expert.CodeGen.NewControllerUnit;

interface

uses
  ToolsApi,
  DMVC.Expert.CodeGen.NewUnit;

type
  TNewControllerUnitEx = class(TNewUnit)
  protected
    FCreateIndexMethod : Boolean;
    FControllerClassName : String;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile; override;
  public
    constructor Create(const aCreateIndexMethod : boolean; const AControllerClassName: String; const APersonality : String = '' );
  end;

implementation

uses
  System.SysUtils,
  VCL.Dialogs,
  DMVC.Expert.CodeGen.Templates,
  DMVC.Expert.CodeGen.SourceFile;


constructor TNewControllerUnitEx.Create(const aCreateIndexMethod : boolean; const AControllerClassName : String; const APersonality : String = '' );
begin
  Assert(Length(AControllerClassName) > 0);
  FAncestorName := '';
  FFormName := '';
  FImplFileName := '';
  FIntfFileName := '';
  FControllerClassName := AControllerClassName;
  FCreateIndexMethod := aCreateIndexMethod;
  Personality := APersonality;
end;

function TNewControllerUnitEx.NewImplSource(const ModuleIdent, FormIdent,  AncestorIdent: string): IOTAFile;
var
  lUnitIdent: string;
  lFormName: string;
  lFileName: string;
  lIndexMethodIntf: string;
  lIndexMethodImpl: string;
  lControllerUnit: string;
 begin
   lControllerUnit := sControllerUnit;
   lIndexMethodIntf := sIndexMethodIntf;
   lIndexMethodImpl := Format(sIndexMethodImpl,[FControllerClassName]);


   if not FCreateIndexMethod then
   begin
      lIndexMethodIntf := '';
      lIndexMethodImpl := '';
   end;
    // http://stackoverflow.com/questions/4196412/how-do-you-retrieve-a-new-unit-name-from-delphis-open-tools-api
    // So using method mentioned by Marco Cantu.
   (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName( '', lUnitIdent, lFormName, lFileName);
   Result := TSourceFile.Create(sControllerUnit, [lUnitIdent, FControllerClassName, lIndexMethodIntf, lIndexMethodImpl]);
end;


end.
