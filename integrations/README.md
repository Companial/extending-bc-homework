# Integrations – homework

Sample app for the *Extending BC* workshop, Integrations track. Target: Business Central 29 (2026 release wave 2). Object IDs 50140–50159, prefix `GRL`.

An integration that works at go-live can still fail at volume, fail silently, or break when someone leaves. In this track you let an application authenticate to Business Central **on its own**, call a standard API, and call a custom API page that comes with the sample app. No user signs in, and no flow runs as you.

## Task

1. Register an app in Microsoft Entra and give it access to a Business Central **sandbox**.
2. Call a standard API (v2.0).
3. Call the sample app's custom API page, with a token your client obtained itself.

## Before you start

- Use a **tenant where you may register Entra apps**. Many company tenants block this. A partner or demo tenant is fine. Nothing here needs a customer tenant, and you shouldn't use one.
- Use a **sandbox** environment on BC 29. Don't use production.
- A client that can send HTTP requests: [Postman](https://www.postman.com/), [Bruno](https://www.usebruno.com/), or PowerShell 7 / `curl`. A small script is fine.

## What is in the box

| Object | ID | Purpose |
|---|---|---|
| Table `GRL Equipment` | 50140 | 30 rental items. Seeded on install in every company that exists at that moment (companies created later stay empty) |
| Enum `GRL Equipment Status` | 50140 | Available, Rented, In Service |
| Page `GRL Equipment` | 50140 | A plain list, so you can see the data and check edits |
| Page `GRL Equipment API` | 50141 | The custom API page. `grl/workshop/v1.0`, entity set `equipmentItems` |
| Codeunit `GRL Equipment Install` | 50140 | Seeds the data |
| Permission set `GRL INTEGRATIONS` | 50140 | Everything the app needs. You will assign it to your Entra app |

Installing the app is enough to publish the API page. You don't register anything as a web service.

The API address looks like this (replace the placeholders):

```
https://api.businesscentral.dynamics.com/v2.0/<tenant id>/<environment name>/api/grl/workshop/v1.0/companies(<company id>)/equipmentItems
```

## Install the app

1. Take the `.app` in this folder (`Extending BC Workshop_GRL Integrations Sample_1.0.0.0.app`).
2. Admin centre › Environments › your sandbox › **Manage Apps** › **Install Extension** › choose the `.app`, deployment schedule *Immediately*. Follow progress under **Operations**. You need to be an admin of the environment's tenant (or a delegated admin); if you aren't, ask whoever is ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-manage-apps)). Uploading through the in-client **Extension Management** page is deprecated.
3. In BC, search for *GRL Equipment*. You should see 30 rows.

## Minimum deliverable

1. **Entra app registered and enabled in BC.**
   1. Register the app in Entra and create a client secret. Copy the secret value straight away; it is shown only once.
   2. Add the **Dynamics 365 Business Central** *application* permission `API.ReadWrite.All` and grant admin consent.
   3. In BC, open **Microsoft Entra Applications**. Add the client ID, set **State** to **Enabled**, and assign permission sets. Assign `GRL INTEGRATIONS` plus a permission set that lets the app read the standard data you call (for example `D365 BASIC`). `SUPER` can't be assigned to an app. Use least privilege.
   4. Request a token from `https://login.microsoftonline.com/<tenant id>/oauth2/v2.0/token` with `grant_type=client_credentials` and scope `https://api.businesscentral.dynamics.com/.default`.
2. **One successful standard API call:** `GET .../api/v2.0/companies`. Screenshot the response.
3. **The custom API called with your own token:** `GET .../api/grl/workshop/v1.0/companies(<company id>)/equipmentItems`. Then change one record with `PATCH` (it needs the `If-Match` header with the record's `@odata.etag`) and show the change in the **GRL Equipment** page.

Hand in: screenshots of the three calls, plus half a page answering:

- Who owns the client secret, and when does it expire? What happens to the integration that morning?
- Which permission sets did you give the app, and why those?
- If a customer asked for one more field on `equipmentItems`, what would you change, and what would that cost you later?

## Where people get stuck

| Symptom | Likely cause |
|---|---|
| `401 Unauthorized` | Wrong tenant ID, wrong scope, or an expired secret |
| `401` with a valid token | The app isn't in **Microsoft Entra Applications**, or **State** isn't *Enabled* |
| `403` or an empty list | No permission sets assigned, or admin consent missing |
| Token request fails | Scope must be `https://api.businesscentral.dynamics.com/.default` (not a user scope) |
| `404` on the custom API | App not installed in that environment, or the company ID or the API path is wrong |
| Edit rejected | `PATCH` without `If-Match`, or with an old ETag |

## Developer variant

Pick one or both:

1. **Change an API without breaking anyone.** A published API version is a contract. Add a second page with `APIVersion = 'v2.0'` next to the existing one, where the field `dailyRate` is renamed `ratePerDay`. Keep v1.0 working. Call both from your client and show that an old consumer still works. Stay in 50140–50159.
2. **Make it safe to read in bulk.** Add a read-only API page for extraction (`Editable = false`, `DataAccessIntent = ReadOnly`) and call it with the header `Data-Access-Intent: ReadOnly`. Then fetch only records changed since your last call, using `lastModifiedDateTime`.

Stretch for everyone: use a **certificate** instead of a client secret, or write down your renewal process for the secret.

## Compile it yourself

Open the folder in VS Code with the AL Language extension, download symbols for a BC 29 sandbox, and build with `Ctrl+Shift+B`. Keep `.alpackages` out of any repository (`.gitignore` already excludes it).

## Resources

- [Authenticate with service-to-service (client credentials)](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/automation-apis-using-s2s-authentication)
- [Set up Microsoft Entra authentication for apps](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-develop-connect-apps#set-up-microsoft-entra-id-based-authentication)
- [API v2.0 reference](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/api-reference/v2.0/)
- [Develop a custom API](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-develop-custom-api)
- [Operational limits (online)](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/operational-limits-online)
- Community, step by step: [Service-to-service authentication for automation APIs](https://www.kauffmann.nl/2020/09/14/service-to-service-authentication-for-automation-apis-in-business-central/)
