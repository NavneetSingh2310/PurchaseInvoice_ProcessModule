page 50132 "Purchase Invoice ListPart"
{
    Caption = 'Lines';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "PurchaseInvoice RequestLines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;

                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field("Receipt No."; "Receipt No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No."; "No.")
                {
                    ApplicationArea = All;


                }

                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code") { ApplicationArea = All; }
                field(Description2; Description2)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity) { ApplicationArea = All; Editable = false; }


                field("Qty. Rcd. Not Invoiced"; "Qty. Rcd. Not Invoiced") { ApplicationArea = All; Editable = false; }
                field("Quantity Invoiced"; "Quantity Invoiced") { ApplicationArea = All; }

                field("Direct Unit Cost Excl. VAT "; "Direct Unit Cost Excl. VAT ")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %") { ApplicationArea = All; }
                field("Total Amount"; "Total Amount")
                {
                    ApplicationArea = All;
                }

                // field("Expected Receipt Date"; "Expected Receipt Date") { ApplicationArea = All; }

                // field("Register User Id"; "Register User Id")
                // {
                //     ApplicationArea = All;
                // }
                // field("Registered User Name"; "Registered User Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Deptt. Code"; "Deptt. Code")
                // {
                //     ApplicationArea = All;
                // }


            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Get Receipt Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = GetLines;

                trigger OnAction();
                var
                    code_unit: Codeunit "PI Codeunit";
                    vendor: Code[20];
                    InvoiceNo: Code[20];
                begin

                    vendor := code_unit.GetCurrentInvoiceVendor();
                    InvoiceNo := code_unit.GetCurrentInvoiceNo();
                    if (vendor = '') or (InvoiceNo = '') then begin
                        if vendor = '' then
                            Error('Enter Vendor');
                        if InvoiceNo = '' then
                            Error('Enter Invoice no');
                    end

                    else
                        code_unit.GetReceiptLines(InvoiceNo, vendor);
                end;
            }
        }
    }


    trigger OnClosePage()
    var
        code_unit: Codeunit "PI Codeunit";
        Total_Amount: Decimal;
        PurchaseInvoice: Record "Purchase Invoice";
    begin
        Total_Amount := code_unit.GetTotalInvoiceAmount(code_unit.GetCurrentInvoiceNo());
        PurchaseInvoice.SetRange("No.", code_unit.GetCurrentInvoiceNo());
        if PurchaseInvoice.FindSet() then begin
            PurchaseInvoice.Amount := Total_Amount;
            PurchaseInvoice.Modify();
        end;



    end;

}