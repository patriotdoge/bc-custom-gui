page 70903 "Set POD Tracking No."
{
    Caption = 'Set Tracking No. - POD Documents';
    PageType = List;
    SourceTable = "POD Document";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the name of the uploaded file.';
                }
                field("Tracking No."; Rec."Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tracking number for this document.';
                }
            }
        }
    }
}
