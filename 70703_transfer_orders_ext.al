pageextension 70701 "Transfer Orders Ext." extends "Transfer Orders"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            ShowMandatory = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ShowMandatory = true;
        }
    }
}
