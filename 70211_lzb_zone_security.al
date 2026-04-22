tableextension 70211 ZoneSecurityExt extends Zone
{
    trigger OnBeforeInsert()
    var
        LZBSecurity: Codeunit "LZB Security Helper";
    begin
        LZBSecurity.EnsureLZBEditPermission();
    end;

    trigger OnBeforeModify()
    var
        LZBSecurity: Codeunit "LZB Security Helper";
    begin
        LZBSecurity.EnsureLZBEditPermission();
    end;

    trigger OnBeforeDelete()
    var
        LZBSecurity: Codeunit "LZB Security Helper";
    begin
        LZBSecurity.EnsureLZBEditPermission();
    end;
}