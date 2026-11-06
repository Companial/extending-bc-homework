page 50140 "GRL Equipment"
{
    Caption = 'GRL Equipment';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GRL Equipment";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the equipment number.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies what the equipment is.';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the equipment category.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the equipment is available, rented or in service.';
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ToolTip = 'Specifies the rental rate per day.';
                }
                field("Last Service Date"; Rec."Last Service Date")
                {
                    ToolTip = 'Specifies when the equipment was last serviced.';
                }
            }
        }
    }
}
