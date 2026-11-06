page 50120 "GRL Onboarding Setup"
{
    Caption = 'GRL Onboarding Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "GRL Onboarding Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    // Homework (developer track): do not turn this page into the wizard.
    // Add a separate NavigatePage and register it as the primary assisted setup.
    // See README.md and GRLOnboardingMgt.Codeunit.al.

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Welcome Text"; Rec."Welcome Text")
                {
                }
                field("Default Delivery Days"; Rec."Default Delivery Days")
                {
                }
                field("Setup Complete"; Rec."Setup Complete")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
