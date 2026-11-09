# Track: AL-Go

Create a repository from the AL-Go template, add the sample app, get CI green and deploy to a sandbox.

## What you get
- `GRL AL-Go Sample_1.0.0.0.app`: compiled app for BC 29 (runtime 18.0).
- `app/`: the source. Object IDs 50180–50199, prefix `GRL`. It builds without errors or warnings under CodeCop, UICop, PerTenantExtensionCop and (with `GRL.ruleset.json`) AppSourceCop, so any finding you see later is one you introduced.

You need: a GitHub account and a BC sandbox where you can set up authentication for deployment. **Unverified:** how partners without a sandbox get one (on the presenters' "to verify" list).

## Minimum deliverable
1. Repository created from the [AL-Go-PTE](https://github.com/microsoft/AL-Go-PTE) template.
2. The sample app added and **CI/CD green**.
3. The app **deployed to a sandbox through the pipeline**.

## Steps
1. Open [AL-Go-PTE](https://github.com/microsoft/AL-Go-PTE), choose **Use this template** and create your repository.
2. Add the app. Either:
   - copy the `app` folder from this track into the root of your repository and commit (it contains an `app.json`, so AL-Go finds it), or
   - run the **Add existing app or test app** workflow and give it this **Direct Download URL** of the app: `https://github.com/Companial/extending-bc-homework/raw/main/al-go/GRL%20AL-Go%20Sample_1.0.0.0.app`
3. Watch the **CI/CD** workflow. It builds on every commit and pull request. It should go green.
4. Deploy. In your repository: **Settings → Environments → New environment**, named exactly like your sandbox. Add an environment secret **AUTHCONTEXT** with compressed JSON, no trailing newline:
   `{"TenantID":"<tenantId>","ClientID":"<clientId>","ClientSecret":"<secret>"}`
   Use an Entra app registered for service-to-service access, as in the Integrations track, with three differences for deployment:
   - In Entra, grant it the Business Central application permission **Automation.ReadWrite.All** and give admin consent. The Automation API is what AL-Go deploys through, so `API.ReadWrite.All` from the Integrations track is not enough on its own. The [Learn guide](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/automation-apis-using-s2s-authentication) lists both.
   - In Business Central, register it on the **Microsoft Entra Applications** page, set State to **Enabled**, and assign the permission sets **D365 AUTOMATION** and **EXTEN. MGT. - ADMIN**.
   - Don't assign SUPER. Applications can't be assigned it.
5. **Actions → Publish To Environment → Run workflow.** Enter **latest** as the app version (there is no release yet) and your environment name.
6. Open the sandbox and search for **Workshop Notes**. That page is your proof.

**Private repository on a free GitHub plan?** Environments and environment secrets need GitHub Pro, Team or Enterprise there. Use the `environments` setting and a repository secret named `<environment name>_AuthContext` instead.

## Stretch: AppSourceCop in the pipeline
The PTE template doesn't run AppSourceCop. In `.AL-Go/settings.json` add:

```json
{
  "enableAppSourceCop": true,
  "appSourceCopMandatoryAffixes": ["GRL"]
}
```

The sample's `app/AppSourceCop.json` already sets the affix. Commit and watch CI/CD. A PTE uses IDs in 50000–99999, which AppSourceCop rejects, so `app/GRL.ruleset.json` switches off the three rules that only matter when publishing to AppSource (AS0084, AS0051, AS0092). AL-Go can use it through the `rulesetFile` setting. **Unverified:** the exact path form `rulesetFile` expects in a project folder, so check [AL-Go settings](https://github.com/microsoft/AL-Go/blob/main/Scenarios/settings.md).

Then add a deliberate finding (a field without a tooltip) and read how the pipeline reports it.

## Remember
- AL-Go updates itself through the **Update AL-Go system files** workflow. It needs a `GhTokenWorkflow` secret ([walkthrough](https://github.com/microsoft/AL-Go/blob/main/Scenarios/GhTokenWorkflow.md)). A pipeline you don't update is a pipeline that breaks on the next BC release.
- `BcContainerHelper` official support ends **1 October 2027** ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/al-go/algo-deprecating-bccontainerhelper)).

## Links
- AL-Go overview: [Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/al-go/algo-overview)
- AL-Go repository and documentation: [microsoft/AL-Go](https://github.com/microsoft/AL-Go/blob/main/README.md)
- Self-paced: [AL-Go for GitHub Workshop](https://github.com/microsoft/AL-Go/blob/main/Workshop/Index.md)
- Deploying to a sandbox: [Register a sandbox environment](https://github.com/microsoft/AL-Go/blob/main/Scenarios/RegisterSandboxEnvironment.md)
