pageextension 70071 "Item List Ext Custom GUI" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("Carrier P/N"; Rec."Carrier P/N")
            {
                ApplicationArea = All;
            }
        }

        addafter("Type")
        {
            field("Spare Part"; Rec."Spare Part")
            {
                ApplicationArea = All;
            }

        }
    }
}
