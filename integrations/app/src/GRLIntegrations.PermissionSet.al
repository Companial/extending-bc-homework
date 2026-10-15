namespace GrowthLab.Integrations;

permissionset 50140 "GRL Integrations"
{
    Assignable = true;
    Caption = 'GRL Integrations', Locked = true;

    Permissions =
        table "GRL Car Brand" = X,
        tabledata "GRL Car Brand" = RIMD,
        codeunit "GRL Sample Data" = X,
        codeunit "GRL Install" = X,
        page "GRL Car Brands" = X,
        page "GRL Car Brand API" = X;
}
