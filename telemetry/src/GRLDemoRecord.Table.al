table 50160 "GRL Demo Record"
{
    Caption = 'Demo Record';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Target Code"; Code[20])
        {
            Caption = 'Target Code';
        }
        field(4; Status; Enum "GRL Demo Record Status")
        {
            Caption = 'Status';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        QuickTxt: Label 'Quick', Locked = true;
        FullTxt: Label 'Full', Locked = true;
        DescriptionTxt: Label '%1 demo record %2', Comment = '%1 = batch mode, %2 = sequence in batch', Locked = true;

    /// <summary>
    /// Creates a batch of demo records. Quick = 10 good records. Full = 50 records where the 27th has an empty Target Code
    /// (a "legacy import" defect). On an empty table, Quick then Full puts the defect on record No. 37.
    /// </summary>
    procedure CreateBatch(Full: Boolean)
    var
        DemoRecord: Record "GRL Demo Record";
        GRLTelemetry: Codeunit "GRL Telemetry";
        StartTime: DateTime;
        Mode: Text;
        BatchSize: Integer;
        DefectPosition: Integer;
        FirstNo: Integer;
        LastNo: Integer;
        i: Integer;
    begin
        StartTime := CurrentDateTime();
        Mode := QuickTxt;
        BatchSize := 10;
        if Full then begin
            Mode := FullTxt;
            BatchSize := 50;
            DefectPosition := 27;
        end;

        for i := 1 to BatchSize do begin
            DemoRecord.Init();
            DemoRecord.Description := CopyStr(StrSubstNo(DescriptionTxt, Mode, i), 1, MaxStrLen(DemoRecord.Description));
            if i <> DefectPosition then
                DemoRecord."Target Code" := CopyStr('TGT-' + Format(i, 0, '<Integer,3><Filler Character,0>'), 1, MaxStrLen(DemoRecord."Target Code"));
            DemoRecord.Status := DemoRecord.Status::Pending;
            DemoRecord.Insert(true);
            if i = 1 then
                FirstNo := DemoRecord."No.";
            LastNo := DemoRecord."No.";
        end;

        GRLTelemetry.LogRecordsCreated(Mode, BatchSize, FirstNo, LastNo, CurrentDateTime() - StartTime);
    end;
}
