namespace GrowthLab.Integrations;

using Microsoft.Foundation.Address;

codeunit 50140 "GRL Sample Data"
{
    Access = Public;

    procedure CreateSampleData()
    begin
        InsertBrand('AUDI', 'Audi', 'DE', 1909, true);
        InsertBrand('BMW', 'BMW', 'DE', 1916, true);
        InsertBrand('FIAT', 'Fiat', 'IT', 1899, true);
        InsertBrand('FORD', 'Ford', 'US', 1903, true);
        InsertBrand('HONDA', 'Honda', 'JP', 1948, true);
        InsertBrand('HYUNDAI', 'Hyundai', 'KR', 1967, true);
        InsertBrand('MERCEDES', 'Mercedes-Benz', 'DE', 1926, true);
        InsertBrand('NISSAN', 'Nissan', 'JP', 1933, true);
        InsertBrand('OPEL', 'Opel', 'DE', 1862, true);
        InsertBrand('PEUGEOT', 'Peugeot', 'FR', 1810, true);
        InsertBrand('RENAULT', 'Renault', 'FR', 1899, true);
        InsertBrand('SAAB', 'Saab', 'SE', 1945, false);
        InsertBrand('SKODA', 'Skoda', 'CZ', 1895, true);
        InsertBrand('TOYOTA', 'Toyota', 'JP', 1937, true);
        InsertBrand('VOLVO', 'Volvo', 'SE', 1927, true);
    end;

    local procedure InsertBrand(BrandCode: Code[20]; BrandName: Text[100]; CountryCode: Code[10]; FoundedYear: Integer; IsActive: Boolean)
    var
        CarBrand: Record "GRL Car Brand";
    begin
        if CarBrand.Get(BrandCode) then
            exit;

        CarBrand.Init();
        CarBrand."Code" := BrandCode;
        CarBrand.Name := BrandName;
        CarBrand."Founded Year" := FoundedYear;
        CarBrand.Active := IsActive;
        SetCountryIfExists(CarBrand, CountryCode);
        CarBrand.Insert(true);
    end;

    // An empty company may not hold these country codes, so only set a code that exists (the table relation would reject it otherwise)
    local procedure SetCountryIfExists(var CarBrand: Record "GRL Car Brand"; CountryCode: Code[10])
    var
        CountryRegion: Record "Country/Region";
    begin
        if CountryRegion.Get(CountryCode) then
            CarBrand."Country/Region Code" := CountryCode;
    end;
}
