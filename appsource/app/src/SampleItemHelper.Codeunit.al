codeunit 50101 "Sample Item Helper"
{
    procedure NewItemNo(): Code[20]
    begin
        exit(CopyStr(Format(CreateGuid()), 2, 20));
    end;
}
