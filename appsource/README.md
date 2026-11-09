# AppSource homework

Homework for *AppSource, from both sides*. Pick **one** of two tracks. Track A is the lead track: it needs no development setup and trains the skill you use most as a partner, choosing and vetting an app you will then have to support. Track B gives developers practice with the quality bar every AppSource app has to meet.

Target: **Business Central 29 (2026 release wave 2)**.

| | Track A: non-technical (lead) | Track B: technical |
|---|---|---|
| You | Compare three AppSource apps for a customer brief | Run AppSourceCop on a sample extension and fix or justify every finding |
| Needs | A browser, a BC sandbox (for the stretch) | VS Code with the AL extension, BC 29 symbols |
| Start at | [`non-technical/requirement-brief.md`](non-technical/requirement-brief.md) | [Track B](#track-b--technical) below |

---

# Track A – Non-technical (lead track)

## Task

Take the supplied requirement brief ([`non-technical/requirement-brief.md`](non-technical/requirement-brief.md)): a fictional customer who wants to stop retyping supplier invoices. Find three AppSource apps that could meet it. Compare them with the comparison template, write vendor questions, and recommend one app, or none, and say why.

You are the implementation partner. The customer will call you, not the vendor, when something breaks. Compare the vendors on that basis.

## Minimum deliverable

1. Three apps shortlisted from AppSource, each with a link to the listing and the date you checked it.
2. The comparison template filled in for all three: fit, country and language, price model, update history, support route, vendor profile. Every score has evidence.
3. Five or more vendor questions per app from the vetting checklist, each with the reason for asking, plus any answers received. A real answer from one vendor counts for more than a polished table.
4. A recommendation of half a page: pick, runner-up, the red flags found, and what you would test in a sandbox next.

## Stretch

Install the trial of one app in a sandbox and test one scenario from the brief. Send one vendor question and record the response time.

## Files

| File | What it is |
|---|---|
| [`non-technical/requirement-brief.md`](non-technical/requirement-brief.md) | The customer brief (one page, eight parts) |
| [`non-technical/comparison-template.md`](non-technical/comparison-template.md) | Template for Markdown or Word users, with scoring guide |
| [`non-technical/comparison-template.xlsx`](non-technical/comparison-template.xlsx) | The same template as a workbook with automatic totals, a vendor questions sheet and a verdict sheet |

Fill in **one** of the two template files.

## What to bring

Bring the filled template (Markdown or `.xlsx`) to the review session. Nothing needs to be sent beforehand. If you contacted a vendor, include their reply as it came, with the date. The review session compares recommendations across partners for the same brief.

## Tips

- Search AppSource from the *Extension Management* marketplace view in your sandbox or on the web. Check the supported countries and languages on each listing first. Installation fails if the app is not available for the environment's country.
- Listings change. Write the date you looked.
- Build the 10-invoice test set described in the brief before you start a trial.
- Do not rank by star rating. Rank by evidence against the brief.

## Resources

- [Technical validation checklist](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-checklist-submission), to see what every listed app passed at submission (and what it did not: support, price, fit)
- [Maintaining apps: update periods and what happens to an app that falls behind](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/app-maintain)
- [Extension types and scope: how Marketplace apps are installed and updated](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-extension-types-and-scope)
- [Dynamics 365 Business Central offer setup (listing types and transactable offers)](https://learn.microsoft.com/partner-center/marketplace-offers/dynamics-365-business-central-offer-setup)
- Community post (optional): none chosen yet.

---

# Track B – Technical

**Track B** is the technical track of *AppSource, from both sides*. You run AppSourceCop against a small extension, then fix or justify every finding, including one breaking change.

Object prefix `GRL`, object IDs 50100-50119.

## Task

Run AppSourceCop and the technical validation against the sample app in `app/`. Fix or justify every finding, including the breaking change.

The app is a one-table, one-page extension (`GRL Sample Item`). Version 1.0.0.0 is the baseline and is already compiled in `baseline/`. The code in `app/` is version 2.0.0.0, and it contains a deliberate breaking change plus a handful of ordinary findings.

## Minimum deliverable

1. A run of AppSourceCop on the sample app, with the list of findings (rule ID, object, severity).
2. The breaking change resolved the safe way (obsolete the old field, add a replacement field, keep the old one pending; or revert the rename), with a one-line explanation of what would have happened to existing data.
3. Every other finding either fixed or justified in writing. A justification says why the finding is acceptable and why that is safe.
4. A short note: which findings would matter for a per-tenant extension (PTE), and which only for AppSource.

## Stretch / developer variant

- Write the upgrade codeunit (`Subtype = Upgrade`) that copies the data from the obsolete field to its replacement.
- Run the full validation with `Run-AlValidation` (BcContainerHelper, needs Docker), or enable AppSourceCop in an AL-Go pipeline.

## Install the compiled app (no development setup)

`GRL AppSource Sample_2.0.0.0.app` is the compiled current version. Install it in a **sandbox** environment only.

- Recommended: Admin centre › Environments › your sandbox › **Manage Apps** › **Install Extension** › choose the `.app`, deployment schedule *Immediately*. Follow progress under **Operations**. You need to be an admin of the environment's tenant (or a delegated admin); if you aren't, ask whoever is ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-manage-apps)). Uploading through the in-client **Extension Management** page is deprecated.
- The *Extension Management* page in the client can still show the installed app, but uploading a per-tenant extension there is deprecated. Use the admin centre for uploading.
- Assign the permission set `GRL Sample` to your user, then search for *Sample Items*.

The v2 package was built with the build-only ruleset (see below), so it contains the breaking change. A fresh install works. It is not upgrade-safe from 1.0.0.0, which is the point of the exercise.

## What you need to compile

- The AL compiler `alc.exe` from the VS Code *AL Language* extension (`ms-dynamics-smb.al-<version>\bin`). The analyzer DLLs are in the same folder.
- BC 29 symbol packages (System, System Application, Business Foundation, Base Application, Application) in a folder **outside** this repository, for example `C:\al-symbols\bc29`. Download them with the AL extension (`AL: Download symbols`) from a BC 29 sandbox and copy the `.app` files out of `.alpackages`. Never commit `.alpackages`.

## Run AppSourceCop against the baseline

AppSourceCop reads `app/AppSourceCop.json`, which names the baseline version. The baseline `.app` must be on the package cache path, so pass the symbol folder and the `baseline/` folder together.

```powershell
$al   = 'C:\Users\<you>\.vscode\extensions\ms-dynamics-smb.al-<version>\bin'
$sym  = 'C:\al-symbols\bc29'
$repo = 'C:\path\to\appsource'      # this folder
$cops = "$al\Microsoft.Dynamics.Nav.CodeCop.dll,$al\Microsoft.Dynamics.Nav.AppSourceCop.dll,$al\Microsoft.Dynamics.Nav.UICop.dll"

& "$al\alc.exe" /project:"$repo\app" "/packagecachepath:$sym,$repo\baseline" `
    /out:"$repo\out.app" /ruleset:"$repo\app\grl.ruleset.json" /analyzer:$cops
```

Expected result: the compile fails with errors and warnings. Errors stop the `.app` from being written, so no `out.app` appears. That is the validation failing.

To compile the current version anyway (errors downgraded to warnings), use `grl.build.ruleset.json` instead. Use it only to produce a package, never to claim validation passed.

To rebuild the v1 baseline:

```powershell
& "$al\alc.exe" /project:"$repo\baseline-source" /packagecachepath:$sym `
    /out:"$repo\baseline\GRL AppSource Sample_1.0.0.0.app" `
    /ruleset:"$repo\baseline-source\grl.ruleset.json" /analyzer:$cops
```

Do not put the baseline `.app` files and the symbol folder in a folder inside `app/`: the compiler would pick up stray `.al` files.

You can also open `app/` in VS Code with the AL extension. Set `al.packageCachePath` to your symbol folder and `al.codeAnalyzers` to `["${CodeCop}", "${AppSourceCop}", "${UICop}"]`, and AppSourceCop finds the baseline through `app/AppSourceCop.json`.

## Notes on realism

- `GRL` is a neutral workshop prefix, **not** a registered affix. Affix rules such as AS0011 are therefore a simulation: `mandatoryAffixes` in `AppSourceCop.json` pretends that `GRL` is registered.
- `grl.ruleset.json` switches off three rules that can never pass for a workshop sample: AS0084 (object IDs 50100-50119 are the PTE range; AppSource apps need a range allocated by Microsoft), AS0092 (no Application Insights resource) and AA0247 (namespaces). Each has a justification in the file. Justifying rules in a ruleset is exactly what the task asks you to practise; read the file.
- The manifest URLs point to `example.com`. The sample is not a real AppSource offer.
- The Microsoft validation does more than the compiler: signing, per-country and per-release runs, marketing checks. See the checklist below.

## Resources

- [AppSourceCop analyzer](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/analyzers/appsourcecop)
- [Technical validation checklist](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-checklist-submission)
- [Obsolete objects in AL](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-obsolete-objects)
- Community post (optional): none chosen yet.

## Folder layout

| Path | Content |
|---|---|
| `app/` | Current source (2.0.0.0), `app.json`, `AppSourceCop.json`, rulesets |
| `baseline/` | Compiled v1.0.0.0 package, used as the AppSourceCop baseline |
| `baseline-source/` | Source of v1.0.0.0, for reference and rebuilding |
| `non-technical/` | Track A: requirement brief and comparison template |
| `GRL AppSource Sample_2.0.0.0.app` | Compiled current version, installable in a sandbox |
