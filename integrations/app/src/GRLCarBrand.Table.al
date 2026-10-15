namespace GrowthLab.Integrations;

using Microsoft.Foundation.Address;

table 50140 "GRL Car Brand"
{
    Caption = 'Car Brand';
    DataClassification = CustomerContent;
    LookupPageId = "GRL Car Brands";
    DrillDownPageId = "GRL Car Brands";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(4; "Founded Year"; Integer)
        {
            Caption = 'Founded Year';
            MinValue = 1800;
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
