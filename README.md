# Extending BC – homework repository

Homework for the *Extending BC* workshop for Business Central partners. Five tracks, two weeks. Pick **at least one**, ideally two; all five are welcome.

Target: Business Central 29 (2026 release wave 2). All sample objects use the prefix `GRL` and IDs in 50100–50199, split per track so you can install several sample apps in one sandbox.

| Track | Folder | You will… | Object IDs |
|---|---|---|---|
| AppSource | [`appsource/`](appsource/) | Compare three AppSource apps for a requirement brief (lead track), or run AppSourceCop and validation on a sample app and fix or justify every finding | 50100–50119 |
| UI and onboarding | [`ui-onboarding/`](ui-onboarding/) | Configure a role centre, a configuration package and a checklist for a persona, or add an assisted setup guide and a notification in AL | 50120–50139 |
| Integrations | [`integrations/`](integrations/) | Register an Entra app, call a standard API, call a custom API page with your own token | 50140–50159 |
| Telemetry | [`telemetry/`](telemetry/) | Connect Application Insights, run scripted actions in a sample app and answer three questions from the telemetry | 50160–50179 |
| AL-Go | [`al-go/`](al-go/) | Create a repository from the AL-Go template, get CI green, deploy to a sandbox | 50180–50199 |

Each folder holds a `README.md` (task, minimum deliverable, developer or stretch variant, resources), a sample app as **source** and as a compiled **`.app`** you can install without a development setup.

## What you need

- A Business Central **sandbox** on version 29. Never a customer tenant, never production.
- Integrations and AL-Go: a tenant where you may **register Entra apps** (a partner or demo tenant; many company tenants block it).
- AL-Go: a GitHub account. Telemetry: an Azure subscription.
- Installing the `.app` files: Admin centre › Environments › your sandbox › **Manage Apps** › **Install Extension** › choose the `.app`, deployment schedule *Immediately*. Follow progress under **Operations**. You need to be an admin of the environment's tenant (or a delegated admin); if you aren't, ask whoever is ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-manage-apps)). Uploading through the in-client **Extension Management** page is deprecated.

## What to bring to the review

There is no hand-in and no deadline other than the review session. At the review you give a short talk, 5 to 10 minutes (we confirm the length in the workshop): what you tried, what went well, what didn't, and where you have questions. The screenshots or files listed under *Minimum deliverable* in each README, plus the short written answers, are your notes for that talk. Questions before then: the Q&A session one week after the first session, or the workshop chat.

## Ground rules

- Compile the apps yourself if you want to: keep `.alpackages` out of any repository (`.gitignore` excludes it).
- Don't install two sample apps from the same track at once (they share object IDs).
- The point of the homework isn't the code. It's deciding where a change belongs and keeping it alive afterwards.
