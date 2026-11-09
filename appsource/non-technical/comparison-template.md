# Comparison template: three AppSource apps against one brief

Use this together with [requirement-brief.md](requirement-brief.md). An `.xlsx` version with the same content and automatic totals is in [comparison-template.xlsx](comparison-template.xlsx). Fill in one of them, not both.

**Date checked:** ____ (listings change; write the date you looked)

## How to score

| Score | Meaning |
|---|---|
| **0** | Fail: the app does not meet it, or the vendor said no |
| **1** | Question: unknown, only claimed, or the answer is unclear. Write the open question in the evidence column |
| **2** | Pass: you have evidence (trial result, listing, vendor answer in writing) |

- Every score needs something in the evidence column. A 2 without evidence is a 1.
- **Gate:** if any must-have scores 0, the app is out, whatever its total.
- A real answer from a vendor counts for more than a polished listing. Say who answered, when, and by what channel.

## Apps

| | App A | App B | App C |
|---|---|---|---|
| Name | | | |
| Publisher | | | |
| Listing link | | | |
| Listing version and "updated" date | | | |

## Criteria

For each criterion, fill in a score (0/1/2) and evidence for each app.

| Section | Criterion | What to look for | A score | A evidence | B score | B evidence | C score | C evidence |
|---|---|---|---|---|---|---|---|---|
| Fit | Must-haves 1 to N met (link to the trial evidence) | Score each must-have in the must-have table below. This row takes the **lowest** of them | | | | | | |
| Fit | Nice-to-haves met | Average of the nice-to-have scores, rounded | | | | | | |
| Availability | Country, language, BC version | The listing's supported countries, languages and editions. Does "all countries" or "selected countries" cover yours? Is the current version built for the BC release in the brief? | | | | | | |
| Technical | Dependencies; other apps it could clash with | What else must be installed? Embedded in BC, or an external service? What does it touch (posting, standard pages, permissions)? Test with the apps named in the brief | | | | | | |
| Vendor | Support route and test-question response time | Support link, hours, language. Send a real question during the trial and record the response time | | | | | | |
| Vendor | Will debug in your environment; telemetry | Written answer. Will they look at the customer's data and environment? Do they use telemetry? | | | | | | |
| Vendor | Access to source or escrow | Written answer or contract clause | | | | | | |
| Vendor | Update history against the last two major releases | Version history against the BC release dates. How many days after each major release was a compatible version listed? | | | | | | |
| Vendor | Ownership, age, reference customers | Who owns it, how long listed, live BC cloud projects, a reference from a similar company | | | | | | |
| Commercial | Price model, minimum term, who invoices; transactable or not | Quote converted to the unit in the brief. Price-change clause. Listing type: Get it now, Free trial, Contact me, or sold through Microsoft | | | | | | |
| Exit | Uninstall and data-migration path | What happens to the data and documents on uninstall? Export format? Cost? | | | | | | |
| | **Total (max 22)** | Sum of the scores above, 11 rows | | | | | | |
| Verdict | Recommendation, red flags, open questions | Not scored. Write it in the Verdict section below | | | | | | |

## Must-have and nice-to-have tests

Copy the numbered items from section 3 and 4 of the brief. One score and one line of evidence per app. For must-haves, "evidence" is the result of your trial on your sample invoices, with the invoice number.

| # | Requirement (short) | A score | A evidence | B score | B evidence | C score | C evidence |
|---|---|---|---|---|---|---|---|
| M1 | | | | | | | |
| M2 | | | | | | | |
| M3 | | | | | | | |
| M4 | | | | | | | |
| M5 | | | | | | | |
| M6 | | | | | | | |
| M7 | | | | | | | |
| N1 | | | | | | | |
| N2 | | | | | | | |
| N3 | | | | | | | |
| N4 | | | | | | | |

## Vendor questions asked and answers

Five or more per app, taken from the vetting checklist. Each question has a reason that links back to the brief. If you did not get an answer yet, leave it empty: an unanswered question is still a finding.

| App | Question | Why I asked (link to the brief) | Sent (date, channel) | Answer (who, when, how long it took) | Score impact |
|---|---|---|---|---|---|
| | | | | | |

## Verdict

Half a page. Cover:

1. **Recommendation:** your pick, or "none", for this customer and this brief.
2. **Runner-up** and why it is second.
3. **Red flags found** in any of the three, with the evidence.
4. **What the customer said about risk** (brief, section 7) and how your pick answers it.
5. **Open questions** you could not close, and **what you would test in a sandbox next**.
