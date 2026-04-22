codeunit 70603 "GenJnl Validation Sub"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line",
        'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(
        var GenJournalLine: Record "Gen. Journal Line";
        Balancing: Boolean)
    var
        ValidationMgt: Codeunit "GenJnl Validation Mgt";
    begin
        ValidationMgt.ValidateLine(GenJournalLine);
    end;
}