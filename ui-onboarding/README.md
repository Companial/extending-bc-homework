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
| `app/src/demo-delivery-day/` (IDs 50122–50125) | A separate "delivery day" field on Customer. Presenter demo asset. Ignore it for the homework, or delete the folder |

Not included, on purpose: an assisted setup guide and a setup notification. Those are the developer homework.

## Install the app

1. Take the `.app` file in this folder (`GRL UI and Onboarding_1.0.0.0.app`). Use a sandbox.
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

### How to do it, step by step

Do this in a sandbox. All the steps are in the browser client; no development tools are needed.

#### Profile, role centre and customised pages

Your user needs the **D365 Profile Mgt.** permission set or equivalent. Without it you cannot add fields that are not already defined on the page.

1. Choose **Search** (Alt+Q), enter **Profiles (Roles)** and open the page.
2. Choose **New** and fill in the fields. Hover over a field to read its description. Set the **Role Center** the persona should land on.
3. Select the **Enabled** checkbox if users should be able to pick the role on **Available Roles**.
4. Select the profile line, choose **Edit**, then choose **Customize pages**. A new browser tab opens with the **Customizing** banner.
5. Change the role centre and open your list (for example **GRL Customer Tiers**) the same way a user personalises: show, hide and move fields and actions. To add a field that is in the table but not on the page, choose **+ Field** and drag it from the **Add field to page** pane. To open a page, Ctrl+Click an action that is highlighted with an arrowhead.
6. Choose **Done** on the banner and close the tab.
7. Back on the profile, choose **Manage customized pages** to check that both pages are listed.
8. On **Profiles (Roles)**, choose **Export Profiles**. A zip file is downloaded; this is the profile package.

Things to know:

- Customisation cannot create new fields, only show existing ones. A field added this way is locked for editing and cannot be unlocked.
- **Export Profiles** exports all user-created profiles and page customisations in the tenant, not only yours. It does not export profiles or customisations that come from extensions. Delete or ignore other profiles in the package.
- To test the package, choose **Import Profiles** on **Profiles (Roles)** and follow the **Import Profiles** guide. You can import selected profiles only. Importing needs the **SUPER** or **D365 Profile Mgmt** permission set.
- Users see a changed profile only after they sign out and in again.

Learn: [Create a profile, export and import](https://learn.microsoft.com/dynamics365/business-central/admin-users-profiles-roles), [Customise pages for a profile](https://learn.microsoft.com/dynamics365/business-central/ui-personalization-manage), [Profile package contents](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-design-profiles-using-client).

#### Configuration package with master data

Creating a company needs the **SUPER** permission set. Exporting a package needs **Direct Read** effective permission on every table in it; importing needs **Direct Insert** and **Direct Modify**. Indirect permissions are not enough.

1. In the source company, enter your five customers and five items.
2. Open **Configuration Worksheet**. Add a line of type **Area**, then add the tables you want to transfer (**Customer**, **Item**, optionally **GRL Customer Tier**). Choose **Get Tables**, set the table types and filters on the **Get Config. Tables** request page, and choose **OK**.
3. Select the worksheet lines and choose **Assign Package**. On **Configuration Packages**, select an existing package or create a new one.
4. Export the package as a `.rapidstart` file, or to Excel.
5. Create the target company: open **Companies**, start the **Create New Company** guide and pick **Create New - No Data** (or **Production - Setup Data Only**). Wait until the setup status on **Companies** shows it is ready, then switch to it in **My Settings**.
6. In the new company open **Configuration Packages**, import the file you exported and apply it. If you worked in Excel, choose **Import from Excel** on the package card, validate the data, then choose **Apply Package**.
7. Check **Customers** and **Items** in the new company.

Things to know:

- Do not include tables that hold posted entries (for example customer or item ledger entries). They cannot be imported.
- The source and target must run the same Business Central version, and the same app version if you include `GRL Customer Tier`. Missing tables or fields are skipped on import.
- Use configuration packages to set up a company for the first time, not on a company in production.
- In the Excel workbook, do not move, change or delete columns; otherwise it cannot be imported. Blob fields cannot be transferred through Excel.
- A new company cannot be renamed later, only its **Display Name**.

Learn: [Set up company configuration packages](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/set-up-standard-company-configuration-packages), [Apply company configuration packages](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/apply-company-configuration-packages), [Create new companies](https://learn.microsoft.com/dynamics365/business-central/about-new-company), [Use Excel to import data](https://learn.microsoft.com/dynamics365/business-central/across-import-data-configuration-packages).

#### Getting-started checklist

A checklist item is built from an existing *guided experience item* (for example an **Assisted Setup** guide, a **Learn** link or a **Video**). The client lets you select these tasks; it cannot create new ones or take an arbitrary link. Pick three existing tasks that suit your persona. A custom task such as the GRL setup guide needs an extension, which is the developer track.

1. Search for **Checklist Administration** and open it.
2. Choose **Create checklist item**.
3. In **Guided Experience Type**, select the type of task, such as **Assisted Setup**, **Learn** or **Video**.
4. In **Task**, open the lookup and select an existing task.
5. In **Completion Requirements**, choose **Anyone with roles** (one user completes it for everyone), **Everyone with roles** (each user completes it) or **Specific users**.
6. For the two role options, add your persona's profile as a **Role ID** in **Checklist Item Roles**. For **Specific users**, add users in **Checklist Users**. An item needs at least one role or user.
7. In **Order ID**, enter a number above zero. Lower numbers appear earlier.
8. Close the card. Repeat for the other items.
9. To change an item later, open **Checklist Administration**, select its **Task**, edit the card and close it. Changing the completion requirements asks you to confirm removal of existing assignments.
10. Take your screenshot of **Checklist Administration**.

Things to know:

- Users see the checklist on their Role Centre, when it is shown there, for items assigned to them or their role.
- An assisted setup item can appear completed if the underlying guide is already completed for the company.

Learn: [Onboarding checklists for users](https://learn.microsoft.com/dynamics365/business-central/admin-checklist).

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
