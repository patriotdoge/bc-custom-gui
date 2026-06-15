pageextension 70700 "Transfer Order Ext." extends "Transfer Order"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            ShowMandatory = true;
        }
        modify("Direct Transfer")
        {
            Visible = false;
        }
        modify("Transfer-from Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Location: Record Location;
                LocationList: Page "Location List";
            begin
                Location.SetFilter(Code, '<>EN');
                LocationList.SetTableView(Location);
                LocationList.LookupMode := true;
                if LocationList.RunModal() = Action::LookupOK then begin
                    LocationList.GetRecord(Location);
                    Text := Location.Code;
                    exit(true);
                end;
                exit(false);
            end;
        }
    }
}
