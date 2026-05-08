pageextension 70003 "Invt. Mov. Lines Shelf Ext." extends "Invt. Movement Subform"
{
    actions
    {
        addlast(Processing)
        {
            action("Fill Shelf No.")
            {
                ApplicationArea = All;
                Caption = 'Fill Shelf No. from Item';

                trigger OnAction()
                begin
                    FillShelfNoFromItem();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FillShelfNoFromItem();
    end;

    local procedure FillShelfNoFromItem()
    var
        WhseActLine: Record "Warehouse Activity Line";
        ItemRec: Record Item;
    begin
        WhseActLine.CopyFilters(Rec);

        if WhseActLine.FindSet() then
            repeat
                if (WhseActLine."Item No." <> '') and
                   ItemRec.Get(WhseActLine."Item No.") and
                   (ItemRec."Shelf No." <> '') then begin
                    if WhseActLine."Shelf No." <> ItemRec."Shelf No." then begin
                        WhseActLine.Validate("Shelf No.", ItemRec."Shelf No.");
                        WhseActLine.Modify();
                    end;
                end;
            until WhseActLine.Next() = 0;
    end;
}
