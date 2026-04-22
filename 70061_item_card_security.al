pageextension 70061 "Item Card Security Ext" extends "Item Card"
{
    layout
    {
        modify("Item")
        {
            Editable = HasFullAccess;
        }

        modify("Inventory")
        {
            Editable = CanEditLogistic or HasFullAccess;
        }

        modify("Costs & Posting")
        {
            Editable = HasFullAccess;
        }

        modify("Prices & Sales")
        {
            Editable = HasFullAccess or CanEditPrices;
        }

        modify("Replenishment")
        {
            Editable = CanEditPurchases or HasFullAccess;
        }

        modify("Planning")
        {
            Editable = CanEditPurchases or HasFullAccess;
        }

        modify("ItemTracking")
        {
            Editable = HasFullAccess;
        }

        modify("Warehouse")
        {
            Editable = CanEditLogistic or HasFullAccess;
        }

        // Match 70060 BlockedFieldsChanged() - FULL ACCESS ONLY
        modify("Purchasing Blocked") { Editable = HasFullAccess; }
        modify("Sales Blocked") { Editable = HasFullAccess; }
        modify("Service Blocked") { Editable = HasFullAccess; }
        modify("Production Blocked") { Editable = HasFullAccess; }

        // Match 70060 PriceFieldsChanged() - PRICE EDIT or FULL ACCESS  
        modify("Unit Price") { Editable = CanEditPrices or HasFullAccess; }
        modify("Price Includes VAT") { Editable = CanEditPrices or HasFullAccess; }
        modify("Price/Profit Calculation") { Editable = CanEditPrices or HasFullAccess; }
        modify("Profit %") { Editable = CanEditPrices or HasFullAccess; }
        modify("Allow Invoice Disc.") { Editable = CanEditPrices or HasFullAccess; }
        modify("Item Disc. Group") { Editable = CanEditPrices or HasFullAccess; }
        modify("Sales Unit of Measure") { Editable = CanEditPrices or HasFullAccess; }

    }

    var
        CanEditLogistic: Boolean;
        CanEditPrices: Boolean;
        CanEditPurchases: Boolean;
        HasFullAccess: Boolean;

    trigger OnOpenPage()
    var
        UserPerms: Codeunit "User Permissions Helper";
    begin
        // FULL ACCESS for PLM Team and SUPER users
        HasFullAccess := UserPerms.HasPermissionSet('ADDV_PLM_TEAM_V1') or
                         UserPerms.HasPermissionSet('SUPER') or
                         UserPerms.HasPermissionSet('ADDV_FIN_TEAM_V1');

        // Role-based FastTab access
        CanEditLogistic := UserPerms.HasPermissionSet('ADDV_LOG_TEAM_V1');
        CanEditPrices := UserPerms.HasPermissionSet('ADDV_ITEM_PRICE_EDIT');
        CanEditPurchases := UserPerms.HasPermissionSet('ADDV_PUR_TEAM_V1');
    end;
}
