permissionset 50120 "GRL ONBOARDING"
{
    Caption = 'GRL Onboarding';
    Assignable = true;

    Permissions =
        tabledata "GRL Onboarding Setup" = RIMD,
        tabledata "GRL Customer Tier" = RIMD,
        table "GRL Onboarding Setup" = X,
        table "GRL Customer Tier" = X,
        page "GRL Onboarding Setup" = X,
        page "GRL Customer Tiers" = X,
        codeunit "GRL Onboarding Mgt." = X;
}
