codeunit 50120 "GRL Onboarding Mgt."
{
    Access = Public;

    // Hook points for the developer homework.
    //
    // 1. Assisted setup: create your own NavigatePage, then subscribe to
    //    "Guided Experience".OnRegisterAssistedSetup and call InsertAssistedSetup
    //    (check the signature against the BC 29 symbols; Learn pages differ).
    //    Register exactly one primary setup. Run GetSetupPageId() or your wizard
    //    from the notification action.
    // 2. Notification: on a page of this app, call IsSetupComplete() in OnOpenPage.
    //    If it returns false, send a notification with an action that opens the wizard.
    //    Recall it when setup is complete.
    // 3. Stretch: add a checklist item with codeunit "Checklist" (1992).

    /// <summary>
    /// Returns true when the setup record exists and is marked complete.
    /// Homework: the notification asks this question.
    /// </summary>
    procedure IsSetupComplete(): Boolean
    var
        OnboardingSetup: Record "GRL Onboarding Setup";
    begin
        if not OnboardingSetup.Get() then
            exit(false);
        exit(OnboardingSetup."Setup Complete");
    end;

    /// <summary>
    /// Marks the setup as complete. Homework: call this when the wizard finishes.
    /// </summary>
    procedure CompleteSetup()
    var
        OnboardingSetup: Record "GRL Onboarding Setup";
    begin
        if not OnboardingSetup.Get() then begin
            OnboardingSetup.Init();
            OnboardingSetup.Insert();
        end;
        OnboardingSetup."Setup Complete" := true;
        OnboardingSetup.Modify();
    end;

    /// <summary>
    /// Returns the page that holds the plain setup card. The wizard is the homework.
    /// </summary>
    procedure GetSetupPageId(): Integer
    begin
        exit(Page::"GRL Onboarding Setup");
    end;
}
