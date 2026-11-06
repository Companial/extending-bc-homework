table 50100 "GRL Sample Item"
{
    Caption = 'Sample Item';
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
        field(3; Id; Code[20])
        {
            Caption = 'Id';
            DataClassification = CustomerContent;
        }
        field(5; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = SystemMetadata;
        }
        field(6; "Customer Reference"; Text[50])
        {
            Caption = 'Customer Reference';
        }
        field(7; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
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


