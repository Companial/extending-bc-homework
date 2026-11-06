page 50180 "GRL Work Notes"
{
    Caption = 'GRL Work Notes';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GRL Work Note";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the entry number. The numbers are assigned automatically.';
                    Editable = false;
                }
                field(Note; Rec.Note)
                {
                    ToolTip = 'Specifies the note.';
                }
                field(Done; Rec.Done)
                {
                    ToolTip = 'Specifies whether the note is done.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowOpenCount)
            {
                Caption = 'Show Open Notes';
                ToolTip = 'Shows how many notes are not done yet.';
                Image = Info;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GRLWorkNoteMgt: Codeunit "GRL Work Note Mgt.";
                begin
                    Message(OpenCountMsg, GRLWorkNoteMgt.CountOpenNotes());
                end;
            }
        }
        area(Promoted)
        {
            actionref(ShowOpenCount_Promoted; ShowOpenCount) { }
        }
    }

    var
        OpenCountMsg: Label 'There are %1 open notes.', Comment = '%1 = number of notes that are not done';
}
