pageextension 70103 "MyAddvolt Sales Order Ext" extends "Sales Order"
{
    actions
    {
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
