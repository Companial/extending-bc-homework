namespace GrowthLab.ALGo;

permissionset 50180 "GRL AL-Go Sample"
{
    Assignable = true;
    Caption = 'GRL AL-Go Sample', Locked = true;

    Permissions =
        table "GRL Workshop Note" = X,
        tabledata "GRL Workshop Note" = RIMD,
        page "GRL Workshop Notes" = X;
}
