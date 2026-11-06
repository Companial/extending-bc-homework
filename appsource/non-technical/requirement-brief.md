# Requirement brief: automating purchase invoice entry at Noorderlicht Bouwmaterialen B.V.

Fictional customer, used by all partners so that the review session compares like with like. Noorderlicht is invented; any resemblance to a real company is accidental.

**Your role:** you are the implementation partner. The customer has asked you to recommend an app from AppSource. Find three candidates, compare them with [comparison-template.md](comparison-template.md) (or the `.xlsx` twin), put your questions to the vendors and recommend one, or none.

---

## 1. Customer profile

| | |
|---|---|
| Company | Noorderlicht Bouwmaterialen B.V., wholesaler of building and installation materials |
| Country | The Netherlands (head office and warehouse in one location) |
| Size | About 90 employees, turnover about EUR 28 million |
| Business Central | Production SaaS, **Business Central 29**, Premium licences, one company, Dutch localisation. 28 BC users, of which 4 are accounts payable (AP) clerks and about 12 budget holders approve invoices |
| Languages | Staff work in Dutch and English. Supplier invoices arrive in Dutch (about 60%), German (about 25%) and English (about 15%) |
| Current process | Suppliers e-mail PDFs to one mailbox (`facturen@`). A clerk opens each PDF, types the header and lines into a purchase invoice in BC, prints the PDF for a signature and files it in a folder. About 1,800 invoices and credit notes a month. About 600 refer to a purchase order with a receipt in BC. The rest are services, freight, utilities and rent. A few larger suppliers already send UBL XML files |
| Installed apps | One Dutch bank-file app for payments. No document or workflow apps |

## 2. Problem to solve

Noorderlicht's AP team spends most of its week retyping invoices. Posting is late at month end, and the VAT return is sometimes filed on an estimate. Approvals take days because the signed paper travels between desks. When the auditor asks for an invoice, someone searches a folder. The customer wants invoices to arrive in Business Central with the data already read, checked against the purchase order where there is one, approved by the right person and filed with the posted entry.

## 3. Must-have requirements

Each item must be testable in a sandbox with your own sample invoices. Build a set of 10 invoices for the trial: 5 Dutch, 3 German, 2 English; at least one with more than 40 lines, one credit note, one reverse-charge invoice and one that matches a purchase order with a receipt.

1. **Capture without templates.** PDF invoices from a shared mailbox and from manual upload are read, and header (vendor, invoice number, dates, currency, totals, VAT) and lines land in a BC purchase document. A new supplier must work without Noorderlicht building a template first. *Test:* at least 8 of your 10 invoices produce a correct header without manual typing.
2. **Dutch, German and English invoices.** The three languages above are read correctly, including decimal commas. *Test:* the German and Dutch invoices in your set.
3. **Dutch VAT.** The right VAT product posting group is proposed per line, and a reverse-charge invoice is handled. *Test:* the reverse-charge invoice posts with the intended VAT result.
4. **Matching to purchase orders.** For invoices that refer to a PO, the app matches lines to the PO and receipt (three-way) and flags differences above a tolerance that Noorderlicht sets (initially 2%). *Test:* the PO-based invoice, with one deliberate quantity difference.
5. **Approval outside the BC client.** An approver without daily BC use can approve or reject an invoice from a browser or phone, with two levels by amount. *Test:* approve one invoice from a phone.
6. **E-invoices without OCR.** UBL XML invoices are imported directly, with no OCR step. *Test:* import the UBL file you generate or obtain for the trial.
7. **Archive.** The original document stays linked to the posted purchase invoice and can be found again by vendor, number or date. The customer's accountant requires 7 years' retention. *Test:* open the original from the posted invoice and search for it.

## 4. Nice-to-have

1. Suggests G/L accounts and dimensions from previous invoices and improves over time.
2. Warns about duplicate invoices and about a changed vendor bank account.
3. Handles batches of 200 PDFs in one import.
4. Reports on throughput (invoices received, matched, approved, posted) for the finance manager.

## 5. Constraints

- **Budget:** EUR 300 to 700 per month all-in (licences plus any per-document fees) at 1,800 documents a month. The customer thinks in cost per user per month, so convert any quote to that basis: **16 users** touch the app (4 clerks plus 12 approvers). State your assumptions.
- **Availability:** the app must be available for the Netherlands in BC 29 SaaS. Installation from AppSource, no on-premises component for the customer to run.
- **Data:** invoice data and documents must stay in the EU. The customer's data protection officer asks where documents are processed and by whom.
- **Integrations and installed apps:** must coexist with the existing bank-file app. No new middleware for the customer to operate.
- **Timeline:** sandbox pilot in January 2027, go-live on 1 March 2027, before the first quarter-end VAT return.

## 6. Support expectations

- Support in Dutch or English, during Dutch office hours (08:30 to 17:30 CET) on working days.
- **Who the customer calls first: you.** The customer will not call a vendor. You decide what you can handle yourself and what you escalate, so the vendor's partner support matters more than its customer support.
- A blocking issue (invoices cannot be captured at month end) needs a response the same working day.

## 7. What the customer has said about risk

The finance manager, in her own words:

> "Two years ago we bought a scanning product from a small supplier. A bigger company acquired it, support moved to a ticket queue we could not get an answer from, and the product stopped working after a Business Central update. We posted invoices by hand for three weeks. When we left, the scanned archive was stuck inside it, and we had to pay to get the files out."

Use this when you write your vendor questions. It points at: who owns the vendor and what happens if that changes; how quickly the vendor ships after each major BC release; how support works and who answers; and what you get back if you leave (documents and data, in what format).

## 8. Deliverable format

Return the filled [comparison-template](comparison-template.md) (Markdown or `.xlsx`) with:

- three apps from AppSource, each with a link to the listing and the date you checked it;
- the template filled in for all three, with evidence in the evidence column (a link, a screenshot reference or the vendor's wording);
- the vendor questions you asked and any answers, on the *Vendor questions* sheet or section;
- a recommendation of half a page on the *Verdict* sheet: pick, runner-up, red flags found, and what you would test in a sandbox next. "None of the three" is a valid answer if you can justify it.

The review session compares recommendations across partners for this same brief.
