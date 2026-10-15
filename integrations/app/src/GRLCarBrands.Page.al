namespace GrowthLab.Integrations;

page 50140 "GRL Car Brands"
{
    ApplicationArea = All;
    Caption = 'Car Brands';
    PageType = List;
    SourceTable = "GRL Car Brand";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the code of the car brand.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the car brand.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region the brand originates from.';
                }
                field("Founded Year"; Rec."Founded Year")
                {
                    ToolTip = 'Specifies the year the brand was founded.';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies whether the brand is still active.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateSampleData)
            {
                Caption = 'Create Sample Data';
                ToolTip = 'Creates the sample car brands that do not exist yet. Use this in companies created after the app was installed.';
                Image = Import;

                trigger OnAction()
                var
                    GRLSampleData: Codeunit "GRL Sample Data";
                begin
                    GRLSampleData.CreateSampleData();
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            actionref(CreateSampleData_Promoted; CreateSampleData)
            {
            }
        }
    }
}
