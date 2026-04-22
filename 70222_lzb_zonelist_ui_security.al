pageextension 70222 ZoneListSecurityExt extends "Zone List"
{
    trigger OnOpenPage()
    var
        UserPermissionsHelper: Codeunit "User Permissions Helper";
    begin
        if not UserPermissionsHelper.HasPermissionSet('ADDV_LZB_EDIT') then
            CurrPage.Editable(false);
    end;
}