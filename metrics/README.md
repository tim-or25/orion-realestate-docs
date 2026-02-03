# 🧠 ORION MONITORING SUITE
### Real-Time Intelligence for AI-Driven Real Estate Analytics

## 📁 Folder Structure
```
app/
 ├─ lib/
 │   ├─ metrics/
 │   │   ├─ computeMetrics.ts
 │   │   └─ AIIndex.ts
 │   ├─ alerts/
 │   │   └─ useAlerts.tsx
 │   └─ monitoring/
 │       └─ SystemMonitorService.ts
 ├─ ui/
 │   └─ system/
 │       ├─ OrionTrendChart.tsx
 └─ dashboard/
     └─ system/
         ├─ SystemClient.tsx
         └─ page.tsx
tests/
 └─ systemMonitoring.test.ts
```

## ⚙️ Installation
```bash
pnpm add recharts vitest jsdom @types/node
```

## 🧩 Components
Each module is self-contained:
- **computeMetrics.ts:** Computes Cap Rate, NOI, ROI, CoC, etc.
- **AIIndex.ts:** Scores property health with weighted AI index.
- **useAlerts.tsx:** Displays red/yellow/green alerts.
- **SystemMonitorService.ts:** Tracks actions for telemetry.
- **OrionTrendChart.tsx:** Visualizes live metric trends.
- **SystemClient.tsx:** Main real-time dashboard UI.
- **page.tsx:** System page wrapper with gradient theme.
- **systemMonitoring.test.ts:** Vitest suite verifying formulas.

`computeMetrics.ts`

Core engine that computes property metrics:

- Cap Rate
- Cash-on-Cash Return
- Debt Coverage Ratio (DCR)
- Return on Investment (ROI)
- Net Operating Income (NOI)
- Gross Rent Multiplier (GRM)

Returns both raw and rounded values, plus normalized ratios for AI scoring.

`AIIndex.ts`

Calculates a composite AI performance score (0–100) using weighted metrics:

- 25% Cap Rate
- 30% Cash-on-Cash
- 30% DCR
- 15% NOI Margin

Yields both numeric score and qualitative verdict (excellent, stable, weak).

`useAlerts.tsx`

Real-time alerting hook that:
- Evaluates metric thresholds (red, yellow, green)
- Provides a visual chip (AI Index score)
- Integrates into dashboards instantly
- SystemMonitorService.ts
- Lightweight in-memory telemetry tracker.
- Tracks activity events (ts, action, value)
- Retains the last 1000 actions
- Feeds real-time charts via the OrionTrendChart

`OrionTrendChart.tsx`

Professional Recharts line chart displaying real-time metric activity.
- Orion blue color palette
- Smooth axis and tooltip rendering
- Auto-updates with SystemMonitorService data

`SystemClient.tsx`
- Main live dashboard component for users.
- Displays metric list
- Integrates alerts and AI Index

Renders live system trend chart

`page.tsx`

System page entrypoint.

- Uses Orion gradient background
- Displays header, metrics, and trend chart
- Includes copyright footer

`systemMonitoring.test.ts`

Vitest-based suite validating all metrics and AI index accuracy.

- Confirms realistic metric bounds
- Confirms AI Index correctly ranks strength

Run tests with:
```bash
pnpm vitest run
```


## 📊 Usage

Add the System page to your dashboard nav:
```bash
<Link href="/dashboard/system">System</Link>
```
Run:
```bash
pnpm dev
```
Then visit:
```
http://localhost:3000/dashboard/system
```
You’ll see:

- Real-time metrics

- AI Index

- Orion-themed alert bar

- Live chart

## 🧪 Testing
```bash
pnpm vitest run --environment jsdom
```

Expected:

- All formulas pass precision checks

- AI index ranking verified

## 🔔 Alerts & Color Logic

| Metric | <span style="background-color: #22c55e; color: white; padding: 4px 8px; border-radius: 4px;">Green</span> | <span style="background-color: #eab308; color: white; padding: 4px 8px; border-radius: 4px;">Yellow</span> | <span style="background-color: #ef4444; color: white; padding: 4px 8px; border-radius: 4px;">Red</span> |
|--------|-------|--------|-----|
| Cap Rate | <span style="background-color: #dcfce7; color: #166534; padding: 4px 8px; border-radius: 4px;">≥5%</span> | <span style="background-color: #fef3c7; color: #92400e; padding: 4px 8px; border-radius: 4px;">4%–<5%</span> | <span style="background-color: #fecaca; color: #991b1b; padding: 4px 8px; border-radius: 4px;"><4%</span> |
| Cash-on-Cash | <span style="background-color: #dcfce7; color: #166534; padding: 4px 8px; border-radius: 4px;">≥6%</span> | <span style="background-color: #fef3c7; color: #92400e; padding: 4px 8px; border-radius: 4px;">4–6%</span> | <span style="background-color: #fecaca; color: #991b1b; padding: 4px 8px; border-radius: 4px;"><4%</span> |
| DCR | <span style="background-color: #dcfce7; color: #166534; padding: 4px 8px; border-radius: 4px;">≥1.25</span> | <span style="background-color: #fef3c7; color: #92400e; padding: 4px 8px; border-radius: 4px;">1.1–1.25</span> | <span style="background-color: #fecaca; color: #991b1b; padding: 4px 8px; border-radius: 4px;"><1.1</span> |

Each alert displays a color-coded chip and message.


# 🧠 Tooltip Guide — Orion Design Standard

## Purpose
Orion tooltips follow a **Bloomberg-inspired** design:
flat rectangular info bubbles that appear with a **fade + rise animation** on hover.
They are used to clarify complex metrics without breaking visual focus.

---

## ✅ Usage
```tsx
import OrionTooltip from '@/app/ui/OrionTooltip';

<OrionTooltip text="Explains the metric meaning" position="top">
  <span className="text-blue-300 cursor-help">Metric Name</span>
</OrionTooltip>
```

| Prop       | Type                         | Default | Description                                |
| ---------- | ---------------------------- | ------- | ------------------------------------------ |
| `text`     | `string`                     | —       | Tooltip content                            |
| `position` | `'top' \| 'right' \| 'left'` | `'top'` | Position relative to target                |
| `children` | `ReactNode`                  | —       | The element that triggers tooltip on hover |


### 🎨 Design Tokens

- Text: #E5E7EB

- Border: #2563EB (30 % opacity)

- Shadow: 0 4px 12px rgba(0,0,0,0.4)

- Animation: fade + rise (0.25 s ease-out)

- Shape: Flat rectangle (no arrow)

### ♿ Accessibility

- Tooltips appear on hover or keyboard focus.

- Non-blocking; disappears on mouseleave.

- Keep text concise (< 100 chars) for readability.

### 💡 Best Practices

- Use tooltips only for secondary explanations.

- Avoid stacking multiple tooltips close together.

- Do not show tooltips for essential information.

- Maintain consistent positioning (usually top).

- Test readability under both dark/light variants.


### 🧠 What the Orion AI Index Represents
The AI Index is a proprietary performance indicator that translates complex financial metrics into one intuitive score — showing how efficiently a property performs from both an investment and operational standpoint.
It’s designed to help users quickly identify which assets are strong, stable, or underperforming.

### ⚙️ Formula (Conceptually Simplified)
Each property is scored on four weighted components:
MetricDescriptionWeightCap RateIncome yield relative to purchase price25%Cash-on-Cash ReturnAnnual cash flow compared to invested equity30%Debt Coverage Ratio (DCR)Loan payment safety margin30%NOI MarginProfitability after expenses15%
The AI Index then normalizes these values and produces a score between 0–100, which is classified as:
Score RangeRatingMeaning80–100🟢 ExcellentStrong profitability, safe leverage60–79🟡 StableBalanced return, acceptable risk<60🔴 WeakLow returns or high risk exposure

### 📊 How to Present It in the Dashboard
When displayed in Orion’s interface:

Use a color-coded circular gauge (green/yellow/red)

Include both the numeric score (e.g., 78/100) and the qualitative verdict (“Stable Performance”)

Optionally display key drivers below:
“Cap Rate: 7.5% · CoC: 9.2% · DCR: 1.28 · NOI Margin: 32%”



### 🧩 How It Helps Users


At-a-Glance Comparison — Users can instantly see which scenarios or properties outperform others.

Decision Intelligence — The AI Index bridges raw data with actionable insights, making it easier to decide whether to refinance, sell, or invest.

Automation-Ready — The score can power smart recommendations, such as:

“Increase rent by 5% to raise AI Index from 68 → 74”

“Reduce expenses by $3,000/yr to reach ‘Excellent’ category.”


### 🔬 Technical Validity

Each metric in the formula is industry-recognized and mathematically consistent.

The weighting can be easily tuned using historical data or regression models once Orion gathers user data.

Because the metrics are normalized, properties of different price tiers (e.g., $300k duplex vs $3M building) remain comparable.



### 🧾 Suggested Explanation for Orion UI

“The AI Index is a single composite score derived from income performance, leverage safety, and cash efficiency.
It helps investors quickly evaluate property health and make data-driven decisions — without analyzing dozens of metrics manually.”


## 🎨 Design
- **Theme:** Orion Blue  
- **Colors:** `#0f172a → #1e293b → #111827`  
- **Accent:** `#60a5fa`, `#8aa6ff`, text `#c9d7ff`

Flat, professional, minimal design with no heavy gradients — aligned with Orion Rigel branding.



## 🧩 Future Extensions

You can easily extend this system with:

- Push/email alert service

- Role-based data visibility

- Historical persistence via Supabase or MongoDB


Do not show tooltips for essential information.

Maintain consistent positioning (usually top).

Test readability under both dark/light variants.




## 🧾 Credits
Developed for **Orion Rigel LLC** — “Empowering Intelligence Through Real Estate Innovation.”
Ecosystem: 3E — Envision, Engineer, Execute
