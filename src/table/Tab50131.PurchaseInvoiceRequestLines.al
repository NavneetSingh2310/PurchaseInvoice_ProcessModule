table 50131 "PurchaseInvoice RequestLines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Item","Asset";
        }

        field(4; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

        }
        field(35; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;



        }
        field(5; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;


        }
        field(6; "Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Description2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Requested Qunatity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Register User Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Registered User Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Deptt. Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Sub.Account Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Date Needed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Purpose"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        //****************************************************************
        field(18; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Direct Unit Cost Excl. VAT "; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Line Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Quantity to Receive"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Quantity Received"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Expected Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Total Incl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Purchase(LYC)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Parcels"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Gross Weight"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Volume"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "No of Tax Lines"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Inv. Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Total Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Qty. Rcd. Not Invoiced"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Quantity Invoiced"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; ID, "Line No.", "No.")
        {
            Clustered = true;
        }
    }

}