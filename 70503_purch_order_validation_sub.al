codeunit 70503 "Purch. Order Validation Sub."
{
    // -------------------------------------------------------------------------
    // POST — fires before Codeunit 90 "Purch.-Post" processes the document
    // -------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        ValidationMgt: Codeunit "Purch. Order Validation Mgt.";
    begin
        if not (PurchaseHeader."Document Type" in
            [PurchaseHeader."Document Type"::Order,
             PurchaseHeader."Document Type"::Invoice])
        then
            exit;

        ValidationMgt.ValidateHeader(PurchaseHeader);
        ValidationMgt.ValidateAllLines(PurchaseHeader);
    end;

    // -------------------------------------------------------------------------
    // RELEASE — fires before Codeunit 414 "Release Purchase Document"
    // -------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        ValidationMgt: Codeunit "Purch. Order Validation Mgt.";
    begin
        if not (PurchaseHeader."Document Type" in
            [PurchaseHeader."Document Type"::Order,
             PurchaseHeader."Document Type"::Invoice])
        then
            exit;

        ValidationMgt.ValidateHeader(PurchaseHeader);
        ValidationMgt.ValidateAllLines(PurchaseHeader);
    end;

    // -------------------------------------------------------------------------
    // REQUEST APPROVAL — handled via OnBeforeAction on the page action in
    // pageextension 70501, which fires before CheckPurchaseApprovalPossible().
    // No event subscriber needed here for approval — a subscriber on
    // OnSendPurchaseDocForApproval fires after the workflow dispatches the
    // notification, which is too late to suppress the "request sent" dialog.
    // -------------------------------------------------------------------------
}
