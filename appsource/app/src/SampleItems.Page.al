page 50100 "GRL Sample Items"
{
    Caption = 'Sample Items';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GRL Sample Item";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the sample item.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the sample item.';
                }
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }
                field("Customer Reference"; Rec."Customer Reference")
                {
                }
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the sample item was created.';
                }
            }
        }
    }
}

