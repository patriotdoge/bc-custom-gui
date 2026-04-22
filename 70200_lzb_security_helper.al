codeunit 70200 "LZB Security Helper"
{
    procedure EnsureLZBEditPermission()
    var
        UserPermissionsHelper: Codeunit "User Permissions Helper";
    begin
        if UserPermissionsHelper.HasPermissionSet('SUPER') then
            exit;

        if not UserPermissionsHelper.HasPermissionSet('ADDV_LZB_EDIT') then
            Error('You are not allowed to create, edit or delete Locations, Zones or Bins.');
    end;
}