codeunit 70701 "Transfer Order Validation Sub."
{
    // -------------------------------------------------------------------------
    // POST SHIPMENT — fires before Codeunit 5704 "TransferOrder-Post Shipment"
    // -------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeTransferOrderPostShipment', '', false, false)]
    local procedure OnBeforeTransferOrderPostShipment(var TransferHeader: Record "Transfer Header")
    var
        ValidationMgt: Codeunit "Transfer Order Validation Mgt.";
    begin
        ValidationMgt.ValidateHeader(TransferHeader);
        ValidationMgt.ValidateAllLines(TransferHeader);
    end;

    // -------------------------------------------------------------------------
    // POST RECEIPT — fires before Codeunit 5705 "TransferOrder-Post Receipt"
    // -------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransferOrderPostReceipt', '', false, false)]
    local procedure OnBeforeTransferOrderPostReceipt(var TransferHeader: Record "Transfer Header")
    var
        ValidationMgt: Codeunit "Transfer Order Validation Mgt.";
    begin
        ValidationMgt.ValidateHeader(TransferHeader);
        ValidationMgt.ValidateAllLines(TransferHeader);
    end;

    // -------------------------------------------------------------------------
    // RELEASE — fires before Codeunit 5709 "Release Transfer Document"
    // -------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Transfer Document", 'OnBeforeReleaseTransferDoc', '', false, false)]
    local procedure OnBeforeReleaseTransferDoc(var TransferHeader: Record "Transfer Header")
    var
        ValidationMgt: Codeunit "Transfer Order Validation Mgt.";
    begin
        ValidationMgt.ValidateHeader(TransferHeader);
        ValidationMgt.ValidateAllLines(TransferHeader);
    end;
}
