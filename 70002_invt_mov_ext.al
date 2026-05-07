pageextension 70002 "Internal Movement Ext." extends "Internal Movement"
{
    layout
    {
        addBefore("To Bin Code")
        {
            field("From Bin Code"; Rec."From Bin Code")
            {
                ApplicationArea = All;
                Caption = 'From Bin Code';
                ToolTip = 'Specifies the default bin from which items are moved. Used to pre-fill lines.';

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
        }
    }
}
