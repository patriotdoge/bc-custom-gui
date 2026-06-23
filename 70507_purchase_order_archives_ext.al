pageextension 70507 "Purchase Order Archives Ext." extends "Purchase Order Archives"
{
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
