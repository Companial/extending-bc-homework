codeunit 50140 "GRL Equipment Install"
{
    Subtype = Install;
    Access = Internal;

    trigger OnInstallAppPerCompany()
    begin
        SeedEquipment();
    end;

    local procedure SeedEquipment()
    var
        Equipment: Record "GRL Equipment";
        i: Integer;
    begin
        if not Equipment.IsEmpty() then
            exit;

        for i := 1 to 30 do begin
            Equipment.Init();
            Equipment."No." := CopyStr('EQ-' + Format(i, 0, '<Integer,3><Filler Character,0>'), 1, MaxStrLen(Equipment."No."));
            Equipment.Description := CopyStr(GetDescription(i), 1, MaxStrLen(Equipment.Description));
            Equipment.Category := CopyStr(GetCategory(i), 1, MaxStrLen(Equipment.Category));
            Equipment.Status := GetStatus(i);
            Equipment."Daily Rate" := 20 + (i mod 10) * 7.5;
            Equipment."Last Service Date" := CalcDate('<-' + Format(i * 6) + 'D>', Today());
            Equipment.Insert(true);
        end;
    end;

    local procedure GetDescription(i: Integer): Text
    begin
        case i mod 5 of
            0:
                exit('Pressure washer ' + Format(i));
            1:
                exit('Cordless drill ' + Format(i));
            2:
                exit('Mini excavator ' + Format(i));
            3:
                exit('Scaffold tower ' + Format(i));
            4:
                exit('Concrete mixer ' + Format(i));
        end;
    end;

    local procedure GetCategory(i: Integer): Text
    begin
        case i mod 3 of
            0:
                exit('Cleaning');
            1:
                exit('Power tools');
            2:
                exit('Heavy equipment');
        end;
    end;

    local procedure GetStatus(i: Integer): Enum "GRL Equipment Status"
    begin
        case i mod 4 of
            0:
                exit("GRL Equipment Status"::InService);
            1, 2:
                exit("GRL Equipment Status"::Available);
            3:
                exit("GRL Equipment Status"::Rented);
        end;
    end;
}
