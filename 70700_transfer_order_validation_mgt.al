codeunit 70700 "Transfer Order Validation Mgt."
{
    // -------------------------------------------------------------------------
    // HEADER VALIDATION
    // Validates Shortcut Dimension 1 & 2 on the Transfer Header.
    // -------------------------------------------------------------------------
    procedure ValidateHeader(TransferHeader: Record "Transfer Header")
    begin
        TransferHeader.TestField("Shortcut Dimension 1 Code");
        TransferHeader.TestField("Shortcut Dimension 2 Code");
    end;

    // -------------------------------------------------------------------------
    // LINES VALIDATION
    // Validates Shortcut Dimension 1 & 2 on every non-blank Transfer Line.
    // -------------------------------------------------------------------------
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
                '"Department Code" (Shortcut Dimension 1) must be filled in on all Transfer Order lines.\Line No.: %1',
                TransferLine."Line No."
            );

        if TransferLine."Shortcut Dimension 2 Code" = '' then
            Error(
                '"Project Code" (Shortcut Dimension 2) must be filled in on all Transfer Order lines.\Line No.: %1',
                TransferLine."Line No."
            );
    end;
}
