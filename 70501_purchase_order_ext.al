pageextension 70501 "Purchase Order Header Ext." extends "Purchase Order"
{
    actions
    {
        // Override the standard "Send Approval Request" action so our validation
        // runs BEFORE CheckPurchaseApprovalPossible(), preventing the "approval
        // request has been sent" message from appearing before the error.
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                ValidationMgt: Codeunit "Purch. Order Validation Mgt.";
            begin
                ValidationMgt.ValidateHeader(Rec);
                ValidationMgt.ValidateAllLines(Rec);
            end;
        }

        // Hide Print/Send actions until the document is Released.
        // These are the real actions referenced by the Category_Category10 promoted group.
        modify(Email)
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
        modify("&Print")
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
        modify(SendCustom)
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
        modify(AttachAsPDF)
        {
            Visible = Rec.Status = Rec.Status::Released;
        }
    }
}
