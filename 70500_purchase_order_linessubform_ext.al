pageextension 70500 "Purch. Order Subform Ext." extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Carrier P/N"; Rec."Carrier P/N")
            {
                ApplicationArea = All;
                Caption = 'Carrier P/N';
                ToolTip = 'Specifies the Carrier Part Number associated with the item.';
                Visible = true;
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Carrier P/N");
    end;


    procedure ValidateAllLines()
    var
        ValidationMgt: Codeunit "Purch. Order Validation Mgt.";
        PurchHeader: Record "Purchase Header";
    begin
        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
            ValidationMgt.ValidateAllLines(PurchHeader);
    end;
}
