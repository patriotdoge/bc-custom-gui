pageextension 70506 "Vendor Card Restrict Vis. Ext." extends "Vendor Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Restrict Visibility"; Rec."Restrict Visibility")
            {
                ApplicationArea = All;
                ToolTip = 'When enabled, Purchase Orders from this vendor are only visible to users with the Finance or Strategy team permission sets.';
            }
        }
    }
}