codeunit 50130 "PI Codeunit"
{
    SingleInstance = true;
    procedure SetPurchaseInvoiceNo(DocNo: Code[20])
    begin
        currentPurchaseInvoiceNo := DocNo;
    end;

    procedure GetPurchaseInvoiceNo(): Code[20]
    begin
        exit(currentPurchaseInvoiceNo);
    end;

    procedure SetOrderType(name: Option)
    begin
        CurrentOrderType := name;
    end;

    procedure GetOrderType(): Option
    begin
        exit(CurrentOrderType);
    end;

    procedure SetCurrentInvoiceNoAndVendor(No: Code[20]; Vno: Code[20])
    begin
        CurrentInvoiceVendor := Vno;
        CurrentInvoiceNo := No;
    end;

    procedure GetCurrentInvoiceVendor(): Code[20]
    begin
        exit(CurrentInvoiceVendor);
    end;

    procedure GetCurrentInvoiceNo(): Code[20]
    begin
        exit(CurrentInvoiceNo);
    end;

    procedure GetReceiptLines(InvoiceNo: Code[20]; VendorNo: Code[20])
    var
        ReceiptLines: Record "Purch. Rcpt. Line";
        _page: Page "Get PI Receipt Lines";
        PurchaseInvoiceLines: Record "PurchaseInvoice RequestLines";
        ReceiptHeader: Record "Purch. Rcpt. Header";
    begin

        ReceiptLines.SetRange("Buy-from Vendor No.", VendorNo);
        if ReceiptLines.FindSet() then begin
            _page.SetTableView(ReceiptLines);
            _page.LookupMode := true;
            if _page.RunModal() = Action::LookupOK then begin

            end;
        end;
    end;

    procedure GetNextLineNo(id: Code[20]): Integer
    var
        PurchaseInvoiceLines: Record "PurchaseInvoice RequestLines";
    begin
        PurchaseInvoiceLines.SetRange(ID, id);
        if PurchaseInvoiceLines.FindSet() then begin
            PurchaseInvoiceLines.SetCurrentKey("Line No.");
            PurchaseInvoiceLines.Find('+');
            Message(Format(PurchaseInvoiceLines."Line No."));
            exit(PurchaseInvoiceLines."Line No." + 1);
        end;
    end;

    procedure GetTotalInvoiceAmount(No: Code[20]): Decimal
    var
        PurchaseInvoiceLines: Record "PurchaseInvoice RequestLines";
        Total_Amount: Decimal;
    begin
        PurchaseInvoiceLines.SetRange(ID, No);
        if PurchaseInvoiceLines.FindSet() then begin
            repeat
                Total_Amount := Total_Amount + PurchaseInvoiceLines."Total Amount";
            until PurchaseInvoiceLines.Next() = 0;

        end;
        exit(Total_Amount);

    end;

    procedure PostingPreview(PurchaseInvoice: Record "Purchase Invoice")
    var

        Total_Line_items: Integer;
        PurchaseInvoiceLines: Record "PurchaseInvoice RequestLines";
        Page2: Page "G/L Posting Preview";
        temp: Page "G/L Entries Preview";
        TempGLEntry: Record "G/L Entry" temporary;
        TempValueEntry: Record "Value Entry" temporary;
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
        TempDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry" temporary;
        vendorEntry: Record "Vendor Ledger Entry" temporary;
        documentEntry: Record "Document Entry" temporary;
        TempVendLedgEntry: Record "Vendor Ledger Entry" temporary;


        recref: RecordRef;
        i: Integer;

    begin



        Total_Line_items := 0;
        PurchaseInvoiceLines.SetRange(ID, PurchaseInvoice."No.");
        if PurchaseInvoiceLines.FindSet() then begin
            repeat

                TempItemLedgerEntry."Cost Amount (Actual)" := PurchaseInvoiceLines."Total Amount";
                TempItemLedgerEntry."Document No." := PurchaseInvoice."No.";
                TempItemLedgerEntry."Entry No." := TempItemLedgerEntry.GetLastEntryNo() + 1;
                TempItemLedgerEntry.Insert();

                TempValueEntry."Cost Amount (Actual)" := PurchaseInvoiceLines."Total Amount";
                TempValueEntry."Entry No." := TempValueEntry.GetLastEntryNo() + 10;
                TempValueEntry."Document No." := PurchaseInvoice."No.";
                TempValueEntry.Insert();

                TempValueEntry."Cost Amount (Actual)" := PurchaseInvoiceLines."Total Amount";
                TempValueEntry."Entry No." := TempValueEntry.GetLastEntryNo() + 20;
                TempValueEntry."Document No." := PurchaseInvoice."No.";
                TempValueEntry.Insert();

                Total_Line_items := Total_Line_items + 1;
            until PurchaseInvoiceLines.Next() = 0;
        end;
        TempGLEntry.Amount := PurchaseInvoice.Amount;
        TempGLEntry."Document No." := PurchaseInvoice."No.";
        TempGLEntry."Entry No." := TempGLEntry.GetLastEntryNo() + 1;
        TempGLEntry.Insert();
        TempGLEntry.Amount := -PurchaseInvoice.Amount;
        TempGLEntry."Document No." := PurchaseInvoice."No.";
        TempGLEntry."Entry No." := TempGLEntry.GetLastEntryNo() + 1;
        TempGLEntry.Insert();

        TempVendLedgEntry.Amount := PurchaseInvoice.Amount;
        TempValueEntry."Entry No." := TempValueEntry.GetLastEntryNo() + 1;
        TempVendLedgEntry."Document No." := PurchaseInvoice."No.";
        TempVendLedgEntry.Insert();

        TempDtldVendLedgEntry."Entry No." := TempDtldVendLedgEntry.GetLastEntryNo() + 1;
        TempDtldVendLedgEntry."Document No." := PurchaseInvoice."No.";
        TempDtldVendLedgEntry.Amount := PurchaseInvoice.Amount;
        TempDtldVendLedgEntry.Insert();

        posting.InsertDocumentEntry(TempGLEntry, documentEntry);
        posting.InsertDocumentEntry(TempVendLedgEntry, documentEntry);
        posting.InsertDocumentEntry(TempItemLedgerEntry, documentEntry);
        posting.InsertDocumentEntry(TempDtldVendLedgEntry, documentEntry);
        posting.InsertDocumentEntry(TempValueEntry, documentEntry);
        Page2.Set(documentEntry, posting);
        Page2.Run();




    end;

    // procedure displayRecords(TableID: Integer)
    // begin
    //     case TableID of
    //         database::"G/L Entry":
    //             begin
    //                 TempGLEntry.SetRange();
    //                 page.Run(page::"G/L Entries Preview", TempGLEntry);

    //             end;

    //     end;
    // end;




    var
        detailedEntry: Record "Detailed Vendor Ledg. Entry";
        Page2: Page "G/L Posting Preview";

        currentPurchaseInvoiceNo: Code[20];
        CurrentOrderType: Option;
        CurrentInvoiceVendor: Code[20];
        CurrentInvoiceNo: Code[20];


        posting: Codeunit "Posting Preview Event Handler";
        Permanent_Posting: Codeunit PostingSetupManagement;

        _page: page "Vend. Ledg. Entries Preview";
        tempPage: Page "Purchase Invoice";




}