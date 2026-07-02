codeunit 70062 "User Permissions Helper"
{
    SingleInstance = true;
    InherentPermissions = X;
    Permissions = tabledata "Access Control" = R;

    procedure HasPermissionSet(PermissionSetId: Code[20]): Boolean
    var
        AccessControl: Record "Access Control";
    begin
        AccessControl.SetRange("User Security ID", UserSecurityId());
        AccessControl.SetRange("Role ID", PermissionSetId);
        exit(not AccessControl.IsEmpty());
    end;
}
