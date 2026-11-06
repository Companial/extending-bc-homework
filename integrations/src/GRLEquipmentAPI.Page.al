page 50141 "GRL Equipment API"
{
    Caption = 'equipment';
    PageType = API;
    APIPublisher = 'grl';
    APIGroup = 'workshop';
    APIVersion = 'v1.0';
    EntityName = 'equipmentItem';
    EntitySetName = 'equipmentItems';
    SourceTable = "GRL Equipment";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'Number';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(category; Rec.Category)
                {
                    Caption = 'Category';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(dailyRate; Rec."Daily Rate")
                {
                    Caption = 'Daily Rate';
                }
                field(lastServiceDate; Rec."Last Service Date")
                {
                    Caption = 'Last Service Date';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                    Editable = false;
                }
            }
        }
    }
}
