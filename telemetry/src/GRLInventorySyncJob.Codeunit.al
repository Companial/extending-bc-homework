codeunit 50161 "GRL Inventory Sync Job"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        DemoRecord: Record "GRL Demo Record";
        GRLTelemetry: Codeunit "GRL Telemetry";
        StartTime: DateTime;
        AttemptNo: Integer;
        RecordsDone: Integer;
    begin
        StartTime := CurrentDateTime();
        RecordsDone := 0;
        // "No. of Attempts to Run" counts earlier failed attempts, so the first run is attempt 1.
        AttemptNo := Rec."No. of Attempts to Run" + 1;

        DemoRecord.SetCurrentKey("No.");
        DemoRecord.SetRange(Status, DemoRecord.Status::Pending);
        GRLTelemetry.LogSyncStarted(DemoRecord.Count(), AttemptNo);

        // No Commit() anywhere: when a record fails, the error rolls back every record already marked Sent in this run.
        if DemoRecord.FindSet() then
            repeat
                if DemoRecord."Target Code" = '' then
                    GRLTelemetry.LogSyncRecordFailed(DemoRecord."No.", RecordsDone, 'TargetCodeMissing', TargetCodeMissingErr, AttemptNo);
                SendRecord(DemoRecord);
                RecordsDone += 1;
                if RecordsDone mod 10 = 0 then
                    GRLTelemetry.LogSyncProgress(RecordsDone);
            until DemoRecord.Next() = 0;

        GRLTelemetry.LogSyncFinished(RecordsDone, CurrentDateTime() - StartTime);
    end;

    var
        TargetCodeMissingErr: Label 'Target Code must have a value', Locked = true;

    /// <summary>Simulates sending one record to an external system.</summary>
    local procedure SendRecord(var DemoRecord: Record "GRL Demo Record")
    begin
        DemoRecord.TestField("Target Code");
        DemoRecord.Status := DemoRecord.Status::Sent;
        DemoRecord.Modify();
    end;
}
