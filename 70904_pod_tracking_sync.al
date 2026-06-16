codeunit 70904 "POD Tracking Sync"
{
    InherentPermissions = X;
    Permissions = tabledata "Sales Shipment Header" = m;
    [EventSubscriber(ObjectType::Table, Database::"POD Document", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterPODDocModify(var Rec: Record "POD Document"; var xRec: Record "POD Document"; RunTrigger: Boolean)
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if Rec."Tracking No." = xRec."Tracking No." then
            exit;
        if SalesShipmentHeader.Get(Rec."Shipment No.") then begin
            SalesShipmentHeader."Package Tracking No." := Rec."Tracking No.";
            SalesShipmentHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"POD Document", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterPODDocInsert(var Rec: Record "POD Document"; RunTrigger: Boolean)
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if Rec."Tracking No." = '' then
            exit;
        if SalesShipmentHeader.Get(Rec."Shipment No.") then begin
            SalesShipmentHeader."Package Tracking No." := Rec."Tracking No.";
            SalesShipmentHeader.Modify();
        end;
    end;
}
