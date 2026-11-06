codeunit 50163 "GRL Posting Subscriber"
{
    Access = Internal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure LogInvoicePosted(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        GRLTelemetry: Codeunit "GRL Telemetry";
    begin
        if PreviewMode or (SalesInvHdrNo = '') then
            exit;

        SalesInvoiceLine.SetRange("Document No.", SalesInvHdrNo);
        GRLTelemetry.LogInvoicePosted(SalesInvoiceLine.Count());
    end;
}
