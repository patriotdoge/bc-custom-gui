pageextension 70070 "Item Card Ext Custom GUI" extends "Item Card"
{
    layout
    {
        addafter("No.")
        {
            field("Carrier P/N"; Rec."Carrier P/N")
            {
                ApplicationArea = All;
            }

            field("Spare Part"; Rec."Spare Part")
            {
                ApplicationArea = All;
            }
        }
    }
}
