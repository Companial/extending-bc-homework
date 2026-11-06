codeunit 50162 "GRL Telemetry"
{
    Access = Internal;

    var
        InvoicePostedMsg: Label 'Sales invoice posted', Locked = true;
        RecordsCreatedMsg: Label 'Demo records created', Locked = true;
        SyncStartedMsg: Label 'Inventory sync started', Locked = true;
        SyncProgressMsg: Label 'Inventory sync progress', Locked = true;
        SyncRecordFailedMsg: Label 'Inventory sync record failed', Locked = true;
        SyncFinishedMsg: Label 'Inventory sync finished', Locked = true;

    procedure LogRecordsCreated(Mode: Text; RecordCount: Integer; FirstRecordNo: Integer; LastRecordNo: Integer; DurationMs: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add('Mode', Mode);
        Dimensions.Add('RecordCount', Format(RecordCount, 0, 9));
        Dimensions.Add('FirstRecordNo', Format(FirstRecordNo, 0, 9));
        Dimensions.Add('LastRecordNo', Format(LastRecordNo, 0, 9));
        Dimensions.Add('DurationMs', Format(DurationMs, 0, 9));
        Log('GRL-0001', RecordsCreatedMsg, Verbosity::Normal, Dimensions);
    end;

    procedure LogInvoicePosted(LineCount: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add('LineCount', Format(LineCount, 0, 9));
        Dimensions.Add('LineBand', LineBand(LineCount));
        Log('GRL-0002', InvoicePostedMsg, Verbosity::Normal, Dimensions);
    end;

    procedure LogSyncStarted(RecordsPlanned: Integer; AttemptNo: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add('RecordsPlanned', Format(RecordsPlanned, 0, 9));
        Dimensions.Add('AttemptNo', Format(AttemptNo, 0, 9));
        Log('GRL-0010', SyncStartedMsg, Verbosity::Normal, Dimensions);
    end;

    procedure LogSyncProgress(RecordsDone: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add('RecordsDone', Format(RecordsDone, 0, 9));
        Log('GRL-0011', SyncProgressMsg, Verbosity::Normal, Dimensions);
    end;

    procedure LogSyncRecordFailed(RecordNo: Integer; RecordsDone: Integer; ReasonCode: Text; ErrorText: Text; AttemptNo: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add('RecordNo', Format(RecordNo, 0, 9));
        Dimensions.Add('RecordsDone', Format(RecordsDone, 0, 9));
        Dimensions.Add('ReasonCode', ReasonCode);
        Dimensions.Add('ErrorText', ErrorText);
        Dimensions.Add('AttemptNo', Format(AttemptNo, 0, 9));
        Log('GRL-0012', SyncRecordFailedMsg, Verbosity::Error, Dimensions);
    end;

    procedure LogSyncFinished(RecordsSent: Integer; DurationMs: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add('RecordsSent', Format(RecordsSent, 0, 9));
        Dimensions.Add('DurationMs', Format(DurationMs, 0, 9));
        Log('GRL-0013', SyncFinishedMsg, Verbosity::Normal, Dimensions);
    end;

    local procedure LineBand(LineCount: Integer): Text
    begin
        case true of
            LineCount >= 10:
                exit('Large');
            LineCount >= 3:
                exit('Medium');
            else
                exit('Small');
        end;
    end;

    local procedure Log(EventId: Text; Message: Text; Verbosity: Verbosity; Dimensions: Dictionary of [Text, Text])
    var
        Telemetry: Codeunit Telemetry;
    begin
        // SystemMetadata only: never put customer data in a dimension.
        // TelemetryScope::All = the app's own resource (if app.json has a connection string) AND the environment resource.
        Telemetry.LogMessage(EventId, Message, Verbosity, DataClassification::SystemMetadata, TelemetryScope::All, Dimensions);
    end;
}
