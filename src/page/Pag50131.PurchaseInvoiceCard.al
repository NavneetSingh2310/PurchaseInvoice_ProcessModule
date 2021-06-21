page 50131 "Purchase Invoice Card"
{
    Caption = 'Purchase Invoice Card';
    PageType = Card;
    ApplicationArea = All;

    UsageCategory = Administration;
    SourceTable = "Purchase Invoice";



    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = page_Editable;
                field("No.";
                "No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    NotBlank = true;
                    trigger OnAssistEdit()
                    var
                        Series_Page: Page "No. Series List";
                        Series_Table: Record "No. Series";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        CurrentSeries: Code[15];
                        Series: Record "No. Series";
                        code_unit: Codeunit "PI Codeunit";


                    begin
                        Series_Table.Reset();
                        Series_Table.SetFilter(Code, '*-PI');
                        Clear(Series_Page);
                        Series_Page.SetRecord(Series_Table);
                        Series_Page.SetTableView(Series_Table);
                        Series_Page.LookupMode(true);

                        IF Series_Page.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Series_Page.GetRecord(Series_Table);
                            "No." := Series_Table.Code;
                            CurrentSeries := "No.";
                            Series.Get(CurrentSeries);
                            "No." := NoSeriesMgt.GetNextNo("No.", 0D, true);

                            if Series_Table.Description = 'GA Purchase Invoice' then
                                "Department Type" := "Department Type"::"GA Dept"
                            else
                                if Series_Table.Description = 'PR Purchase Invoice' then
                                    "Department Type" := "Department Type"::"PR Dept"
                                else
                                    if Series_Table.Description = 'CS Purchase Invoice' then
                                        "Department Type" := "Department Type"::"CS Dept";

                            code_unit.SetPurchaseInvoiceNo("No.");



                            status := status::Open;
                            "Document Date" := Today;

                        end


                    end;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    trigger OnValidate()
                    var
                        vendor: Record Vendor;
                        code_unit: Codeunit "PI Codeunit";
                    begin
                        vendor.get("Vendor No.");
                        "Vendor Name" := vendor.Name;
                        Address := vendor.Address;
                        "Address 2" := vendor."Address 2";
                        "Post Code" := vendor."Post Code";
                        City := vendor.City;
                        County := vendor.County;
                        "Country/Region Code" := vendor."Country/Region Code";
                        Contact := vendor.Contact;
                        "Contact No." := vendor.Contact;
                        "Document Date" := Today;
                        code_unit.SetCurrentInvoiceNoAndVendor("No.", "Vendor No.");


                    end;
                }
                field("Vendor Name"; "Vendor Name") { ApplicationArea = All; Editable = false; }
                field("Order Type"; "Order Type") { ApplicationArea = All; Editable = false; }
                field("Department Type"; "Department Type") { ApplicationArea = All; Editable = false; }
                label("Buy-from") { ApplicationArea = All; Style = Strong; }
                field(Address; Address) { ApplicationArea = All; Editable = false; }
                field("Address 2"; "Address 2") { ApplicationArea = All; Editable = false; }
                field("Post Code"; "Post Code") { ApplicationArea = All; Editable = false; }
                field(City; City) { ApplicationArea = All; Editable = false; }
                field(County; County) { ApplicationArea = All; Editable = false; }
                field("Country/Region Code"; "Country/Region Code") { ApplicationArea = All; Editable = false; }
                field("Contact No."; "Contact No.") { ApplicationArea = All; Editable = false; }
                field(Contact; Contact) { ApplicationArea = All; Editable = false; }
                field("Document Date"; "Document Date") { ApplicationArea = All; }
                field("Posting Date"; "Posting Date") { ApplicationArea = All; }
                field("Vendor Invoice No."; "Vendor Invoice No.") { ApplicationArea = All; NotBlank = true; }
                field("Purchaser Code"; "Purchaser Code") { ApplicationArea = All; }
                field("Campaign No."; "Campaign No.") { ApplicationArea = All; }
                field("Alternate Vendor Address Code"; "Alternate Vendor Address Code") { ApplicationArea = All; }
                field("Responsibility Center"; "Responsibility Center") { ApplicationArea = All; }
                field("Assigned User ID"; "Assigned User ID") { ApplicationArea = All; }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

            }
            part(Lines; "Purchase Invoice ListPart")
            {
                Editable = page_Editable;
                SubPageLink = ID = field("No.");
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Posting Preview")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = ViewPostedOrder;
                Enabled = page_Editable;

                trigger OnAction()
                var
                    vendorEntry: Record "Vendor Ledger Entry" temporary;
                    detailedEntry: Record "Detailed Vendor Ledg. Entry";
                    Page2: Page "G/L Posting Preview";
                    documentEntry: Record "Document Entry" temporary;

                    Total_Line_items: Integer;
                    PurchaseInvoiceLines: Record "PurchaseInvoice RequestLines";
                    PurchaseInvoice: Record "Purchase Invoice";
                    code_unit: Codeunit "PI Codeunit";
                begin

                    code_unit.PostingPreview(xRec);



                end;

            }
            action(Post)
            {
                ApplicationArea = all;
                Image = Post;
                Promoted = true;
                Enabled = page_Editable;

                trigger OnAction()
                var
                    PostYesNo: Boolean;
                    PurchaseInvoiceLines: Record "PurchaseInvoice RequestLines";
                begin
                    PostYesNo := Confirm('Do you want to post the invoice?');
                    if PostYesNo = true then begin
                        Message('Invoice Posted');
                        page_Editable := false;
                        Status := Status::Released;
                    end;

                    PurchaseInvoiceLines.SetRange(ID, "No.");
                    if PurchaseInvoiceLines.FindSet() then begin
                        PurchaseInvoiceLines."Quantity Invoiced" := PurchaseInvoiceLines."Qty. Rcd. Not Invoiced";
                        PurchaseInvoiceLines.Modify();
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        code_unit: Codeunit "PI Codeunit";
    begin

        "Order Type" := code_unit.GetOrderType();

    end;

    trigger OnOpenPage()
    var
        code_unit: Codeunit "PI Codeunit";
    begin

        if "Vendor No." <> '' then
            code_unit.SetCurrentInvoiceNoAndVendor("No.", "Vendor No.")
        else
            code_unit.SetCurrentInvoiceNoAndVendor('', '');

    end;

    trigger OnAfterGetRecord()
    var
        code_unit: Codeunit "PI Codeunit";
    begin
        if "No." <> '' then
            code_unit.SetCurrentInvoiceNoAndVendor("No.", "Vendor No.");
        if status = status::Released then begin
            page_editable := false;
            reopen_enabled := false;
        end
        else
            if status = status::"Pending Approval" then begin
                page_editable := false;
                reopen_enabled := true;
            end
            else begin
                page_editable := true;
                reopen_enabled := false;
            end;




    end;

    var
        page_editable: Boolean;
        reopen_enabled: Boolean;



}