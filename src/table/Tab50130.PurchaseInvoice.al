table 50130 "Purchase Invoice"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

        }
        field(2; "Vendor Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Post Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "City"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "County"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Country/Region Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Contact No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Contact; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Vendor Invoice No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Purchaser Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Campaign No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Alternate Vendor Address Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(18; "Assigned User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
        field(19; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Pending Approval","Released";
        }
        field(20; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(21; "Location Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

        }
        field(22; "Department Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "GA Dept","CS Dept","PR Dept";

        }
        field(23; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Direct Expense","Inventory Asset","Fixed Asset";


        }
        field(24; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {

        }
    }

}