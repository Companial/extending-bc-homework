namespace GrowthLab.Integrations;

codeunit 50141 "GRL Install"
{
    Subtype = Install;
    Access = Internal;

    trigger OnInstallAppPerCompany()
    var
        GRLSampleData: Codeunit "GRL Sample Data";
    begin
        GRLSampleData.CreateSampleData();
    end;
}
