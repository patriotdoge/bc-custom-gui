codeunit 70505 "Purch. Header Vendor Copy Sub."
{
    // Copies "Restrict Visibility" from the selected vendor to the Purchase Header
    // whenever "Buy-from Vendor No." is validated.  The field on the PO can be
    // manually overridden afterwards — no re-lock is applied.
    //
    // Also propagates changes made directly to the vendor's "Restrict Visibility"
    // flag to all existing (non-posted) Purchase Headers for that vendor.
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
        // Skip if the value didn't actually change.
        if Rec."Restrict Visibility" = xRec."Restrict Visibility" then
            exit;

        // Propagate to all non-posted Purchase Headers for this vendor.
        PurchHeader.SetRange("Buy-from Vendor No.", Rec."No.");
        PurchHeader.ModifyAll("Restrict Visibility", Rec."Restrict Visibility", false);

        // Propagate to all archived Purchase Headers for this vendor (all versions).
        PurchHeaderArchive.SetRange("Buy-from Vendor No.", Rec."No.");
        PurchHeaderArchive.ModifyAll("Restrict Visibility", Rec."Restrict Visibility", false);
    end;
}
