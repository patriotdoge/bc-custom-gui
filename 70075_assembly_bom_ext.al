pageextension 70075 "Assembly BOM Ext Custom GUI" extends "Assembly BOM"
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
