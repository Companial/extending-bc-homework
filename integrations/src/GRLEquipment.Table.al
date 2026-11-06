table 50140 "GRL Equipment"
{
    Caption = 'Equipment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; Category; Text[50])
        {
            Caption = 'Category';
        }
        field(4; Status; Enum "GRL Equipment Status")
        {
            Caption = 'Status';
        }
        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            AutoFormatType = 2;
        }
        field(6; "Last Service Date"; Date)
        {
            Caption = 'Last Service Date';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
