page 50130 "InventAsset Purchase Invoices"
{
    Caption = 'Inventory Asset Purchase Invoices';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Invoice";
    CardPageId = "Purchase Invoice Card";
    //CardPageId = "Purchase Invoice";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field("Buy-from Vendor No."; "Vendor No.") { ApplicationArea = All; }
                field("Buy-from Vendor Name"; "Vendor Name") { ApplicationArea = All; }
                field("Location Code"; "Location Code") { ApplicationArea = All; }
                field("Assigned User ID"; "Assigned User ID") { ApplicationArea = All; }
                field(Status; Status) { ApplicationArea = All; }
                field(Amount; Amount) { ApplicationArea = All; }



            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
            action("Print Report")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    _report: Report 50110;
                begin
                    Report.RunModal(50110, false, false, Rec);
                    Message('Printed');
                    Report.RunModal(50110, false, false, Rec);
                    Message('Printed');
                    Report.RunModal(50110, false, false, Rec);
                    Message('Printed');

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        code_unit: Codeunit "PI Codeunit";
    begin

        code_unit.SetOrderType(rec."Order Type"::"Inventory Asset");

        SetFilter("Order Type", 'Inventory Asset');


        //code_unit.ClearAllTablesData();
    end;

}