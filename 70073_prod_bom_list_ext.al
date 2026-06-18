pageextension 70073 "Prod. BOM List Ext Custom GUI" extends "Production BOM List"
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
