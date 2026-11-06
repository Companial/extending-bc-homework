# AL-Go – homework

Sample app for the *Extending BC* workshop, AL-Go track. Target: Business Central 29 (2026 release wave 2). Object IDs 50180–50199, prefix `GRL`.

Microsoft updates Business Central whether you're ready or not. Owning an extension means being ready every month and every six months, and a pipeline is the cheapest way to stay ready. In this track you set up a repository from the AL-Go template, get a green build, and deploy to a sandbox through the pipeline.

## Task

1. Create a GitHub repository from the **AL-Go-PTE** template.
2. Add the sample app and get CI/CD green.
3. Deploy the app to a sandbox through the pipeline.

## Before you start

- A **GitHub account**. A public repository is simplest. A private repository on a free plan can't use GitHub environments and environment secrets; see the note under *Deploy* below.
- A **BC sandbox** on BC 29, and a place where you can register an Entra app (the same constraint as the Integrations track; a partner or demo tenant is fine).
- Don't use production, and don't use a customer tenant.

## What is in the box

| Object | ID | Purpose |
|---|---|---|
| Table `GRL Work Note` | 50180 | A note with a "Done" flag |
| Page `GRL Work Notes` | 50180 | List with an action that counts open notes |
| Codeunit `GRL Work Note Mgt.` | 50180 | One procedure, `CountOpenNotes` |
| Permission set `GRL ALGO` | 50180 | Everything the app needs |

The app is deliberately tiny and compiles clean. It exists so you can concentrate on the pipeline. The compiled `.app` is in this folder; the pipeline needs the **source**.

## Minimum deliverable

1. **Repository from the template.** Open [microsoft/AL-Go-PTE](https://github.com/microsoft/AL-Go-PTE), choose **Use this template**, name your repository. Under *Settings → Actions → General*, allow workflows to create pull requests, as the [Learn page](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/al-go/algo-overview) and the AL-Go [get started guide](https://github.com/microsoft/AL-Go/blob/main/Scenarios/GetStarted.md) describe.
2. **Add the sample app and get CI green.** Two routes (either is fine):
   - Copy the `al-go/` folder from this repository into your repository as a sub-folder (for example `GRL AL-Go Sample`), commit to `main`, and let CI/CD run.
   - Or run the **Add existing app or test app** workflow with a direct download URL of a `.zip` that contains **only** the `al-go` folder (the workflow adds every folder with an `app.json` it finds, so don't point it at a zip of the whole homework repository). It creates a pull request. Merge it.
   Look at the **CI/CD** run: *Initialization*, *Build*, and so on. All jobs must be green. Screenshot the run summary.
3. **Deploy to a sandbox through the pipeline.**
   1. Create a GitHub **environment** named exactly like your BC sandbox (*Settings → Environments*).
   2. Add an environment secret `AUTHCONTEXT` that holds a compressed, single-line JSON: `{"TenantID":"…","ClientID":"…","ClientSecret":"…"}`. Register an Entra app for this first, as in the Integrations track, but also give it the **Dynamics 365 Business Central** *application* permission `Automation.ReadWrite.All` next to `API.ReadWrite.All`, and grant admin consent (the automation APIs need it; [Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/automation-apis-using-s2s-authentication)). *Which* permissions the deployment needs for a sandbox is still being confirmed. If the deployment fails with an authorisation error, check these two first.
   3. In BC, register that app on **Microsoft Entra Applications** with the permission sets **D365 AUTOMATION** and **EXTEN. MGT. - ADMIN**.
   4. Run the **Publish To Environment** workflow, or push a new commit to `main` (sandbox deployment happens on CI/CD by default).
   5. Check that the app shows in the sandbox (Extension Management in the client, or Manage Apps in the admin centre) and that *GRL Work Notes* opens.

   Details: [Register a sandbox environment](https://github.com/microsoft/AL-Go/blob/main/Scenarios/RegisterSandboxEnvironment.md) and [secrets](https://github.com/microsoft/AL-Go/blob/main/Scenarios/secrets.md).
   *Free private repository?* Environments and environment secrets need a paid plan. Instead, list the environment in `.AL-Go/settings.json` and create a **repository secret** named `<environment>_AuthContext`.

Hand in: screenshots of the green run and of the app in the sandbox, plus half a page:

- Who owns the secret in `AUTHCONTEXT`, and when does it expire?
- What would you have to do by hand next April if you hadn't set this up?
- Which of the AL-Go workflows would you use for a customer fix on a Friday afternoon, and why?

## Stretch: AppSourceCop in the pipeline

Add `"enableAppSourceCop": true` to `.AL-Go/settings.json`. In the PTE template this is off by default. Run CI/CD again and read what comes out. You should find findings that exist because this is a per-tenant app and not because the code is wrong, for example:

- the app's ID range `50180–50199` is a per-tenant range, so AppSourceCop rejects it for AppSource
- the manifest is missing `privacyStatement`, `EULA`, `help`, `url` and `logo`
- the cop wants a configured affix: set `appSourceCopMandatoryAffixes` to `["GRL"]` in `.AL-Go/settings.json`

Expect the CI/CD run to go red once the cop is on: several of these findings are errors in a local compile (not yet confirmed in an AL-Go run). Decide which findings you'd fix, which you'd justify, and which tell you "this app is not an AppSource app". Write it down. Settings reference: [AL-Go settings](https://github.com/microsoft/AL-Go/blob/main/Scenarios/settings.md).

## Pitfalls

| Symptom | Likely cause |
|---|---|
| CI doesn't start after you copy the app | The app folder must contain `app.json`; check it was committed to `main` |
| *Add existing app* fails | The URL isn't a direct download, or the zip doesn't contain an `app.json` |
| Build succeeds but nothing deploys | GitHub environment name doesn't match the BC environment name, or the secret is missing |
| Deployment fails with an authorisation error | The app isn't registered in BC with the two permission sets, or the secret JSON has a trailing newline |
| Workflows can't open a pull request | *Allow GitHub Actions to create and approve pull requests* is off |

## Compile it yourself

Open the folder in VS Code with the AL Language extension, download symbols for a BC 29 sandbox, and build with `Ctrl+Shift+B`. Keep `.alpackages` out of any repository (`.gitignore` already excludes it).

## Resources

- [AL-Go for GitHub (Learn)](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/al-go/algo-overview)
- [AL-Go for GitHub – repository and documentation](https://github.com/microsoft/AL-Go)
- [AL-Go for GitHub workshop (self-paced)](https://github.com/microsoft/AL-Go/blob/main/Workshop/Index.md)
- [Set up CI/CD for an existing per-tenant extension](https://github.com/microsoft/AL-Go/blob/main/Scenarios/SetupCiCdForExistingPTE.md)
