permissionset 50180 "GRL ALGO"
{
    Assignable = true;
    Caption = 'GRL AL-Go sample';

    Permissions =
        table "GRL Work Note" = X,
        tabledata "GRL Work Note" = RIMD,
        codeunit "GRL Work Note Mgt." = X,
        page "GRL Work Notes" = X;
}
