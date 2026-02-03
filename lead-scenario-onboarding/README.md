✅ Deliverables

Next.js CRUD Pages

/dashboard/leads → Paginated table view with “Edit”, “Delete”, and “Add New Lead”.

/dashboard/leads/new → Create Lead + optional Scenarios inline.

/dashboard/leads/[id]/edit → Edit Lead + associated Scenarios.

React Hook Form + Zod Validation

Form components for both LeadForm and ScenarioForm with proper typing and schema validation.

Server Actions (App Router) or API Routes

/api/leads → CRUD endpoints (create, read, update, delete).

/api/scenarios → CRUD endpoints tied to leads.

Pagination Table (Tailwind + shadcn/ui)

Interactive table with pagination, delete confirmation modal, and consistent Orion branding.

Theme

Dark navy background, metallic blue-gray cards, glowing accent lines.

Consistent typography and iconography using lucide-react.




📁 Folder Structure

```tsx
app/
 └─ dashboard/
     └─ leads/
         ├─ page.tsx                  // Paginated Leads Table
         ├─ new/
         │   └─ page.tsx              // Create Lead + Scenarios Form
         └─ [id]/
             └─ edit/
                 └─ page.tsx          // Edit Lead + Scenarios Form
components/
 ├─ forms/
 │   ├─ LeadForm.tsx
 │   └─ ScenarioForm.tsx
 └─ ui/
     ├─ OrionTable.tsx                // Paginated Table with Orion Styling
     └─ DeleteConfirmModal.tsx
lib/
 ├─ db.ts                             // Postgres Client
 └─ actions/
     ├─ leadActions.ts                // createLead, updateLead, deleteLead, etc.
     └─ scenarioActions.ts
```

🧠 Flow Overview

LeadForm creates/edits lead info.

ScenarioForm dynamically adds scenario entries.

On submit → triggers createLead or updateLead Server Action (in /lib/actions/leadActions.ts), which writes to Postgres via the db client.

Paginated /dashboard/leads page fetches all leads for the logged-in user.

Each row: Edit → /dashboard/leads/[id]/edit, Delete → opens modal confirmation.

Deleting a lead automatically deletes related scenarios (Postgres cascade).

🧱 2. UI Components

LeadForm.tsx and ScenarioForm.tsx (React-Hook-Form + Zod)

OrionTable.tsx (paginated table, shadcn/ui styling)

DeleteConfirmModal.tsx

💻 3. Pages

/dashboard/leads/page.tsx — paginated table

/dashboard/leads/new/page.tsx — create form

/dashboard/leads/[id]/edit/page.tsx — edit form with linked scenarios

🧩 Orion Rigel AI Calculator — User & Scenario Management (Next.js 14 + NextAuth + Vercel Postgres)

Block 1: lib/db.ts
Block 2: lib/actions/leadActions.ts
Block 3: lib/actions/scenarioActions.ts
Block 4: components/forms/LeadForm.tsx
Block 5: components/forms/ScenarioForm.tsx
Block 6: components/ui/OrionTable.tsx + DeleteConfirmModal.tsx
Block 7: Pages

/dashboard/leads/page.tsx

/dashboard/leads/new/page.tsx

/dashboard/leads/[id]/edit/page.tsx