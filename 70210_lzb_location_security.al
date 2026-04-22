tableextension 70210 LocationSecurityExt extends Location
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