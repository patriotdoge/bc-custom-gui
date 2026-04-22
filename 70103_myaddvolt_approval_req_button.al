pageextension 70103 "MyAddvolt Sales Order Ext" extends "Sales Order"
{
    actions
    {
        // OnBeforeAction fires BEFORE the workflow dispatches the approval request,
        // so the validation error prevents the "request sent" dialog from appearing.
        // This mirrors the pattern used in pageextension 70501 for Purchase Orders.
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                SalesValidation: Codeunit "MyAddvolt Sales Validation";
            begin
                CurrPage.SaveRecord();
                SalesValidation.ValidateForApproval(Rec);
            end;
        }
    }
}
