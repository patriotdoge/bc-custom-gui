codeunit 70600 "GenJnl Validation Mgt"
{
    procedure ValidateLine(GenJnlLine: Record "Gen. Journal Line")
    begin
        // =========================================================
        // SAFETY CHECKS (system / buffer lines)
        // =========================================================
        if GenJnlLine."Line No." = 0 then
            exit;

        // Only validate selected templates
        if not IsValidTemplate(GenJnlLine."Journal Template Name") then
            exit;

        // =========================
        // SHORTCUT DIMENSION 1
        // =========================
        if GenJnlLine."Shortcut Dimension 1 Code" = '' then begin
            Error(
                'Department Code must be filled in order to continue! Line No.: %1',
                GenJnlLine."Line No.");
        end;

        // =========================
        // COST CENTER
        // =========================
        ValidateDimension(
            GenJnlLine,
            'COST CENTER',
            '(PURCH.) Cost center Code');

        // =========================
        // FINANCIAL DR
        // =========================
        ValidateDimension(
            GenJnlLine,
            'DR',
            '(FINANCIAL)DR Code');

        // =========================
        // FINANCIAL CASHFLOW
        // =========================
        ValidateDimension(
            GenJnlLine,
            'CASHFLOW',
            '(FINANCIAL)Cashflow Code');
    end;

    // =========================================================
    // TEMPLATE FILTER (ONLY THESE GET VALIDATED)
    // =========================================================
    local procedure IsValidTemplate(TemplateName: Code[20]): Boolean
    begin
        exit(
            (TemplateName = 'APURAMIVA') or
            (TemplateName = 'APURAMRES') or
            (TemplateName = 'BANCOS') or
            (TemplateName = 'CAIXA') or
            (TemplateName = 'DEPOSITS') or
            (TemplateName = 'D-SICG') or
            (TemplateName = 'OPDIVERSAS') or
            (TemplateName = 'SALARIOS') or
            (TemplateName = 'SI')
        );
    end;

    // =========================================================
    // DIMENSION VALIDATION CORE
    // =========================================================
    local procedure ValidateDimension(
        GenJnlLine: Record "Gen. Journal Line";
        DimCode: Code[20];
        DimName: Text)
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimValue: Code[20];
    begin
        DimSetEntry.SetRange("Dimension Set ID", GenJnlLine."Dimension Set ID");
        DimSetEntry.SetRange("Dimension Code", DimCode);

        if DimSetEntry.FindFirst() then
            DimValue := DimSetEntry."Dimension Value Code";

        if DimValue = '' then begin
            Error(
                '%1 must be filled in order to continue! Line No.: %2',
                DimName,
                GenJnlLine."Line No.");
        end;
    end;
}