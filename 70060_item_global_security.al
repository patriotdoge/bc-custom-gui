tableextension 70060 "Item Security Ext" extends Item
{
    trigger OnModify()
    begin
        EnforceItemSecurity();
    end;

    trigger OnInsert()
    begin
        if not HasFullAccess() then
            Error('Item creation is not allowed.');
    end;

    trigger OnDelete()
    begin
        if not HasFullAccess() then
            Error('Item deletion is not allowed.');
    end;

    local procedure EnforceItemSecurity()
    begin
        // CRITICAL: Production/Purchasing Blocked - FULL ACCESS ONLY
        if BlockedFieldsChanged() then
            if not HasFullAccess() then
                Error('You are not allowed to modify Production/Purchasing Blocked fields.');

        // LOG team: Inventory + Warehouse FastTabs
        if InventoryFieldsChanged() or WarehouseFieldsChanged() then
            if not HasPermissionSet('ADDV_LOG_TEAM_V1') and not HasFullAccess() then
                Error('You are not allowed to modify Inventory or Warehouse fields.');

        // PUR team: Replenishment + Planning FastTabs
        if ReplenishmentFieldsChanged() or PlanningFieldsChanged() then
            if not HasPermissionSet('ADDV_PUR_TEAM_V1') and not HasFullAccess() then
                Error('You are not allowed to modify Replenishment or Planning fields.');

        // PRICE edit: Costs & Posting / Prices & Sales
        if PriceFieldsChanged() then
            if not HasPriceEditAccess() then
                Error('You are not allowed to modify item prices.');
    end;

    local procedure BlockedFieldsChanged(): Boolean  // NEW - Full Access Only
    begin
        exit(
            ("Purchasing Blocked" <> xRec."Purchasing Blocked") or
            ("Production Blocked" <> xRec."Production Blocked") or
            ("Sales Blocked" <> xRec."Sales Blocked") or
            ("Service Blocked" <> xRec."Service Blocked")
        );
    end;

    local procedure InventoryFieldsChanged(): Boolean
    begin
        exit(
            ("Shelf No." <> xRec."Shelf No.") or
            ("Created From Nonstock Item" <> xRec."Created From Nonstock Item") or
            ("Stockout Warning" <> xRec."Stockout Warning") or
            ("Prevent Negative Inventory" <> xRec."Prevent Negative Inventory") or
            ("Net Weight" <> xRec."Net Weight") or
            ("Gross Weight" <> xRec."Gross Weight") or
            ("Unit Volume" <> xRec."Unit Volume") or
            ("Over-Receipt Code" <> xRec."Over-Receipt Code")
        );
    end;

    local procedure PriceFieldsChanged(): Boolean
    begin
        exit(
            ("Unit Price" <> xRec."Unit Price") or
            ("Price Includes VAT" <> xRec."Price Includes VAT") or
            ("Price/Profit Calculation" <> xRec."Price/Profit Calculation") or
            ("Profit %" <> xRec."Profit %") or
            ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") or
            ("Item Disc. Group" <> xRec."Item Disc. Group") or
            ("Sales Unit of Measure" <> xRec."Sales Unit of Measure")
        );
    end;

    local procedure WarehouseFieldsChanged(): Boolean
    begin
        exit(
            ("Warehouse Class Code" <> xRec."Warehouse Class Code") or
            ("Special Equipment Code" <> xRec."Special Equipment Code") or
            ("Put-away Template Code" <> xRec."Put-away Template Code") or
            ("Put-away Unit of Measure Code" <> xRec."Put-away Unit of Measure Code") or
            ("Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code") or
            ("Last Phys. Invt. Date" <> xRec."Last Phys. Invt. Date") or
            ("Last Counting Period Update" <> xRec."Last Counting Period Update") or
            ("Next Counting Start Date" <> xRec."Next Counting Start Date") or
            ("Next Counting End Date" <> xRec."Next Counting End Date") or
            ("Use Cross-Docking" <> xRec."Use Cross-Docking")
        );
    end;

    local procedure ReplenishmentFieldsChanged(): Boolean
    begin
        exit(
            ("Replenishment System" <> xRec."Replenishment System") or
            ("Lead Time Calculation" <> xRec."Lead Time Calculation") or
            ("Vendor No." <> xRec."Vendor No.") or
            ("Vendor Item No." <> xRec."Vendor Item No.") or
            ("Purch. Unit of Measure" <> xRec."Purch. Unit of Measure") or
            ("Manufacturing Policy" <> xRec."Manufacturing Policy") or
            ("Routing No." <> xRec."Routing No.") or
            ("Production BOM No." <> xRec."Production BOM No.") or
            ("Rounding Precision" <> xRec."Rounding Precision") or
            ("Flushing Method" <> xRec."Flushing Method") or
            ("Overhead Rate" <> xRec."Overhead Rate") or
            ("Scrap %" <> xRec."Scrap %") or
            ("Lot Size" <> xRec."Lot Size") or
            ("Allow Whse. Overpick" <> xRec."Allow Whse. Overpick") or
            ("Assembly Policy" <> xRec."Assembly Policy") or
            ("Assembly BOM" <> xRec."Assembly BOM")
        );
    end;

    local procedure PlanningFieldsChanged(): Boolean
    begin
        exit(
            ("Reordering Policy" <> xRec."Reordering Policy") or
            (Reserve <> xRec.Reserve) or
            ("Order Tracking Policy" <> xRec."Order Tracking Policy") or
            ("Stockkeeping Unit Exists" <> xRec."Stockkeeping Unit Exists") or
            ("Dampener Period" <> xRec."Dampener Period") or
            ("Dampener Quantity" <> xRec."Dampener Quantity") or
            (Critical <> xRec.Critical) or
            ("Safety Lead Time" <> xRec."Safety Lead Time") or
            ("Safety Stock Quantity" <> xRec."Safety Stock Quantity") or
            ("Include Inventory" <> xRec."Include Inventory") or
            ("Lot Accumulation Period" <> xRec."Lot Accumulation Period") or
            ("Rescheduling Period" <> xRec."Rescheduling Period") or
            ("Reorder Point" <> xRec."Reorder Point") or
            ("Reorder Quantity" <> xRec."Reorder Quantity") or
            ("Maximum Inventory" <> xRec."Maximum Inventory") or
            ("Overflow Level" <> xRec."Overflow Level") or
            ("Time Bucket" <> xRec."Time Bucket") or
            ("Minimum Order Quantity" <> xRec."Minimum Order Quantity") or
            ("Maximum Order Quantity" <> xRec."Maximum Order Quantity") or
            ("Order Multiple" <> xRec."Order Multiple")
        );
    end;

    local procedure HasPermissionSet(PermissionSetId: Code[20]): Boolean
    var
        AccessControl: Record "Access Control";
    begin
        AccessControl.SetRange("User Security ID", UserSecurityId());
        AccessControl.SetRange("Role ID", PermissionSetId);
        exit(not AccessControl.IsEmpty());
    end;

    local procedure HasFullAccess(): Boolean
    begin
        exit(
            HasPermissionSet('ADDV_PLM_TEAM_V1') or
            HasPermissionSet('SUPER') or
            HasPermissionSet('ADDV_FIN_TEAM_V1')
        );
    end;

    local procedure HasPriceEditAccess(): Boolean
    begin
        exit(
            HasPermissionSet('ADDV_ITEM_PRICE_EDIT') or
            HasFullAccess()
        );
    end;
}
