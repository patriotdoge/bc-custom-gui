pageextension 70000 InvtMovementSubformExt extends "Internal Movement Subform"
{
    layout
    {
        modify("Item No.")
        {
            Visible = false;
        }
        addafter("Item No.")
        {
            field("Item Search"; Rec."Item Search")
            {
                ApplicationArea = All;
                Caption = 'Item No.';
                LookupPageId = "Bin Item Lookup";

                trigger OnValidate()
                begin
                    Rec.Validate("Item No.", Rec."Item Search");
                    CurrPage.Update(true);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Item Search" := Rec."Item No.";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        InvtMovHeader: Record "Internal Movement Header";
    begin
        if Rec."No." = '' then
            exit;
        if not InvtMovHeader.Get(Rec."No.") then
            exit;
        if InvtMovHeader."From Bin Code" <> '' then
            Rec.Validate("From Bin Code", InvtMovHeader."From Bin Code");
        if InvtMovHeader."To Bin Code" <> '' then
            Rec.Validate("To Bin Code", InvtMovHeader."To Bin Code");
    end;
}
