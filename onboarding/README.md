
Onboarding & Dashboard Access Control
Overview
Secure, server-side validation system that prevents users from accessing the dashboard until they complete data upload during onboarding. The system uses a database-first approach with clear user messaging.

File Structure
text
app/
├── components/
│   └── DashboardGuard.tsx      # Server-side access control
├── dashboard/
│   ├── page.tsx               # Main dashboard (protected)
│   └── welcome/
│       └── page.tsx           # Onboarding page
└── api/
    └── user/
        └── onboarding/
            ├── status/        # GET onboarding status
            ├── step/          # POST mark step complete
            └── complete/      # POST complete onboarding
Key Components
1. DashboardGuard.tsx
typescript
'use server';
// Server-side check before dashboard access
// Returns: Redirect to /dashboard/welcome if no data uploaded
2. API Endpoints
GET /api/user/onboarding/status - Check data_uploaded status

POST /api/user/onboarding/step - Mark onboarding steps

POST /api/user/onboarding/complete - Finalize onboarding

3. Database Schema
sql
-- Users table must have:
data_uploaded BOOLEAN DEFAULT FALSE
onboarding_steps_completed JSONB DEFAULT '[]'
User Journey
New User (No Data Uploaded)
Signs up → Redirected to /dashboard/welcome

Sees "Upload data required" message

Uploads data via onboarding flow

data_uploaded set to TRUE in database

Can now access /dashboard

Returning User (Data Uploaded)
Logs in → Direct access to /dashboard

No interruptions

Admin User
Always has dashboard access

Bypasses data_uploaded check

Security Features
✅ Server-Side Validation - No client-side bypass

✅ Database-First - Single source of truth

✅ Role-Based Access - Admins bypass restrictions

✅ No Layout Changes - Existing layout.tsx untouched

✅ Graceful Failure - API issues redirect to welcome page

Implementation Steps
Phase 1: Basic Protection
Add DashboardGuard to /dashboard/page.tsx

Add conditional message to welcome page

Phase 2: Extended Protection (Optional)
Add guard to other dashboard sub-pages

Add client-side UI feedback in navigation

Phase 3: Monitoring
Log onboarding completion events

Track dashboard access attempts

Error Handling
Scenario	Action
API fails to respond	Redirect to welcome page
User not logged in	Redirect to /login
Database connection lost	Redirect to welcome page
Missing data_uploaded field	Treat as FALSE
Testing Checklist
New user cannot access /dashboard

User with data can access /dashboard

Admin can always access /dashboard

Message shows on welcome page when needed

No console errors in browser

API endpoints return correct status

Database updates persist correctly

Maintenance Notes
Schema Changes: Any update to users table must preserve data_uploaded

API Changes: Keep backward compatibility for existing clients

Logging: Monitor /api/user/onboarding/status calls for anomalies

Performance: Consider caching for frequent dashboard users

Rollback Plan
If issues arise:

Remove DashboardGuard calls from pages

System reverts to unrestricted access

No data loss or breaking changes

Last Updated: [Current Date]
Version: 1.0
Status: ✅ Production Ready