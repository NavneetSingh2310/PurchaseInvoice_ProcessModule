page 50135 "My GL Lines"
{
    Caption = 'My GL Lines';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "PurchaseInvoice RequestLines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; ID) { ApplicationArea = All; }
                field("No."; "No.") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }

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
        }
    }
}