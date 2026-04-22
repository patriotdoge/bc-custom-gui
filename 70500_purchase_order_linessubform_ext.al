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

    // OnModifyRecord removed — validation is now handled at Release,
    // Request Approval, and Post via event subscribers in Codeunit 70503.
    // This prevents Extended Text auto-insertion from being blocked mid-insert.

    procedure ValidateAllLines()
    var
        ValidationMgt: Codeunit "Purch. Order Validation Mgt.";
        PurchHeader: Record "Purchase Header";
    begin
        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
            ValidationMgt.ValidateAllLines(PurchHeader);
    end;
}
