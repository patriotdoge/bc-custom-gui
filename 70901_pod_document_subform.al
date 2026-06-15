page 70901 "POD Document Subform"
{
    Caption = 'POD Documents';
    PageType = ListPart;
    SourceTable = "POD Document";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the uploaded file.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the document.';
                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who uploaded the document.';
                }
                field("Uploaded At"; Rec."Uploaded At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the document was uploaded.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Download)
            {
                ApplicationArea = All;
                Caption = 'Download';
                Image = Download;
                ToolTip = 'Download the selected proof of delivery document.';
                Scope = Repeater;

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    Rec.CalcFields(Content);
                    if not Rec.Content.HasValue() then begin
                        Message('There is no file content to download.');
                        exit;
                    end;
                    Rec.Content.CreateInStream(InStr);
                    FileName := Rec."File Name";
                    DownloadFromStream(InStr, '', '', '', FileName);
                end;
            }
            action(DeleteDocument)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the selected proof of delivery document.';
                Scope = Repeater;

                trigger OnAction()
                begin
                    if not Confirm('Delete document ''%1''?', false, Rec."File Name") then
                        exit;
                    Rec.Delete(true);
                end;
            }
        }
    }
}
