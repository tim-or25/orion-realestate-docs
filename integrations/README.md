Project Structure

src/
├── app/
│   ├── api/
│   │   └── integrations/
│   │       ├── costar/
│   │       ├── quickbooks/
│   │       └── docusign/
│   └── dashboard/
│       └── integrations/
├── lib/
│   ├── integrations/
│   │   ├── core/base-integration.ts
│   │   ├── providers/
│   │   │   ├── costar/
│   │   │   ├── quickbooks/
│   │   │   ├── docusign/
│   │   │   └── index.ts
│   │   └── types.ts
│   └── utils/
└── ui
    ├── components/
        └── integrations/IntegrationCard.tsx


┌─────────────────────────────────────────────────────────────┐
│                    Client (Browser)                         │
└─────────────────────┬───────────────────────────────────────┘
                      │ HTTP Requests/Redirects
                      ▼
┌─────────────────────────────────────────────────────────────┐
│           API Routes (app/api/integrations/*)               │
│  • OAuth initiation & callback handling                     │
│  • HTTP request/response handling                           │
│  • Redirect management                                      │
│  • Cookie/session management                                │
└─────────────────────┬───────────────────────────────────────┘
                      │ Calls service functions
                      ▼
┌─────────────────────────────────────────────────────────────┐
│            Service Layer (lib/integrations/)                │
│  • Database operations (CRUD)                               │
│  • Business logic                                           │
│  • Reusable across app                                      │
│  • No HTTP concerns                                         │
└─────────────────────┬───────────────────────────────────────┘
                      │ SQL Queries
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                     Database                                │
└─────────────────────────────────────────────────────────────┘