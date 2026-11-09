tableextension 50122 "GRL Customer Delivery Day" extends Customer
{
    fields
    {
        field(50120; "GRL Delivery Day"; Enum "GRL Delivery Day")
        {
            Caption = 'Delivery Day';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the weekday on which this customer prefers to receive deliveries. Business Central does not store this.';
        }
    }
}
