namespace GrowthLab.ALGo;

table 50180 "GRL Workshop Note"
{
    Caption = 'Workshop Note';
    DataClassification = CustomerContent;
    LookupPageId = "GRL Workshop Notes";
    DrillDownPageId = "GRL Workshop Notes";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; Title; Text[100])
        {
            Caption = 'Title';
        }
        field(3; Note; Text[250])
        {
            Caption = 'Note';
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
