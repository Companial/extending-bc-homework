pageextension 50123 "GRL Customer Card Delivery" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("GRL Delivery Day"; Rec."GRL Delivery Day")
            {
                ApplicationArea = All;
            }
        }
    }
}
