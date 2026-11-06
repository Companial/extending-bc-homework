table 50121 "GRL Customer Tier"
{
    Caption = 'GRL Customer Tier';
    DataClassification = CustomerContent;
    LookupPageId = "GRL Customer Tiers";
    DrillDownPageId = "GRL Customer Tiers";

    // Small master-data table. The homework configuration package can carry it
    // next to customers and items.

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            ToolTip = 'Specifies the code of the customer tier.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies what the tier means for the order desk.';
        }
        field(3; "Order Priority"; Integer)
        {
            Caption = 'Order Priority';
            MinValue = 0;
            ToolTip = 'Specifies how urgently the order desk handles orders from this tier. Lower is more urgent.';
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
