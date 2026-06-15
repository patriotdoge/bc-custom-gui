pageextension 70801 "Posted Sales Shipments Ext." extends "Posted Sales Shipments"
{
    layout
    {
        addfirst(factboxes)
        {
            part(AttachmentFactBox; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(110), "No." = field("No.");
            }
        }
    }
}
