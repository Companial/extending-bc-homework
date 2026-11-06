page 50121 "GRL Customer Tiers"
{
    Caption = 'GRL Customer Tiers';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GRL Customer Tier";

    layout
    {
        area(Content)
        {
            repeater(Tiers)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Order Priority"; Rec."Order Priority")
                {
                }
            }
        }
    }
}
