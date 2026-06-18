pageextension 70074 "Prod. BOM Lines Ext Custom GUI" extends "Production BOM Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Carrier P/N"; ItemRec."Carrier P/N")
            {
                ApplicationArea = All;
                Caption = 'Carrier P/N';
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not ItemRec.Get(Rec."No.") then
            Clear(ItemRec);
    end;

    var
        ItemRec: Record Item;
}
