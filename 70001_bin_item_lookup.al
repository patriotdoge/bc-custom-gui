page 70001 "Bin Item Lookup"
{
    Caption = 'Bin Item Lookup';
    PageType = List;
    SourceTable = "Bin Content";
    SourceTableView = sorting("Item No.") where(Quantity = filter(> 0));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field(Description; ItemDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        ItemRec: Record Item;
    begin
        if ItemRec.Get(Rec."Item No.") then
            ItemDescription := ItemRec.Description
        else
            ItemDescription := '';
    end;

    var
        ItemDescription: Text[100];
}
