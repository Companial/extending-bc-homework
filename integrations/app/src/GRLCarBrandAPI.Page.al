namespace GrowthLab.Integrations;

page 50141 "GRL Car Brand API"
{
    PageType = API;
    Caption = 'carBrands', Locked = true;
    APIPublisher = 'growthlab';
    APIGroup = 'workshop';
    APIVersion = 'v1.0';
    EntityName = 'carBrand';
    EntitySetName = 'carBrands';
    SourceTable = "GRL Car Brand";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(code; Rec."Code")
                {
                    Caption = 'Code', Locked = true;
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name', Locked = true;
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code', Locked = true;
                }
                field(foundedYear; Rec."Founded Year")
                {
                    Caption = 'Founded Year', Locked = true;
                }
                field(active; Rec.Active)
                {
                    Caption = 'Active', Locked = true;
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time', Locked = true;
                    Editable = false;
                }
            }
        }
    }
}
