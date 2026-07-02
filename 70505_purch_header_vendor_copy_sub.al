codeunit 70505 "Purch. Header Vendor Copy Sub."
{
    InherentPermissions = X;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure OnAfterValidateBuyFromVendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header")
    var
        Vendor: Record Vendor;
    begin
        if Vendor.Get(Rec."Buy-from Vendor No.") then
            Rec."Restrict Visibility" := Vendor."Restrict Visibility"
        else
            Rec."Restrict Visibility" := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterValidateEvent', 'Restrict Visibility', false, false)]
    local procedure OnAfterValidateVendorRestrictVisibility(var Rec: Record Vendor; var xRec: Record Vendor)
    var
        PurchHeader: Record "Purchase Header";
        PurchHeaderArchive: Record "Purchase Header Archive";
    begin
        if Rec."Restrict Visibility" = xRec."Restrict Visibility" then
            exit;

        PurchHeader.SetRange("Buy-from Vendor No.", Rec."No.");
        PurchHeader.ModifyAll("Restrict Visibility", Rec."Restrict Visibility", false);

        PurchHeaderArchive.SetRange("Buy-from Vendor No.", Rec."No.");
        PurchHeaderArchive.ModifyAll("Restrict Visibility", Rec."Restrict Visibility", false);
    end;
}
