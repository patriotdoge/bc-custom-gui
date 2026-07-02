codeunit 70503 "Purch. Order Validation Sub."
{
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

}
