# Track: Integrations

Set up an Entra app registration, call a standard API, publish a custom API page and consume it from a client that authenticates on its own.

## What you get
- `GRL Integrations Sample_1.0.0.0.app`: compiled app for BC 29 (runtime 18.0). Install it from the admin centre (Environments › your sandbox › **Manage Apps** › **Install Extension**), no development setup needed.
- `app/`: the source. Object IDs 50140–50159, prefix `GRL`.

The app contains:

| Object | What it is |
|---|---|
| Table 50140 `GRL Car Brand` | Custom table with 15 sample brands (seeded on install) |
| Page 50140 `GRL Car Brands` | List page, with a **Create Sample Data** action for companies created after installation |
| Page 50141 `GRL Car Brand API` | Custom API page, `growthlab/workshop/v1.0`, entity set `carBrands` |
| Permission set 50140 `GRL Integrations` | Everything your Entra app needs, nothing more |

## Minimum deliverable
1. **Entra app registered and enabled in BC** with permission sets.
2. **One successful standard API v2.0 call**, e.g. `GET companies`.
3. **The custom API page called with a token your client obtained itself** (Postman, Bruno or a small script), not a flow running as you.

## Steps
1. Use a tenant where you are allowed to register Entra apps. Don't use a customer or employer tenant that blocks it.
2. Install the `.app` in a **sandbox**. If the list in step 5 is empty, open **Car Brands** and run **Create Sample Data**.
3. Register the app in Entra and create a client secret (copy it straight away, it's shown once).
4. Add the **Dynamics 365 Business Central** application permission `API.ReadWrite.All` and grant admin consent.
5. In BC open **Microsoft Entra Applications**, add the client ID, set **State** to **Enabled**, and assign the permission sets **D365 BASIC** and **GRL Integrations**. `SUPER` can't be assigned to an app, which is why the sample ships its own permission set.
6. Request a token from `https://login.microsoftonline.com/<tenantId>/oauth2/v2.0/token` (client credentials) with scope `https://api.businesscentral.dynamics.com/.default`.
7. Call the APIs. The file [`requests.http`](requests.http) has all of these as ready-made requests (VS Code REST Client; in Postman or Bruno create the same calls by hand). Replace the placeholders:
   - `GET https://api.businesscentral.dynamics.com/v2.0/<tenantId>/<environmentName>/api/v2.0/companies`
   - `GET https://api.businesscentral.dynamics.com/v2.0/<tenantId>/<environmentName>/api/growthlab/workshop/v1.0/companies(<companyId>)/carBrands`

**Where people get stuck:** missing admin consent, app not enabled in BC, no permission sets assigned, wrong scope.

## Stretch / developer variant
- Add `lastModifiedDateTime` filtering: `...carBrands?$filter=lastModifiedDateTime gt 2026-11-01T00:00:00Z` and change a row to see the delta.
- Publish a **v2.0** API page *alongside* v1.0 (for example with `brandName` instead of `name`). v1.0 consumers must keep working. A published API version is a contract.
- Create a record with `POST` and read it back.

## Remember
- Client secrets expire. Put the renewal date in a calendar, or the integration stops one morning. For production, [Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/automation-apis-using-s2s-authentication) recommends certificates over secrets.
- Turn on **Allow HttpClient Requests** (Extension Management → Configure) if any extension calls out from the sandbox.
- Online limits apply to Entra apps just as to users: 6,000 OData requests per 5 minutes, then `429` ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/operational-limits-online)).

## Links
- Standard APIs v2.0: [Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/api-reference/v2.0/)
- Develop a custom API: [Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-develop-custom-api)
- Service-to-service authentication: [Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/automation-apis-using-s2s-authentication)
- Community, step by step: [Kauffmann](https://www.kauffmann.nl/2020/09/14/service-to-service-authentication-for-automation-apis-in-business-central/)
