codeunit 70401 "SQ to INV Blocked Item Check"
{
    Access = Internal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Invoice",
        'OnBeforeInsertSalesInvoiceLine', '', false, false)]
    local procedure CheckBlockedItemOnMakeInvoice(
        SalesQuoteLine: Record "Sales Line";
        SalesQuoteHeader: Record "Sales Header";
        var SalesInvoiceLine: Record "Sales Line";
        SalesInvoiceHeader: Record "Sales Header")
    var
        Item: Record Item;
    begin
        if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then
            exit;
        if SalesInvoiceLine."No." = '' then
            exit;

        if Item.Get(SalesInvoiceLine."No.") then
            if Item."Sales Blocked" then
                Error(
                    'You cannot convert quote %1 to an invoice because item %2 (%3) is Sales Blocked.',
                    SalesQuoteHeader."No.", Item."No.", Item.Description);
    end;
}