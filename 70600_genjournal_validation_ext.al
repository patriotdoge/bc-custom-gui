codeunit 70600 "GenJnl Validation Mgt"
{
    procedure ValidateLine(GenJnlLine: Record "Gen. Journal Line")
    begin
        if GenJnlLine."Line No." = 0 then
            exit;

        if not IsValidTemplate(GenJnlLine."Journal Template Name") then
            exit;

        if GenJnlLine."Shortcut Dimension 1 Code" = '' then begin
            Error(
                'Department Code must be filled in order to continue! Line No.: %1',
                GenJnlLine."Line No.");
        end;

        ValidateDimension(
            GenJnlLine,
            'COST CENTER',
            '(PURCH.) Cost center Code');

        ValidateDimension(
            GenJnlLine,
            'DR',
            '(FINANCIAL)DR Code');

        ValidateDimension(
            GenJnlLine,
            'CASHFLOW',
            '(FINANCIAL)Cashflow Code');
    end;

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