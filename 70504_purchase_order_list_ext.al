pageextension 70504 "Purchase Order List Ext." extends "Purchase Order List"
{
    actions
    {
        // Hide Print/Send actions until the document is Released.
        // Visibility is evaluated against the currently selected record.
        // These are the real actions referenced by the Category_Category5 promoted group.
        modify(Email)
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
        modify(Print)
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
        modify(Send)
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
        modify(AttachAsPDF)
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
    }
}
