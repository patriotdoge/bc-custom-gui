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

    trigger OnOpenPage()
    var
        UserPerms: Codeunit "User Permissions Helper";
    begin
        // Restricted POs are invisible to users outside the authorised permission sets.
        // The gate is the single "Restrict Visibility" flag on the Purchase Header —
        // this field is not surfaced on the PO itself; it is set from the Vendor Card.
        if not UserPerms.HasPermissionSet('ADDV_FIN_TEAM_V1') and
           not UserPerms.HasPermissionSet('ADDV STRA TEAM V1')
        then
            Rec.SetRange("Restrict Visibility", false);
    end;
}
