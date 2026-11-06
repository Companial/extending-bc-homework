table 50180 "GRL Work Note"
{
    Caption = 'Work Note';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; Note; Text[250])
        {
            Caption = 'Note';
        }
        field(3; Done; Boolean)
        {
            Caption = 'Done';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
