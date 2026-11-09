permissionset 50165 "GRL Telemetry"
{
    Assignable = true;
    Caption = 'GRL Telemetry sample';

    Permissions =
        table "GRL Demo Record" = X,
        tabledata "GRL Demo Record" = RIMD,
        codeunit "GRL Inventory Sync Job" = X,
        codeunit "GRL Telemetry" = X,
        codeunit "GRL Posting Subscriber" = X,
        codeunit "GRL Demo Job Setup" = X,
        page "GRL Demo Records" = X,
        tabledata "Job Queue Entry" = RIMD,
        tabledata "Sales Invoice Line" = R;
}
