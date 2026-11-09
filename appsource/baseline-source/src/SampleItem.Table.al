table 50100 "GRL Sample Item"
{
    Caption = 'Sample Item';
    DataClassification = CustomerContent;
    LookupPageId = "GRL Sample Items";
    DrillDownPageId = "GRL Sample Items";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Identifier; Code[20])
        {
            Caption = 'Identifier';
            DataClassification = CustomerContent;
        }
        field(4; "Legacy Code"; Code[10])
        {
            Caption = 'Legacy Code';
            DataClassification = CustomerContent;
        }
        field(5; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created At" := CurrentDateTime();
    end;
}
