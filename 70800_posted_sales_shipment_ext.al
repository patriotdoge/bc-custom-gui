pageextension 70800 "Posted Sales Shipment Ext." extends "Posted Sales Shipment"
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