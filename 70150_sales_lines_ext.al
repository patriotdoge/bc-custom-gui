pageextension 70150 SalesLinesExt extends "Sales Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Document Status"; Rec."Document Status")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Document Status");
    end;
}