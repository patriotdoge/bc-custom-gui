codeunit 70700 "Transfer Order Validation Mgt."
{
    procedure ValidateHeader(TransferHeader: Record "Transfer Header")
    begin
        TransferHeader.TestField("Shortcut Dimension 1 Code");
        if TransferHeader."Shortcut Dimension 1 Code" = '200 (ENG)' then
            if TransferHeader."Shortcut Dimension 2 Code" = '' then
                Error(
                    'Project Code must be filled in on the Transfer Order header when Department Code is ''200 (ENG)''.'
                );
    end;

    procedure ValidateAllLines(TransferHeader: Record "Transfer Header")
    var
        TransferLine: Record "Transfer Line";
    begin
        TransferLine.SetRange("Document No.", TransferHeader."No.");
        if TransferLine.FindSet() then
            repeat
                ValidateTransferLine(TransferLine);
            until TransferLine.Next() = 0;
    end;

    procedure ValidateTransferLine(TransferLine: Record "Transfer Line")
    begin
        // Skip blank / comment lines (no item assigned)
        if TransferLine."Item No." = '' then
            exit;

        if TransferLine."Shortcut Dimension 1 Code" = '' then
            Error(
                '"Department Code" must be filled in on all Transfer Order lines.\Line No.: %1',
                TransferLine."Line No."
            );

        if TransferLine."Shortcut Dimension 1 Code" = '200 (ENG)' then
            if TransferLine."Shortcut Dimension 2 Code" = '' then
                Error(
                    'Project Code must be filled in when Department Code is ''200 (ENG)''.\Line No.: %1',
                    TransferLine."Line No."
                );
    end;
}
