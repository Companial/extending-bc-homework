table 50120 "GRL Onboarding Setup"
{
    Caption = 'GRL Onboarding Setup';
    DataClassification = CustomerContent;
    LookupPageId = "GRL Onboarding Setup";
    DrillDownPageId = "GRL Onboarding Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            ToolTip = 'Specifies the single key of the setup record.';
        }
        field(2; "Welcome Text"; Text[100])
        {
            Caption = 'Welcome Text';
            ToolTip = 'Specifies a short welcome message for the order desk.';
        }
        field(3; "Default Delivery Days"; Integer)
        {
            Caption = 'Default Delivery Days';
            MinValue = 0;
            ToolTip = 'Specifies how many days a delivery normally takes. An example of a setup value that needs a real answer from the customer.';
        }
        field(4; "Setup Complete"; Boolean)
        {
            Caption = 'Setup Complete';
            ToolTip = 'Specifies whether the setup has been completed. Homework: the assisted setup guide sets this flag, and the notification checks it.';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
