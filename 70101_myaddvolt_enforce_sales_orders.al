codeunit 70101 "MyAddvolt Sales Validation"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    begin
        ValidateMyAddvoltFields(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    begin
        ValidateMyAddvoltFields(SalesHeader);
    end;

    procedure ValidateForApproval(var SalesHeader: Record "Sales Header")
    begin
        ValidateMyAddvoltFields(SalesHeader);
    end;

    local procedure ValidateMyAddvoltFields(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        SalesHeader.TestField("External Document No.");
        SalesHeader.TestField("Salesperson Code");
        SalesHeader.TestField("Requested Delivery Date");
        SalesHeader.TestField("Ship-to Name");
        SalesHeader.TestField("Ship-to Address");
        SalesHeader.TestField("Ship-to City");
        SalesHeader.TestField("Ship-to Post Code");
        SalesHeader.TestField("Ship-to Country/Region Code");
        SalesHeader.TestField("Ship-to Phone No.");
        SalesHeader.TestField("Ship-to Contact");
        SalesHeader.TestField("Shipment Method Code");
        SalesHeader.TestField("Shipping Agent Code");
        SalesHeader.TestField("Shipping Agent Service Code");

        ValidateAttachments(SalesHeader);

        ValidateSalesLines(SalesHeader);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", 'AA*');
        if SalesLine.IsEmpty then
            exit;

        SalesHeader.TestField("Vehicle Type");
        SalesHeader.TestField("Engine Type");
        SalesHeader.TestField("Battery Voltage");
        SalesHeader.TestField("Main Input/Output");
        SalesHeader.TestField("HMI Mode");
        SalesHeader.TestField("HMI Start Settings");
        SalesHeader.TestField("CAN 2 Protocol");
        SalesHeader.TestField("HVDC Output");
        SalesHeader.TestField("Engine Generator");
        SalesHeader.TestField("Engine Generator Config.");
        SalesHeader.TestField("Ecodrive on Hybrid Vehicles");
        SalesHeader.TestField("Kinetic Generator");
        SalesHeader.TestField("Installation Required");
        SalesHeader.TestField("LVDC Output");
        SalesHeader.TestField("Reefer YN");
        SalesHeader.TestField("Branding Kit");
    end;

    local procedure ValidateSalesLines(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesLine.Type <> SalesLine.Type::" " then
                    if SalesLine."Shortcut Dimension 1 Code" = '' then
                        Error(
                            '"Department Code" (Shortcut Dimension 1) must be filled in on all Sales Order lines.\Line No.: %1',
                            SalesLine."Line No."
                        );
            until SalesLine.Next() = 0;
    end;

    local procedure ValidateAttachments(var SalesHeader: Record "Sales Header")
    var
        DocAttachment: Record "Document Attachment";
    begin
        DocAttachment.SetRange("Table ID", Database::"Sales Header");
        DocAttachment.SetRange("No.", SalesHeader."No.");
        DocAttachment.SetRange("Document Type", SalesHeader."Document Type");
        if DocAttachment.IsEmpty then
            Error('At least one file must be attached to the Sales Order before it can be released or posted.');
    end;
}
