codeunit 70505 "Purch. Header Vendor Copy Sub."
{
    // Copies "Restrict Visibility" from the selected vendor to the Purchase Header
    // whenever "Buy-from Vendor No." is validated.  The field on the PO can be
    // manually overridden afterwards — no re-lock is applied.
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
}
