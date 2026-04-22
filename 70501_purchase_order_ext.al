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
    }
}
