codeunit 70400 "SQ to SO Blocked Item Check"
{
    Access = Internal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order",
        'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure CheckBlockedItemOnMakeOrder(
        var SalesOrderLine: Record "Sales Line";
        SalesOrderHeader: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
        SalesQuoteHeader: Record "Sales Header")
    var
        Item: Record Item;
    begin
        if SalesOrderLine.Type <> SalesOrderLine.Type::Item then
            exit;
        if SalesOrderLine."No." = '' then
            exit;

        if Item.Get(SalesOrderLine."No.") then
            if Item."Sales Blocked" then
                Error(
                    'You cannot convert quote %1 to an order because item %2 (%3) is Sales Blocked.',
                    SalesQuoteHeader."No.", Item."No.", Item.Description);
    end;
}
