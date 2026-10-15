namespace GrowthLab.ALGo;

page 50180 "GRL Workshop Notes"
{
    ApplicationArea = All;
    Caption = 'Workshop Notes';
    PageType = List;
    SourceTable = "GRL Workshop Note";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the entry number of the note.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the title of the note.';
                }
                field(Note; Rec.Note)
                {
                    ToolTip = 'Specifies the note text.';
                }
            }
        }
    }
}
