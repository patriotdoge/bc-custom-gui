pageextension 70101 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        modify("External Document No.")
        {
            ShowMandatory = true;
        }
        modify("Salesperson Code")
        {
            ShowMandatory = true;
        }

        addbefore("Invoice Details")
        {
            group(MyAddvolt_Main)
            {
                Caption = 'MyAddvolt';

                field("Seller"; Rec."Seller")
                {
                    ApplicationArea = All;
                }
                field("Final Client"; Rec."Final Client")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = All;
                }
                field("Engine Type"; Rec."Engine Type")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Brand"; Rec."Vehicle Brand")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Model"; Rec."Vehicle Model")
                {
                    ApplicationArea = All;
                }
                field("Reefer YN"; Rec."Reefer YN")
                {
                    ApplicationArea = All;
                }
                field("Reefer Model"; Rec."Reefer Model")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reefer Model Option"; Rec."Reefer Model Option")
                {
                    ApplicationArea = All;
                    Caption = 'Reefer Model';
                }
                field("Application"; Rec."Application")
                {
                    ApplicationArea = All;
                }
                field("Thermograph 1"; Rec."Thermograph 1")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Thermograph 1 Option"; Rec."Thermograph 1 Option")
                {
                    ApplicationArea = All;
                    Caption = 'Thermograph 1';
                }
                field("Thermograph 2"; Rec."Thermograph 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Thermograph 2 Option"; Rec."Thermograph 2 Option")
                {
                    ApplicationArea = All;
                    Caption = 'Thermograph 2';
                }
                field("Battery Voltage"; Rec."Battery Voltage")
                {
                    ApplicationArea = All;
                }
                field("Main Input/Output"; Rec."Main Input/Output")
                {
                    ApplicationArea = All;
                }
                field("HMI Mode"; Rec."HMI Mode")
                {
                    ApplicationArea = All;
                }
                field("HMI Start Settings"; Rec."HMI Start Settings")
                {
                    ApplicationArea = All;
                }
                field("CAN 2 Protocol"; Rec."CAN 2 Protocol")
                {
                    ApplicationArea = All;
                }
                field("LVDC Output"; Rec."LVDC Output")
                {
                    ApplicationArea = All;
                }
                field("HVDC Output"; Rec."HVDC Output")
                {
                    ApplicationArea = All;
                }
                field("Engine Generator"; Rec."Engine Generator")
                {
                    ApplicationArea = All;
                }
                field("Engine Generator Config."; Rec."Engine Generator Config.")
                {
                    ApplicationArea = All;
                }
                field("Ecodrive on Hybrid Vehicles"; Rec."Ecodrive on Hybrid Vehicles")
                {
                    ApplicationArea = All;
                }
                field("Kinetic Generator"; Rec."Kinetic Generator")
                {
                    ApplicationArea = All;
                }
                field("Tail Lift Brand"; Rec."Tail Lift Brand")
                {
                    ApplicationArea = All;
                }
                field("Branding Kit"; Rec."Branding Kit")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Blueprint"; Rec."Blueprint")
                {
                    ApplicationArea = All;
                }
            }

            group(RightSide)
            {
                ShowCaption = false;
                group(Installation)
                {
                    Caption = 'Installation';

                    field("Installation Required"; Rec."Installation Required")
                    {
                        ApplicationArea = All;
                    }
                    field("Installation Address"; Rec."Installation Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Contact Person"; Rec."Contact Person")
                    {
                        ApplicationArea = All;
                    }
                    field("Support"; Rec."Support")
                    {
                        ApplicationArea = All;
                    }
                    field("Expected Date"; Rec."Expected Date")
                    {
                        ApplicationArea = All;
                    }
                }

                group(Observations)
                {
                    Caption = 'Observations';

                    field("Observations Text"; Rec."Observations Text")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }

                }
            }
        }
    }
}
