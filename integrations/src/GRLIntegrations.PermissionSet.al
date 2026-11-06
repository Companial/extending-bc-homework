permissionset 50140 "GRL INTEGRATIONS"
{
    Assignable = true;
    Caption = 'GRL Integrations sample';

    Permissions =
        table "GRL Equipment" = X,
        tabledata "GRL Equipment" = RIMD,
        page "GRL Equipment" = X,
        page "GRL Equipment API" = X;
}
