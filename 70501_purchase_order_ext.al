pageextension 70501 "Purchase Order Header Ext." extends "Purchase Order"
{
    actions
    {
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
        if not UserPerms.HasPermissionSet('ADDV_FIN_TEAM_V1') and
           not UserPerms.HasPermissionSet('ADDV STRA TEAM V1')
        then
            Rec.SetRange("Restrict Visibility", false);
    end;
}
