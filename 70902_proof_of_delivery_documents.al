page 70902 "Proof of Delivery Documents"
{
    Caption = 'Proof of Delivery Documents';
    PageType = List;
    SourceTable = "Sales Shipment Header";
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    CardPageId = "Posted Sales Shipment";

    layout
    {
        area(Content)
        {
            repeater(ShipmentList)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shipment number.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date of the shipment.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales order that generated this shipment.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery address name.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s external reference (e.g. PO number).';
                }
            }
        }
        area(FactBoxes)
        {
            part(PODDocuments; "POD Document Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Shipment No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UploadPOD)
            {
                ApplicationArea = All;
                Caption = 'Upload POD';
                Image = Attach;
                ToolTip = 'Upload a Proof of Delivery document for the selected shipment.';

                trigger OnAction()
                var
                    PODDoc: Record "POD Document";
                    OutStr: OutStream;
                    InStr: InStream;
                    FileName: Text;
                begin
                    if UploadIntoStream('Select Proof of Delivery Document', '', '', FileName, InStr) then begin
                        PODDoc.Init();
                        PODDoc."Shipment No." := Rec."No.";
                        PODDoc."File Name" := CopyStr(FileName, 1, MaxStrLen(PODDoc."File Name"));
                        PODDoc.Content.CreateOutStream(OutStr);
                        CopyStream(OutStr, InStr);
                        PODDoc.Insert(true);
                        CurrPage.PODDocuments.Page.Update(false);
                    end;
                end;
            }
        }
        area(Promoted)
        {
            actionref(UploadPOD_Promoted; UploadPOD) { }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("No.");
        Rec.Ascending(false);
    end;
}