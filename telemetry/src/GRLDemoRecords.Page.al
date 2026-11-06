page 50160 "GRL Demo Records"
{
    Caption = 'GRL Demo Records';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GRL Demo Record";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the record number. The numbers are assigned automatically.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the demo record.';
                }
                field("Target Code"; Rec."Target Code")
                {
                    ToolTip = 'Specifies the code the inventory sync job sends the record to. An empty code makes the job fail.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the inventory sync job has sent the record.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateQuickBatch)
            {
                Caption = 'Create Quick Batch';
                ToolTip = 'Creates 10 valid demo records.';
                Image = Add;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CreateBatch(false);
                    CurrPage.Update(false);
                end;
            }
            action(CreateFullBatch)
            {
                Caption = 'Create Full Batch';
                ToolTip = 'Creates 50 demo records. One of them has an empty Target Code.';
                Image = AddAction;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CreateBatch(true);
                    CurrPage.Update(false);
                end;
            }
            action(CreateDemoJob)
            {
                Caption = 'Create Demo Job';
                ToolTip = 'Creates the demo job queue entry for the inventory sync and sets it to Ready.';
                Image = Job;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GRLDemoJobSetup: Codeunit "GRL Demo Job Setup";
                begin
                    GRLDemoJobSetup.CreateDemoJob();
                    Message(JobCreatedMsg);
                end;
            }
        }
        area(Promoted)
        {
            actionref(CreateQuickBatch_Promoted; CreateQuickBatch) { }
            actionref(CreateFullBatch_Promoted; CreateFullBatch) { }
            actionref(CreateDemoJob_Promoted; CreateDemoJob) { }
        }
    }

    var
        JobCreatedMsg: Label 'The demo job queue entry is created and Ready. Open Job Queue Entries to follow it.';
}
