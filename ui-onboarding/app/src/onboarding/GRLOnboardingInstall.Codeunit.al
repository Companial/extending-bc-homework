codeunit 50121 "GRL Onboarding Install"
{
    Subtype = Install;
    Access = Internal;

    // Creates the setup record on install. The Setup Complete flag stays false,
    // so the homework notification has something to react to.

    trigger OnInstallAppPerCompany()
    var
        OnboardingSetup: Record "GRL Onboarding Setup";
    begin
        if OnboardingSetup.Get() then
            exit;
        OnboardingSetup.Init();
        OnboardingSetup."Welcome Text" := 'Welcome to the order desk';
        OnboardingSetup."Default Delivery Days" := 3;
        OnboardingSetup.Insert();
    end;
}
