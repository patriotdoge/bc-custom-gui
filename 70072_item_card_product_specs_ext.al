pageextension 70072 "Item Card Product Specs Ext" extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group(ProductSpecs)
            {
                Caption = 'Product Specs';
                Visible = IsAAItem;

                field(Family; Rec.Family)
                {
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field(Application; Rec.Application)
                {
                    ApplicationArea = All;
                }
                field(Version; Rec.Version)
                {
                    ApplicationArea = All;
                }
                field(Power; Rec.Power)
                {
                    ApplicationArea = All;
                }
                field("Option 24V-35A"; Rec."Option 24V-35A")
                {
                    ApplicationArea = All;
                }
                field("Option HVDC"; Rec."Option HVDC")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IsAAItem := CopyStr(Rec."No.", 1, 2) = 'AA';
    end;

    var
        IsAAItem: Boolean;
}
