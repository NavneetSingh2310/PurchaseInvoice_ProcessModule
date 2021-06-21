page 50134 "Vendor Entries"
{
    Caption = 'Vendor Entries';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Vendor Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.") { ApplicationArea = All; }
                field("Vendor No."; "Vendor No.") { ApplicationArea = All; }
                field("Vendor Name"; "Vendor Name") { ApplicationArea = All; }
                field(Amount; Amount) { ApplicationArea = All; }
                field("Document No."; "Document No.") { ApplicationArea = All; }

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