codeunit 70701 "Transfer Order Validation Sub."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeTransferOrderPostShipment', '', false, false)]
    local procedure OnBeforeTransferOrderPostShipment(var TransferHeader: Record "Transfer Header")
    var
        ValidationMgt: Codeunit "Transfer Order Validation Mgt.";
    begin
        ValidationMgt.ValidateHeader(TransferHeader);
        ValidationMgt.ValidateAllLines(TransferHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransferOrderPostReceipt', '', false, false)]
    local procedure OnBeforeTransferOrderPostReceipt(var TransferHeader: Record "Transfer Header")
    var
        ValidationMgt: Codeunit "Transfer Order Validation Mgt.";
    begin
        ValidationMgt.ValidateHeader(TransferHeader);
        ValidationMgt.ValidateAllLines(TransferHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Transfer Document", 'OnBeforeReleaseTransferDoc', '', false, false)]
    local procedure OnBeforeReleaseTransferDoc(var TransferHeader: Record "Transfer Header")
    var
        ValidationMgt: Codeunit "Transfer Order Validation Mgt.";
    begin
        ValidationMgt.ValidateHeader(TransferHeader);
        ValidationMgt.ValidateAllLines(TransferHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterValidateEvent', 'Transfer-from Code', false, false)]
    local procedure OnAfterValidateTransferFromCode(var Rec: Record "Transfer Header")
    begin
        if Rec."Transfer-from Code" = 'EN' then
            Error('Location "EN" cannot be used as a Transfer-from location.');
    end;
}
