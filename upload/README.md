# ⭐ TECHNICAL BRIEF — BORB FIRST-LOGIN WELCOME EXPERIENCE

## 1. Objective
Implement a First-Time Login Welcome Experience that triggers only once per user, guiding them into the Orion Rigel ecosystem.

This system must:
- Detect when a user signs in for the first time
- Redirect them to a cosmic Welcome Page instead of the dashboard
- Display animated branding + onboarding instructions
- Offer two onboarding paths:
  - Manual onboarding → `/dashboard/portfolio/new`
  - Bulk Upload onboarding → `/dashboard/bulk-upload`
- Never show again after the user completes or dismisses the welcome screen

## 2. System Components Overview

```tsx
app/
  middleware.ts                             ← redirect logic
  api/
    user/complete-welcome/route.ts          ← mark welcome complete
  (dashboard)/
    bulk-upload/page.tsx
    portfolio/new/page.tsx
    welcome/page.tsx                         ← NEW animated Welcome Page (client)
lib/
  db/user.ts                                 ← helpers for welcome flag
  auth.ts                                    ← user session getter
```

3. Data Model Update

Add a new boolean to the user table:

```sql
SQL
ALTER TABLE users ADD COLUMN has_seen_welcome BOOLEAN DEFAULT FALSE;
```
Purpose

Determines whether the welcome flow should trigger.

4. Welcome Page Routing Logic (middleware.ts)
Goal

Before loading any dashboard route:

If user.loggedIn && !user.has_seen_welcome → redirect to /welcome

Pseudo-logic
```tsx
if (session && !session.user.has_seen_welcome) {
   return NextResponse.redirect(new URL("/welcome", req.url));
}
```

Dashboard pages are protected — only serve after welcome screen is completed.

5. API Endpoint — Mark Welcome Completed

POST /api/user/complete-welcome

Responsibilities:

Mark has_seen_welcome = true in DB for the authenticated user.

Return success.

Response:

```tsx
{ "success": true }
```

6. Welcome Page UX Specification
Page: /welcome
Purpose

Introduce:

The BORB

Orion Rigel cosmic identity

What the calculator does

Next step choices (manual or bulk onboarding)

UI Features

Cosmic animated background

Floating BORB logo orbital animation

Warm introduction message

Step-by-step "Where to begin" instructions

Buttons for:

Begin Manual Onboarding → /dashboard/portfolio/new

Bulk Upload Your Data → /dashboard/bulk-upload

Enter Dashboard → /dashboard

Interaction

Any of these actions will:

Trigger /api/user/complete-welcome

Redirect the user to the selected route

7. State Flow Diagram

```tsx
┌───────────────┐
│ User Sign-Up  │
└───────┬───────┘
        │ First login
        ▼
┌──────────────────────────┐
│ has_seen_welcome = false │
└───────────┬──────────────┘
            ▼
      Redirect to
    /welcome (middleware)
            ▼
    User selects onboarding path
            ▼
POST /api/user/complete-welcome
            ▼
has_seen_welcome = true
            ▼
Redirect to chosen page
            ▼
Subsequent logins go directly to dashboard
```

8. Acceptance Criteria
Functional

 First-time users must be redirected to /welcome.

 Returning users must NOT be shown the welcome again.

 Welcome page must show:

Animated BORB logo

Intro text

Manual onboarding CTA

Bulk upload CTA

Skip to dashboard CTA

 Clicking any CTA:

Marks has_seen_welcome = true

Redirects accordingly

Non-Functional

 Animation does not block interactions.

 Page loads < 2 seconds.

 All calls authenticated and secure.

 Works on mobile & desktop.

9. Dependencies

Next.js middleware

Next-auth (or your auth system) session reading

DB access layer (postgres/js)

New /api/user/complete-welcome route

Client animation libraries (Framer Motion recommended)

10. Engineering Tasks Summary
Backend

Add has_seen_welcome to user table

Create /api/user/complete-welcome

Implement middleware redirect logic

Update auth session serialization to include has_seen_welcome

Frontend

Implement /welcome client page

Create BORB animation component

Wire onboarding buttons → API → routes

Style page in cosmic Orion Rigel theme

Ensure dashboard doesn’t flicker on redirect

11. Risks & Solutions
Risk	Solution
Flash of dashboard before redirect	Use middleware + loading skeleton
User hits back button and re-enters welcome	Block route if has_seen_welcome = true
Animation too heavy	Use Lottie or optimized CSS animations
Multidevice first-login issue	Store flag in DB not localStorage


⭐ OVERVIEW OF YOUR MASTER EXCEL TEMPLATE

It will contain 4 sheets:

Sheet 1 — README (Cosmic Blue Instruction Page)
Purpose: Welcome the user, explain the BORB, explain how to use the template, and reduce upload errors

Layout:

Deep cosmic-blue background (#0B0F1A equivalent Excel color)

Gold text headers (#D4AF37)

BORB logo positioned top-center (image)

Sections:

Welcome to The BORB Bulk Upload Gateway — Brief intro + what this file is used for

How to Use This Template (step-by-step) — Upload → Review → Approve Defaults → Report → Commit

Important Notes — Garbage in = garbage out, required fields marked with "*"

Validation Rules Summary — Numeric columns must be ≥ 0, dropdown restrictions, etc

Example Workflow — 1 row portfolio → 2 leads → 3 scenarios

Links — "Create portfolio manually", "Learn more" (placeholder)

No data validation here. Just presentation

Sheet 2 — Portfolios
Headers:
| row_id | name* | description | total_value | total_invested | total_loan | avg_noi | avg_cap_rate | avg_coc_return | avg_dcr |

Formatting:

Top header: gold background + bold + centered

Frozen top row

Cosmic-blue background under headers

Data validation:

Numeric columns: decimal >= 0

Required: name* must not be empty

Protection:

Header row locked

Data rows UNLOCKED

Sheet 3 — Leads
Headers:
| row_id | portfolio_id* | name* | address | city | state | zip_code | country | client_type | property_type | image_url |

Dropdowns:

client_type → buyer, seller, investor, other

property_type → single_family, multi_family, commercial, land, other

Formatting:

Header row: cosmic gold theme

Frozen top row

All fields unlocked except header

Useful conditional formatting:

Missing required fields highlighted in faint red

Sheet 4 — Scenarios
Headers (all your fields):
| row_id | portfolio_id* | lead_id* | name* | description | months | rented_units | total_units | monthly_rent | market_rent | concessions | ancillary_income | vacancy_rate | insurance_rate | maintenance_cost | management_fees | annual_interest_rate | utilities | market_value | other_costs | annual_tax_rate | loan_amount | down_payment | loan_term_years | purchase_price | closing_costs | renovation_expenses | total_cash_invested |

Validations:

All numeric fields → decimal >= 0

Required fields: portfolio_id*, lead_id*, name*

Sample row included:
| (blank) | 1 | 1 | Example Scenario | Example description | 12 | 8 | 10 | 1200 | 1400 | 0 | 100 | 0.05 | 0.02 | 0.08 | 0.10 | 0.06 | 150 | 250000 | 50 | 0.012 | 200000 | 50000 | 30 | 300000 | 8000 | 20000 | 75000 |

Protection:

Header locked

Data rows unlocked

⭐ BONUS: HIDDEN SHEET FOR LISTS (Professional Setup)
Add a hidden sheet:

Sheet: _lists (hidden)

Contains lists:

text
A1: buyer
A2: seller
A3: investor
A4: other

B1: single_family
B2: multi_family
B3: commercial
B4: land
B5: other
Dropdowns reference this dynamic named range:

=client_type_list

=property_type_list

This is how enterprise Excel templates are done

EXCEL VALIDATION RULES:
📌 PORTFOLIOS SHEET
Column	Rule
row_id	Whole number ≥ 1
name*	Text (non-empty)
total_value	Decimal ≥ 0
total_invested	Decimal ≥ 0
total_loan	Decimal ≥ 0
avg_noi	Decimal ≥ 0
avg_cap_rate	Decimal ≥ 0
avg_coc_return	Decimal ≥ 0
avg_dcr	Decimal ≥ 0
📌 LEADS SHEET
Column	Rule
row_id	Whole number ≥ 1
portfolio_id*	Whole number ≥ 1 (must match an existing Portfolio row_id)
name*	Text (non-empty)
client_type	Dropdown: buyer, seller, investor, other
property_type	Dropdown: single_family, multi_family, commercial, land, other
zip_code	Text or Whole number (optional)
📌 SCENARIOS SHEET
Required ID mappings
Column	Rule
row_id	Whole number ≥ 1
portfolio_id*	Whole number ≥ 1 (must match Leads → portfolio_id)
lead_id*	Whole number ≥ 1 (must match Leads → row_id)
name*	Text (non-empty)
Numeric fields (ALL must be decimal ≥ 0)
Apply validation: Decimal → ≥ 0

months

rented_units

total_units

monthly_rent

market_rent

concessions

ancillary_income

vacancy_rate

insurance_rate

maintenance_cost

management_fees

annual_interest_rate

utilities

market_value

other_costs

annual_tax_rate

loan_amount

down_payment

loan_term_years

purchase_price

closing_costs

renovation_expenses

total_cash_invested

📌 EXTRA NOTES
Fields that must NOT be numeric
name

description

Optional defaults the system auto-fills
(Users may leave blank; Borb fills them)

vacancy_rate

insurance_rate

maintenance_cost

management_fees

annual_interest_rate

loan_term_years