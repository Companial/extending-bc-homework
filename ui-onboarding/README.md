# UI and onboarding – homework

Sample app for the *Extending BC* workshop, UI and onboarding track. Target: Business Central 29 (2026 release wave 2). Object IDs 50120–50139, prefix `GRL`.

The app is deliberately small. It gives you a setup table, a plain setup card and some master data. The interesting work is yours.

## What is in the app

| Object | Purpose |
|---|---|
| Table 50120 `GRL Onboarding Setup`, page 50120 `GRL Onboarding Setup` | One setup record and a normal card page. Has a `Setup Complete` flag. Search for *GRL Onboarding Setup* |
| Codeunit 50121 `GRL Onboarding Install` | Creates the setup record on install. `Setup Complete` stays false |
| Codeunit 50120 `GRL Onboarding Mgt.` | Hook points with comments: `IsSetupComplete`, `CompleteSetup`, `GetSetupPageId` |
| Table 50121 `GRL Customer Tier`, page 50121 `GRL Customer Tiers` | A small master-data table for the configuration package |
| Permission set 50120 `GRL ONBOARDING` | Access to all of the above |
| `src/demo-delivery-day/` (IDs 50122–50125) | A separate "delivery day" field on Customer. Presenter demo asset. Ignore it for the homework, or delete the folder |

Not included, on purpose: an assisted setup guide and a setup notification. Those are the developer homework.

## Install the app

1. Take the `.app` file in this folder (`Extending BC Workshop_GRL UI and Onboarding_1.0.0.0.app`). Use a sandbox.
2. Admin centre › Environments › your sandbox › **Manage Apps** › **Install Extension** › choose the `.app`, deployment schedule *Immediately*. Follow progress under **Operations**. You need to be an admin of the environment's tenant (or a delegated admin); if you aren't, ask whoever is ([Learn](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-manage-apps)). Uploading through the in-client **Extension Management** page is deprecated.
3. Wait until the operation shows as completed under **Operations**, then open **Extension Management** in the client to check that the app is *Installed*.
4. Assign the permission set **GRL ONBOARDING** to your user. Search for *GRL Onboarding Setup* to check.

## Compile it yourself (developer variant)

1. Open the folder in VS Code with the AL Language extension.
2. Download symbols for a BC 29 sandbox (**AL: Download symbols**). Keep the `.alpackages` folder out of any repository; `.gitignore` already excludes it.
3. Build with `Ctrl+Shift+B`, or call `alc.exe /project:<folder> /packagecachepath:<symbols folder> /out:<file.app>`.
4. Publish with `F5` or upload the `.app` as above.

## Functional track

Minimum deliverable:

1. A profile (role) for a demo persona (for example "Order desk clerk"), created in the client, with a role centre chosen and at least two customised pages: the role centre and one list. The **GRL Customer Tiers** list is a fair candidate. Export the profile as a profile package and attach it.
2. A configuration package with master data (five customers and five items is enough; add `GRL Customer Tier` if you like), exported, and applied to a new company in a sandbox.
3. A getting-started checklist with at least three items for that persona, as a screenshot of **Checklist Administration**.
4. A half-page note: for each of the three, which level you chose (personalise, configure, extend) and why.

Stretch: a second persona, or an analysis view bookmarked on the role centre. Power BI embedding is only for partners who already have a licence.

## Developer track

Minimum deliverable:

1. An **assisted setup page** (a `NavigatePage`) in the app, registered with `OnRegisterAssistedSetup` of codeunit `Guided Experience` as the **primary setup**. **Set up this app** on Extension Management opens it. The wizard sets `Setup Complete` (see `CompleteSetup`).
2. A **setup notification**: on a page of the app, when the setup is not complete, send a notification with an action that opens the guide. It disappears when setup is complete.
3. The app compiles and installs from the `.app`.

Hook points already in place:

- `GRL Onboarding Mgt.`: `IsSetupComplete()` for the notification, `CompleteSetup()` for the wizard's last step.
- `GRL Onboarding Setup` page: stays as the plain card. Build the wizard as a new page.
- Check the `InsertAssistedSetup` signature against the BC 29 symbols; Learn pages differ.

Stretch: a checklist item added with codeunit `Checklist`, and a teaching tip on the setup page.

Mixing both tracks is encouraged: the functional persona can be the target of the developer's checklist item.

Keep new objects inside 50120–50139 and keep the `GRL` prefix. Think about what each addition costs you at the next update.

## Resources

- [Onboard users to your app](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/onboarding-onboard-users-to-your-app)
- [Customise pages for roles](https://learn.microsoft.com/dynamics365/business-central/ui-personalization-manage)
- [Onboard users with checklists](https://learn.microsoft.com/dynamics365/business-central/admin-checklist)
- [Apply company configuration packages](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/apply-company-configuration-packages)
- [Notifications](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-notifications-developing)
- Community post: none selected yet.
