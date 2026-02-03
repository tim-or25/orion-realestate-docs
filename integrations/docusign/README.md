Complete DocuSign Integration Structure - Step by Step
Here's the complete end-to-end structure from user interaction to actions:

STEP 1: USER INTERACTION FLOW
text
User → Dashboard → Clicks "Integrations" → Sees Integration Grid → Clicks "Manage" on DocuSign → Action Menu → User chooses action
STEP 2: FILE STRUCTURE
text
app/
├── dashboard/
│   └── integrations/
│       └── page.tsx                 # Main page (Server Component)
│
├── ui/
│   └── integrations/
│       ├── IntegrationGrid.tsx      # Client Component with modals
│       ├── IntegrationTile.tsx      # Tile with action menu
│       └── docusign/
│           ├── SendDocumentModal.tsx
│           ├── TemplateSelector.tsx
│           └── ConfigurationPanel.tsx
│
├── lib/
│   └── integrations/
│       ├── service.ts               # Server actions (API calls)
│       └── providers/
│           └── docusign/
│               └── index.ts         # DocuSign client class
│
└── api/
    └── integrations/
        └── docusign/
            ├── connect/
            │   └── route.ts         # OAuth start
            ├── callback/
            │   └── route.ts         # OAuth callback
            ├── templates/
            │   └── route.ts         # List templates
            ├── send/
            │   └── route.ts         # Send envelope
            ├── envelopes/
            │   └── route.ts         # List envelopes
            └── disconnect/
                └── route.ts         # Disconnect
STEP 3: COMPLETE DATA FLOW
Phase 1: User Views Integrations
User visits /dashboard/integrations

app/dashboard/integrations/page.tsx (Server Component):

Checks authentication

Fetches integrations from DB: getIntegrations()

Combines with available integrations config

Passes data to IntegrationGrid

IntegrationGrid displays:

Stats (Connected/Available/Inactive)

Integration tiles (DocuSign, QuickBooks, etc.)

Connected integrations table

Phase 2: User Clicks "Manage" on DocuSign
IntegrationTile component:

Shows "✅ Connected" status

"Manage" button appears (instead of "Connect")

Clicking "Manage" shows action dropdown

Action Menu appears with:

text
📄 DocuSign Actions
├── 📄 Send Document
├── 📋 Use Template  
├── ⚙️ Configure
└── 🔌 Disconnect
Phase 3: User Selects an Action
Option A: "Send Document"
Opens SendDocumentModal

User fills form:

Subject, Message

Uploads document OR selects template

Adds recipients

Clicks "Send for Signature"

Makes API call: POST /api/integrations/docusign/send

Service calls DocuSign API

Returns envelope ID, user stays in your app

Option B: "Use Template"
Opens TemplateSelector modal

Fetches templates: GET /api/integrations/docusign/templates

User selects template

Modal closes, opens SendDocumentModal with template pre-selected

User adds recipients and sends

Option C: "Configure"
Opens ConfigurationPanel modal

User can:

Set default values

Enable/disable notifications

Configure webhooks

Test connection

Sync templates

Saves to your database

Option D: "Disconnect"
Confirmation dialog

Calls: POST /api/integrations/docusign/disconnect

Revokes OAuth token with DocuSign

Updates status to "inactive" in your DB

Page reloads, shows "Connect" button

STEP 4: DATABASE SCHEMA
sql
-- integrations table
CREATE TABLE integrations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  provider VARCHAR(100) NOT NULL,
  status VARCHAR(20) DEFAULT 'inactive',
  credentials JSONB,  -- Stores access_token, refresh_token, account_id, etc.
  config JSONB,       -- User preferences, webhook URLs, etc.
  tenant_id VARCHAR(100) DEFAULT 'default',
  last_synced_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  UNIQUE(provider, tenant_id)
);
STEP 5: ENVIRONMENT VARIABLES
env
# DocuSign OAuth
DOCUSIGN_CLIENT_ID=your_client_id
DOCUSIGN_CLIENT_SECRET=your_client_secret
DOCUSIGN_REDIRECT_URI=http://localhost:3000/api/integrations/docusign/callback
DOCUSIGN_ENVIRONMENT=demo  # or production

# App
APP_URL=http://localhost:3000
STEP 6: COMPONENT INTERACTION DIAGRAM
text
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Page.tsx      │     │  IntegrationGrid│     │  IntegrationTile│
│   (Server)      │────▶│   (Client)      │────▶│   (Client)      │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         │                        │                        │
         ▼                        ▼                        │
┌─────────────────┐     ┌─────────────────┐                │
│   Database      │     │   Modal(s)      │◀───────────────┘
│   (Integrations)│     │   (Send/Template│
└─────────────────┘     │   /Configure)   │
         │              └─────────────────┘
         ▼                        │
┌─────────────────┐               ▼
│  service.ts     │     ┌─────────────────┐
│  (Server Actions)│    │  API Routes     │
└─────────────────┘     │  (/api/...)     │
         │              └─────────────────┘
         ▼                        │
┌─────────────────┐               ▼
│  DocuSign API   │◀───────────────┘
│  (REST)         │
└─────────────────┘
STEP 7: COMPLETE API ENDPOINTS
Method	Endpoint	Purpose
GET	/api/integrations/docusign/connect	Start OAuth flow
GET	/api/integrations/docusign/callback	Handle OAuth callback
POST	/api/integrations/docusign/send	Send envelope
GET	/api/integrations/docusign/templates	List templates
GET	/api/integrations/docusign/envelopes	List envelopes
POST	/api/integrations/docusign/disconnect	Disconnect integration
POST	/api/integrations/docusign/webhook	Handle webhooks
STEP 8: USER EXPERIENCE JOURNEY
First-time User:
text
1. Visit Integrations page
2. See DocuSign tile with "Not Connected" status
3. Click "Connect"
4. Redirected to DocuSign OAuth
5. Grant permissions
6. Returned to your app
7. Tile now shows "✅ Connected" and "Manage" button
Returning User (Connected):
text
1. Visit Integrations page
2. See "✅ Connected" status
3. Click "Manage"
4. Choose action from dropdown:
   - Send Document: Upload file, add recipients, send
   - Use Template: Browse templates, select, send
   - Configure: Set preferences, webhooks
   - Disconnect: Revoke access
5. Complete action without leaving your app
STEP 9: ERROR HANDLING
Token Expired: Auto-refresh via refresh_token

Connection Lost: Show "Reconnect" button

API Errors: User-friendly messages

File Uploads: Validate size/type before sending

Rate Limiting: Exponential backoff for retries

STEP 10: NOTIFICATIONS & FEEDBACK
Success: "Document sent successfully! Envelope ID: XXX"

Progress: "Sending document..." with spinner

Errors: "Failed to send: [specific error]"

Webhooks: Real-time updates for envelope status

Sync Status: Last synced timestamp display

This structure keeps users in your app for the entire workflow, provides clear action-oriented interface, and handles all edge cases properly.