pageextension 70221 LocationCardSecurityExt extends "Location Card"
{
    trigger OnOpenPage()
    var
        UserPermissionsHelper: Codeunit "User Permissions Helper";
    begin
        if not UserPermissionsHelper.HasPermissionSet('ADDV_LZB_EDIT') then
            CurrPage.Editable(false);
    end;
}