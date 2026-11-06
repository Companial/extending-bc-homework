pageextension 50124 "GRL Customer List Delivery" extends "Customer List"
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
