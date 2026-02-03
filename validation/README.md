Formula Testing Workbench - Documentation
📋 Overview
The Formula Testing Workbench is a standalone tool for validating real estate KPI calculation formulas against spreadsheet data. It allows users to upload spreadsheets containing scenario inputs and expected KPI values, then compares them with formulas calculated by the system.

Key Features:

CSV/Excel spreadsheet upload with drag-and-drop

Configurable tolerance settings per KPI

Color-coded results (Green/Yellow/Red)

Expandable rows showing inputs and discrepancy analysis

No database storage - pure in-memory validation

Export results to CSV

🏗️ Architecture
text
Frontend (React/Next.js)
├── ValidationControlCenter (Main component)
├── FormulaTestingTab (Workflow orchestration)
├── SpreadsheetUploader (File upload UI)
├── ToleranceConfigurator (Tolerance settings)
└── FormulaResultsTable (Results display)

Backend (Next.js API Routes)
├── /api/validation/test-formulas (Main endpoint)
│   ├── POST: Process uploaded spreadsheet
│   └── GET: Download CSV template

Business Logic
├── /lib/kpi-validation/formula-testing-types.ts (TypeScript interfaces)
├── /lib/kpi-validation/tolerance-config.ts (Tolerance logic)
├── /lib/kpi-validation/discrepancy-analyzer.ts (Analysis logic)
├── /lib/kpi-validation/spreadsheet-parser.ts (CSV parsing)
└── /lib/finance/computeMetrics.ts (KPI formulas - EXISTING)

Data Flow
CSV Upload → Parse → computeMetrics() → Compare → Display Results
📁 File Structure
text
app/
├── api/
│   └── validation/
│       └── test-formulas/
│           └── route.ts              # Main API endpoint
├── ui/
│   └── validation/
│       ├── ValidationControlCenter.tsx  # Main component
│       ├── FormulaTestingTab.tsx        # Testing workflow
│       ├── SpreadsheetUploader.tsx      # File upload UI
│       ├── ToleranceConfigurator.tsx    # Tolerance settings
│       └── FormulaResultsTable.tsx      # Results display
└── lib/
    └── kpi-validation/
        ├── formula-testing-types.ts     # TypeScript interfaces
        ├── tolerance-config.ts          # Tolerance configuration
        ├── discrepancy-analyzer.ts      # Discrepancy analysis
        └── spreadsheet-parser.ts        # CSV/Excel parsing
🔧 Core Components
1. API Endpoint (/api/validation/test-formulas)
Purpose: Process uploaded spreadsheets and run formula validation
Input: CSV/Excel file with scenario inputs and expected KPIs
Output: JSON report with comparisons and analysis
Dependencies: computeMetrics.ts (existing KPI formulas)

2. Spreadsheet Parser
Format: CSV with headers
Required Columns:

Input columns: Match scenarios table schema (e.g., monthly_rent, loan_amount)

Expected KPI columns: Prefixed with expected_ (e.g., expected_net_operating_income)

3. Tolerance System
Default Tolerances:

Income/Expense metrics: $100-$500 absolute or 1-3% relative

Return metrics: 0.25-1% relative (e.g., Cap Rate: 0.25%)

Ratios: 1-5% relative (e.g., DSCR: 5%)

Configurable: Users can override per-KPI via UI

4. Discrepancy Analysis
Automated Checks:

Interest rate interpretation (percentage vs decimal)

Monthly vs annual amounts

KPI-specific common issues

Rounding differences

📊 CSV Format
Template Structure:
csv
scenario_name,months,rented_units,total_units,monthly_rent,market_rent,market_value,annual_tax_rate,loan_amount,down_payment,annual_interest_rate,loan_term_years,purchase_price,total_cash_invested,expected_net_operating_income,expected_capitalization_rate,expected_cash_on_cash_return,expected_debt_service_coverage_ratio,expected_loan_to_value_ratio
Example Property,12,8,10,1500,1600,1200000,0.012,800000,200000,0.055,30,1000000,250000,60000,0.05,0.08,1.25,0.67
Column Naming:
Input columns: Use exact names from scenarios table schema

Expected KPI columns: Prefix with expected_ + KPI name from kpis table

Data Types:
Percentages: As decimals (0.055 for 5.5%, not 5.5)

Currency amounts: As numbers without formatting

Ratios: As decimals (0.67 for 67% LTV)

⚙️ Configuration
Tolerance Settings
Location: /lib/kpi-validation/tolerance-config.ts

typescript
export const DEFAULT_TOLERANCES = {
  net_operating_income: { 
    kpiName: 'net_operating_income', 
    absoluteTolerance: 500,           // $500
    percentageTolerance: 0.02         // 2%
  },
  capitalization_rate: {
    kpiName: 'capitalization_rate',
    percentageTolerance: 0.0025       // 0.25%
  },
  // ... other KPIs
}
Adding New KPI Support
Add to formula-testing-types.ts interfaces

Add tolerance in tolerance-config.ts

Add analysis logic in discrepancy-analyzer.ts (optional)

🔍 How Formulas Are Tested
Process Flow:
text
1. User uploads CSV
2. Parse each row into {inputs, expectedKPIs}
3. For each row:
   a. Call computeMetrics(inputs) → get calculated KPIs
   b. For each expected KPI:
      - Compare calculated vs expected
      - Apply tolerance rules
      - Generate discrepancy analysis (if outside tolerance)
4. Compile results and return to UI
Comparison Logic:
Pass: Within tolerance (Green)

Warning: 1-5x tolerance limit (Yellow)

Error: >5x tolerance limit (Red)

🐛 Common Issues & Troubleshooting
1. "KPI not calculated" warnings
Cause: KPI name in CSV doesn't match computeMetrics output
Fix: Check KPI name mappings in spreadsheet-parser.ts

2. Large percentage differences
Possible causes:

Decimal vs percentage confusion (0.055 vs 5.5)

Monthly vs annual amounts

Different formula definitions

Debug: Use expandable row to see inputs and analysis

3. CSV parsing errors
Check:

File encoding (UTF-8)

Column headers match exactly

No empty rows

Numbers formatted correctly (no currency symbols)

4. TypeScript compilation errors
Likely fixes:

Update import paths

Add missing type definitions

Install missing dependencies (csv-parse)

🔄 Maintenance Tasks
Regular:
Update tolerances based on business requirements

Add new KPI analyses as common issues are identified

Test with new formula versions when computeMetrics.ts is updated

When Formulas Change:
Update expected values in test spreadsheets

Verify tolerance settings still appropriate

Add new discrepancy analysis for changed calculations

Performance Considerations:
Current: In-memory processing, suitable for 100s of scenarios

Large files: Consider streaming processing if >1000 scenarios

Memory: No persistent storage, resets on page refresh

📈 Extending the System
Adding Export Formats:
Modify FormulaResultsTable.tsx export function

Add options for Excel, PDF, JSON

Use libraries: xlsx for Excel, jspdf for PDF

Adding Batch Processing:
Create queuing system for large files

Add progress tracking

Implement background processing with Web Workers

Adding Historical Comparisons:
Store results in localStorage

Add comparison between runs

Track formula changes over time

🔒 Security Considerations
File Upload:
Validates file types (CSV, Excel only)

Limits file size (configurable)

Sanitizes input data

Data Handling:
No PII stored (only financial inputs)

No database persistence

All processing in memory

API Protection:
Rate limiting recommended

Authentication via existing Next.js middleware

🧪 Testing Strategy
Unit Tests Needed:
Spreadsheet parser - Various CSV formats

Tolerance logic - Edge cases (zero values, negatives)

Discrepancy analyzer - Common error patterns

API endpoint - Error handling, file validation

Integration Tests:
Full workflow - Upload → Process → Display

Formula accuracy - Known test scenarios

UI interactions - Expand/collapse, filtering

Sample Test Data:
Create test CSV files with:

Edge cases (zero values, negative numbers)

Common errors (percentage vs decimal)

Large datasets (performance testing)

Malformed data (error handling)

📞 Support & Contact
For Formula Issues:
Check computeMetrics.ts calculations

Compare with external calculators

Review discrepancy analysis suggestions

For System Issues:
Check browser console for errors

Test API directly with Postman

Review server logs

Development Team:
Maintainers: [Your Team Name]

Last Updated: [Date]

Version: 1.0.0

Note: This system is designed for formula validation only, not production data processing. It does not connect to your production database or modify any persistent data.