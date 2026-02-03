# System Architecture & Flow

```tsx
┌────────────────────────────────────────────────────────────┐
│                    APPLICATION LOGGING                     │
│  ┌────────────────────────────────────────────────────┐    │
│  │  Log Levels:                                       │    │
│  │  • DEBUG    - Dev tracing (disabled in production) │    │
│  │  • INFO     - Business events, user actions        │    │
│  │  • WARN     - Unexpected but recoverable           │    │
│  │  • ERROR    - Failures needing attention           │    │
│  │  • AUDIT    - Security/Compliance events           │    │
│  │  • METRICS  - Performance monitoring               │    │
│  └────────────────────────────────────────────────────┘    │
└──────────────────┬─────────────────────────────────────────┘
                   │
┌──────────────────▼───────────────────────────────────────────┐
│                 MEMORY BUFFER (5MB queue)                    │
│           • Async, non-blocking log collection               │
│           • Batch writes for performance                     │
└──────────────────┬───────────────────────────────────────────┘
                   │
         ┌─────────┴─────────┐
         │                   │
┌────────▼─────────┐ ┌───────▼───────┐
│  FILE STORAGE    │ │  CONSOLE      │
│  • Local disk    │ │  • Dev output │
│  • Structured    │ └───────────────┘
│  • Rotated       │
└────────┬─────────┘
         │
┌────────▼─────────────────────────────────────────┐
│             DUAL ROTATION SYSTEM                 │
│  ┌─────────────────────────────────────────┐     │
│  │  Time-based: Daily                      │     │
│  │  Size-based: 100MB per file             │     │ 
│  └─────────────────────────────────────────┘     │
└────────┬─────────────────────────────────────────┘
         │
┌────────▼─────────────────────────────────────────┐
│           RETENTION & ARCHIVAL                   │
│  ┌───────────────────────────────────────────┐   │
│  │  • 30 days HOT - Immediate access         │   │
│  │  • 90 days WARM - Compressed local        │   │
│  │  • 1 year COLD - Archived cheap storage   │   │
│  │  • 1 year DELETE (or keep for compliance) │   │
│  └───────────────────────────────────────────┘   │
└────────┬─────────────────────────────────────────┘
         │
┌────────▼────────────────────────────────────────┐
│        CENTRALIZED SYSTEMS (Optional)           │
│  • ELK Stack / Splunk for monitoring            │
│  • Real-time alerts & dashboards                │
│  • Cross-service correlation                    │
└─────────────────────────────────────────────────┘
```


## File Structure

```tsx
logs/
├── production/                    # Current environment
│   ├── app-2024-01-15.log        # Daily rotation
│   ├── errors-2024-01-15.log     # Error-only logs
│   ├── audit-2024-01-15.log      # Compliance logs
│   └── metrics-2024-01-15.log    # Performance logs
├── staging/                      # Same structure
└── archive/                      # Compressed logs >30 days
    ├── production-2024-01-01.tar.gz
    ├── production-2024-01-02.tar.gz
    └── ...
```

## Directory structure

```tsx
app/lib/logging/
├── config.ts          # Configuration manager
├── rotation.ts        # Rotation manager
├── next-integration.ts # Next.js helpers
├── cleanup.ts         # Cleanup script
├── summary.ts         # Summary script
├── test-config.ts     # Config test
└── test-rotation.ts   # Rotation test
```

## Test the scripts:
```bash
# Show summary
npx tsx app/lib/logging/summary.ts

# Dry run cleanup
npx tsx app/lib/logging/cleanup.ts --dry-run

# Or use npm scripts if you added them
npm run logs:summary
```
