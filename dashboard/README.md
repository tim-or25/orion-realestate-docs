# 🌌 The Orion Dashboard Philosophy

## 1️⃣ Concept

**Goal:** Instantly show users the pulse of their portfolio — how many assets they control, which ones perform best or worst, and what's changing right now.

**Tone:** Dark-slate interface • Electric-blue accents • Subtle glow under cards • Smooth micro-animations — like data breathing.

## 🏗️ Layout

| Dashboard Section | Description |
|-------------------|-------------|
| Orion Rigel Overview | Date + greeting |
| Cards Row | Total Leads | Total Scenarios | Avg ROI | Δ24h |
| Graph Section | Leads vs Scenario Count (Bar/Line chart) |
| Graph Tooltip | ↑ tooltip with ratios + ROI trend |
| Two-Column Left | Best / Worst Performing Leads (ROI) |
| Two-Column Right | Latest Updates (Scenarios created/edited) |
| AI Insights | Optional placeholder for upcoming analysis |
text

## 🧮 2️⃣ Data Flow

`getDashboardData()` server action aggregates:

- Count of Leads and Scenarios for the current user
- For each Lead: latest Scenario and ROI
- Highest and lowest ROI leads
- Recent scenario activity (ORDER BY updated_at DESC LIMIT 5)

**Graph:** Uses recharts (BarChart, LineChart) to show number of scenarios per lead + ROI trend.

## 🧠 Future AI Panel

Later, this area will host:

1. "Top 3 actions to improve ROI this month"
2. "Market rent deviation vs peers"
3. "Cashflow forecast anomalies"

Powered by your AI-analysis engine