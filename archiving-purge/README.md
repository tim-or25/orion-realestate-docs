# Admin Archive/Purge System

A secure, hierarchical data management system for administrators to archive, restore, and purge user data with full audit compliance and cascade logic.

---

## 📋 Features & Capabilities

### 1. User Search & Data Hierarchy
- **User Search** – Find users by name or email to locate their data.
- **Tree View Display** – Visual hierarchy:  
  **Portfolios → Leads → Scenarios → KPIs**
- **Batch Operations** – Checkboxes at each level for bulk actions.
- **Expand/Collapse** – Navigate nested structures easily.

### 2. Archive Management *(Regular Admin)*
- **Preview Archive** – View cascade effects before executing.
- **Batch Archive** – Select multiple items and archive simultaneously.
- **Cascade Logic**:
  - Archive portfolio → archive its leads, scenarios, KPIs.
  - Archive lead → archive its scenarios, KPIs.
  - Archive scenario → archive its KPIs.
- **Archive View Tab** – Browse all archived items.
- **Restore Functionality** – Restore items with original hierarchy intact.
- **Conflict Handling** – Detect and resolve name conflicts during restore.

### 3. Purge Management *(Senior Admin Only)*
- **Restricted Access** – Available only with senior admin privileges.
- **Archived Items Only** – Cannot purge active data directly.
- **Two-Step Verification** – Password + confirmation required.
- **Audit Trail Required** – Must provide a reason for purge.
- **Legal Hold Check** – Confirm no active litigation before proceeding.
- **Scheduled Purges** – Execution is deferred, not immediate.
- **Email Notifications** – Automatic alerts sent to compliance team.

### 4. Audit & Compliance Features
- **Complete Audit Trail** – Logs who, when, and why for every action.
- **Action History** – Track all archive, restore, and purge operations.
- **Data Lineage** – Maintain relational integrity in the archive.
- **Recovery Window** – Restore within a configurable period (X days) before permanent purge.

### 5. Admin Workflow
1. **Search User** → locate and view their data tree.
2. **Select Items** → preview cascade effects.
3. **Archive** → move to archive and remove from active views.
4. **View Archive** → review archived items and optionally restore.
5. **Senior Admin** → access purge section and schedule deletions.