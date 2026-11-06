enum 50140 "GRL Equipment Status"
{
    Extensible = false;
    Caption = 'Equipment Status';

    value(0; Available)
    {
        Caption = 'Available';
    }
    value(1; Rented)
    {
        Caption = 'Rented';
    }
    value(2; InService)
    {
        Caption = 'In Service';
    }
}
