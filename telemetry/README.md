# Telemetry homework: sample app

You can't own what you can't see. A job that fails quietly on a customer environment is found by the customer, not by you. In this track you connect Business Central to Azure Application Insights, run a small sample app that emits its own telemetry and has a job queue entry that fails, and answer three questions from the telemetry alone.

The sample app is deliberately minimal. You don't need to read AL to do the minimum deliverable.

## Task

1. Provision an Azure Application Insights resource and connect it to a **sandbox environment**.
2. Install the sample app and run the scripted actions in order.
3. Answer questions A, B and C below from the telemetry.

## Minimum deliverable

1. An Application Insights resource connected to a sandbox **environment**.
2. The sample app installed and the scripted actions run in order.
3. Written answers to A, B and C. For each: the KQL query or the agent prompt you used, and a screenshot of the result.

## Developer variant

Also add your own Application Insights connection string to the sample app's `app.json` (preferably a **second** resource), rebuild, publish and reinstall. Run the scripted actions again on a clean sandbox (see "Running it twice" below) and answer question D as well.

## What is in the box

| Object | ID | Purpose |
|---|---|---|
| Table `GRL Demo Record` | 50160 | Records the job sends: `No.`, `Description`, `Target Code`, `Status` |
| Enum `GRL Demo Record Status` | 50160 | Pending, Sent |
| Page `GRL Demo Records` | 50160 | List with the three scripted actions |
| Codeunit `GRL Inventory Sync Job` | 50161 | The job queue target |
| Codeunit `GRL Telemetry` | 50162 | Sends all custom events |
| Codeunit `GRL Posting Subscriber` | 50163 | Logs a custom event when a sales invoice is posted |
| Codeunit `GRL Demo Job Setup` | 50164 | Creates the job queue entry |
| Permission set `GRL Telemetry` | 50165 | Everything the app needs |

The app is built for Business Central 29 (platform, application `29.0.0.0`, runtime 18.0). Object IDs stay within 50160–50179, so you can install it next to the other workshop sample apps.

Custom event IDs (treat them like an API):

| Event ID | Meaning |
|---|---|
| `GRL-0001` | Demo records created |
| `GRL-0002` | Sales invoice posted |
| `GRL-0010` to `GRL-0013` | Inventory sync job: started, progress, record failed, finished |

Events are sent with `TelemetryScope::All` (to the environment resource and, if you set one, the app resource), data classification `SystemMetadata`, and no customer data.

## Install the sample app

Use the compiled `GRL_Telemetry_Sample_1.0.0.0.app` in this folder.

- Online sandbox: Admin centre › Environments › your sandbox › **Manage Apps** › **Install Extension** › choose the `.app`, deployment schedule *Immediately*. Follow progress under **Operations**. You need to be an admin of the environment's tenant (or a delegated admin); if you aren't, ask whoever is ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-manage-apps)). Uploading through the in-client **Extension Management** page is deprecated. See also [Deploying a tenant customisation](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-deploy-tenant-customization).
- **Note:** uploading through the in-client **Extension Management** page is deprecated. Microsoft's deprecation list currently gives removal as 2027 release wave 1 ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/upgrade/deprecated-features-platform)). It may still work in your sandbox today, but prefer the admin centre route.
- Developers can also publish from VS Code, or build from the source in this folder (see below).

Then assign the permission set **GRL Telemetry** to your user (and make sure you may manage job queue entries, for example with `D365 JOBQUEUE`, or are SUPER).

## Provision Application Insights and connect it

1. In the Azure portal, create a **workspace-based** Application Insights resource. Free-tier volume is enough for this homework. Set a **daily cap** while you are there. See [Enable Application Insights](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/telemetry-enable-application-insights) and [Control telemetry costs](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/telemetry-control-cost).
2. Copy the **connection string** from the resource's Overview page. Don't use the instrumentation key alone.
3. In the Business Central admin centre open Environments, your sandbox, and set **Application Insights Key** to your connection string. Saving **restarts the environment**, so don't do this while someone is working in it.
4. In Business Central, open the **User Card** for the users who run the scripted actions and assign a **Telemetry ID**. It only applies to events from that moment on, so do it before step 1 of the script.
5. Events take a little while to appear. Open the resource's **Logs** blade and run `traces | take 10`. Note how long it took for your first event to show up.

Data lands in the `traces` table (`AppTraces` if you query from the Log Analytics workspace). Custom dimensions are in `customDimensions`.

## The scripted actions

Start from a freshly installed app with an **empty** demo table (see "Running it twice"). Open the page **GRL Demo Records**.

0. Assign a Telemetry ID to your user (User Card). Note the name of your sandbox environment.
1. Run **Create Quick Batch** once.
2. Run **Create Full Batch** once.
3. Create and post three sales invoices with **1, 4 and 12 lines** (any customer and item).
4. Run **Create Demo Job**. It creates a job queue entry for the sync codeunit and sets it to Ready. Open **Job Queue Entries** and watch it. Wait for it to fail and stop (a few minutes: it retries after a delay). **Don't fix anything yet.**
5. Wait for ingestion, then answer A, B and C.

If the job queue entry stays **On Hold** after step 4, set it to **Ready** by hand.

> **Sign in as a licensed user of the tenant, not as a delegated admin.** Job queue entries created by a delegated admin stay *On Hold* and can't be started by that admin; a licensed customer user has to start them ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/delegated-admin)). If you only have delegated access, ask a licensed user in the tenant to run the job queue steps.

## Questions

Each answer is read from the telemetry. Some facts exist only in the custom events, and some are on no Business Central page.

**A (usage).** For your scripted session: how many times did each batch mode run and how many records did it create in total, and how many posted invoices fell into each size band?

**B (cause).** Which codeunit and which procedure failed, which record number broke it, how many records were already processed, and what was the reason code?

**C (silent failure).** How many attempts did the job make and over what period, which single event would have alerted you that it had stopped for good, and how often did it fire?

**D (developer variant).** With only the app's `app.json` resource connected, which of A, B and C can you still answer, and why?

### Getting answers faster

You can write KQL by hand, ask an agent that knows Business Central telemetry, or use the Azure portal's chat on the Logs blade. Whatever you use, **read every query it writes** and check that the dimension names it uses really exist in your data. Record the prompt and the query for each answer.

Hints without answers: custom dimensions from AL code appear with an `al` prefix. Start with a query that lists all event IDs you received.

## Stretch: fix it and rerun

Fix the failing record (give it a Target Code on the **GRL Demo Records** page) or decide how the job should treat bad records, then run **Create Demo Job** again. What changes in the telemetry? Which fix would your customer accept?

## Running it twice

Record numbers come from an auto-increment field that does not reset. The scripted order (Quick, then Full, on an empty table) is what the questions assume. For a second run use a new sandbox, or reinstall the app with its data removed, before repeating the script.

## Developer variant: your own connection string

In `app.json` the property is left empty on purpose:

```json
"applicationInsightsConnectionString": ""
```

Put your own connection string between the quotes, rebuild (VS Code or `alc.exe`), publish and reinstall. Requires runtime 7.2 or later (this app uses 18.0). Notes:

- **Never commit a real connection string to a public repository.** Anyone holding the `.app` can read it.
- Keep the symbol cache (`.alpackages`) outside the repository. It is in `.gitignore`.
- Build with the AL extension in VS Code, or with the AL compiler and a symbol cache of BC 29.
- Not every platform signal exists at app level. Job queue lifecycle events do not. That is what question D is about.

## Resources

Microsoft documentation:

- [Enable Application Insights for an environment](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/telemetry-enable-application-insights)
- [Enable Application Insights for an app](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-application-insights-for-extensions)
- [Instrument your application for telemetry](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-instrument-application-for-telemetry-app-insights)
- [Job queue lifecycle telemetry](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/telemetry-job-queue-lifecycle-trace)
- [Analyse telemetry with KQL](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/telemetry-analyze-with-kql)
- [Telemetry overview](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/telemetry-overview)

Community (one post):

- Waldo, [BC Telemetry Buddy introduction](https://waldo.be/2025/10/22/i-did-a-thing-again-bc-telemetry-buddy/)

## Folder contents

- `app.json`, `src/`: AL source
- `GRL_Telemetry_Sample_1.0.0.0.app`: compiled package
- `saved/00-event-overview.kql`: a first query that shows what your resource received. Write the queries for A, B and C yourself.
