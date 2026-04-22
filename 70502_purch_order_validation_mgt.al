codeunit 70502 "Purch. Order Validation Mgt."
{
    procedure ValidateAllLines(PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");

        if PurchLine.FindSet() then
            repeat
                ValidatePurchLine(PurchLine);
            until PurchLine.Next() = 0;
    end;

    procedure ValidatePurchLine(PurchLine: Record "Purchase Line")
    var
        DimSetEntry: Record "Dimension Set Entry";
        CostCenterDimCode: Code[20];
        CostCenterValue: Code[20];
    begin
        // Skip extended text / comment lines (Type = " ")
        if PurchLine.Type = PurchLine.Type::" " then
            exit;

        CostCenterDimCode := 'COST CENTER';
        CostCenterValue := '';

        DimSetEntry.SetRange("Dimension Set ID", PurchLine."Dimension Set ID");
        DimSetEntry.SetRange("Dimension Code", CostCenterDimCode);

        if DimSetEntry.FindFirst() then
            CostCenterValue := DimSetEntry."Dimension Value Code";

        if CostCenterValue = '' then
            Error(
                '"(PURCH.) Cost Center Code" must be filled in order to continue!\Line No.: %1',
                PurchLine."Line No."
            );

        if PurchLine."Shortcut Dimension 1 Code" = '200 (ENG)' then
            if PurchLine."Shortcut Dimension 2 Code" = '' then
                Error(
                    'Project Code must be filled in when Department Code is ''200 (ENG)''.\Line No.: %1',
                    PurchLine."Line No."
                );
    end;

    procedure ValidateHeader(PurchHeader: Record "Purchase Header")
    begin
        if PurchHeader."Shortcut Dimension 1 Code" = '200 (ENG)' then
            if PurchHeader."Shortcut Dimension 2 Code" = '' then
                Error(
                    'Project Code must be filled in on the Purchase Order header when Department Code is ''200 (ENG)''.'
                );
    end;
}
