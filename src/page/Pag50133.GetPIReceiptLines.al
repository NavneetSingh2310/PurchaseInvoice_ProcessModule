page 50133 "Get PI Receipt Lines"
{
    Caption = 'Get Receipt Lines';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purch. Rcpt. Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Type) { ApplicationArea = All; }
                field("No."; "No.") { ApplicationArea = All; }
                field("Buy-from Vendor No."; "Buy-from Vendor No.") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field("Unit of Measure"; "Unit of Measure") { ApplicationArea = All; }
                // field("Qty. Rcd. Not Invoiced"; "Qty. Rcd. Not Invoiced") { }
                field(Quantity; Quantity) { ApplicationArea = All; }
                field("Direct Unit Cost"; "Direct Unit Cost") { ApplicationArea = All; }
                field("Line Discount %"; "Line Discount %") { ApplicationArea = All; }
                field("Amount"; "Job Line Amount") { ApplicationArea = All; }

            }
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [Action::OK, Action::LookupOK] then
            createLines();
    end;

    procedure createLines()
    var
        ReceiptLines: Record "Purch. Rcpt. Line";
        _page: Page "Get PI Receipt Lines";
        PurchaseInvoiceLines: Record "PurchaseInvoice RequestLines";
        ReceiptHeader: Record "Purch. Rcpt. Header";
        InvoiceNo: Code[20];
        code_unit: Codeunit "PI Codeunit";
    begin
        CurrPage.SetSelectionFilter(Rec);
        if Rec.FindSet() then begin
            repeat

                InvoiceNo := code_unit.GetCurrentInvoiceNo();

                PurchaseInvoiceLines.SetRange(ID, InvoiceNo);
                if PurchaseInvoiceLines.FindSet() then begin
                    PurchaseInvoiceLines.SetRange("No.", Rec."No.");
                    if PurchaseInvoiceLines.FindSet() then begin
                        PurchaseInvoiceLines.SetRange("Receipt No.", Rec."Document No.");
                        if PurchaseInvoiceLines.FindSet() then
                            Error('Line Already Exists')
                    end;

                end;

                PurchaseInvoiceLines.Init();
                PurchaseInvoiceLines."Line No." := code_unit.GetNextLineNo(InvoiceNo);
                PurchaseInvoiceLines.ID := InvoiceNo;
                PurchaseInvoiceLines."No." := Rec."No.";
                PurchaseInvoiceLines."Receipt No." := Rec."Document No.";
                PurchaseInvoiceLines.Description := Rec.Description;
                PurchaseInvoiceLines.Quantity := Rec.Quantity;
                PurchaseInvoiceLines."Qty. Rcd. Not Invoiced" := Rec.Quantity;
                //PurchaseInvoiceLines."Quantity Invoiced" := Rec."Quantity Invoiced";
                PurchaseInvoiceLines."Unit of Measure" := Rec."Unit of Measure";
                PurchaseInvoiceLines."Direct Unit Cost Excl. VAT " := Rec."Direct Unit Cost";
                PurchaseInvoiceLines."Line Discount %" := Rec."Line Discount %";
                PurchaseInvoiceLines."Total Amount" := Rec."Job Line Amount";
                PurchaseInvoiceLines."Location Code" := Rec."Location Code";
                PurchaseInvoiceLines.Insert();

                Clear(PurchaseInvoiceLines);
            until Rec.Next() = 0;
        end;

    end;
}