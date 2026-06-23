pageextension 70506 "Vendor Card Restrict Vis. Ext." extends "Vendor Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Restrict Visibility"; Rec."Restrict Visibility")
            {
                ApplicationArea = All;
                ToolTip = 'When enabled, Purchase Orders from this vendor are only visible to users with the Finance or Strategy team permission sets.';
                Editable = CanEditRestrictVisibility;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserPerms: Codeunit "User Permissions Helper";
    begin
        CanEditRestrictVisibility :=
            UserPerms.HasPermissionSet('ADDV_FIN_TEAM_V1') or
            UserPerms.HasPermissionSet('SUPER');
    end;

    var
        CanEditRestrictVisibility: Boolean;
}
